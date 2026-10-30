/-
# The Referee

The referee is a small automated prover. The player never writes proofs. The
referee tries to settle each test about the player's definition in one of two
ways:

* prove the statement, or
* prove its negation.

It combines a little witness search (trying candidate values for `∃`-goals and
for instantiating `∀`-hypotheses) with core closing tactics (`omega`, `decide`,
`simp_all`, `grind`).

In a production version of the game this module is where a stronger prover,
such as an LLM prover, plugs in. The game design only assumes "proofs are
cheap", not that this particular prover is clever.
-/
import Mathlib.Tactic

open Lean Meta Elab Tactic Term Command

namespace LeanCraftGame

/-! ## Scoreboard -/

structure Score where
  passed : Nat := 0
  failed : Nat := 0
  unknown : Nat := 0
  deriving Inhabited, Nonempty

initialize scoreRef : IO.Ref Score ← IO.mkRef {}
/-- Set by `#no_sorry` when the player's definition is still missing. -/
initialize blockedRef : IO.Ref Bool ← IO.mkRef false

/-! ## Search -/

/-- Cheap closing tactics, tried in order at every node of the search. -/
def closers : TacticM (Array (String × TSyntax `tactic)) := do
  return #[("omega", ← `(tactic| omega)), ("decide", ← `(tactic| decide)),
    ("decide +kernel", ← `(tactic| decide +kernel)), ("positivity", ← `(tactic| positivity)),
    ("linarith", ← `(tactic| linarith)),
    ("simp_all <;> omega", ← `(tactic| (simp_all <;> omega))), ("grind", ← `(tactic| grind))]

/-- Mathlib's heavier closing tactics. They cost too much to run at every node, so only
the last, shallow pass of `settle` uses them (after the cheap closers). -/
def finishers : TacticM (Array (String × TSyntax `tactic)) := do
  return #[("norm_num", ← `(tactic| norm_num at *)), ("tauto", ← `(tactic| tauto)),
    ("nlinarith", ← `(tactic| nlinarith)),
    ("aesop", ← `(tactic| aesop (config := { terminal := true, maxRuleApplications := 200 })))]

/-- Per closing tactic: (calls, successes, milliseconds). Shown by `#referee_stats`. -/
initialize statsRef : IO.Ref (Std.HashMap String (Nat × Nat × Nat)) ← IO.mkRef {}

/-- Run `t` on the main goal; succeed only if it closes the goal completely. -/
def closesWith (name : String) (t : TSyntax `tactic) : TacticM Bool := do
  let t0 ← IO.monoMsNow
  let s ← saveState
  let ok ← tryCatchRuntimeEx
    (do
      withTheReader Core.Context (fun c => { c with maxHeartbeats := 20000 * 1000 }) <|
        withCurrHeartbeats <| focus do
          evalTactic t
          unless (← getUnsolvedGoals).isEmpty do throwError "not closed"
      if (← getUnsolvedGoals).isEmpty then return true
      s.restore; return false)
    (fun _ => do s.restore; return false)
  let dt := (← IO.monoMsNow) - t0
  statsRef.modify fun m =>
    let (c, k, ms) := m.getD name (0, 0, 0)
    m.insert name (c + 1, k + (if ok then 1 else 0), ms + dt)
  return ok

/-- Goals (pretty-printed) on which every closer already failed during the current test.
Iterative deepening visits the same goals again at every depth, and the closers are the
expensive part of the search. Skipping a goal can only lose a proof, never invent one. -/
initialize failedRef : IO.Ref (Std.HashSet String) ← IO.mkRef {}

/-- Closers for goals about ℚ or ℝ: numeric evaluation and absolute values. -/
def fieldClosers : TacticM (Array (String × TSyntax `tactic)) := do
  return #[("norm_num", ← `(tactic| norm_num at *)),
    ("norm_num [abs] <;> linarith",
      ← `(tactic| (norm_num [abs_lt, abs_le, le_abs, lt_abs] at * <;> linarith)))]

/-- Does the goal or a hypothesis involve ℚ or ℝ? -/
def mentionsField : TacticM Bool := do
  let g ← getMainGoal
  let isF (e : Expr) := (e.find? fun c => c.isConstOf ``Real || c.isConstOf ``Rat).isSome
  if isF (← instantiateMVars (← g.getType)) then return true
  return (← g.getDecl).lctx.any fun d => !d.isImplementationDetail && isF d.type

def tryClose (strong : Bool) : TacticM Bool := do
  let key := s!"{strong}{← Meta.ppGoal (← getMainGoal)}"
  if (← failedRef.get).contains key then return false
  let tactics := (← closers) ++ (← if ← mentionsField then fieldClosers else pure #[]) ++
    (← if strong then finishers else pure #[])
  for (name, t) in tactics do
    if ← closesWith name t then return true
  failedRef.modify (·.insert key)
  return false

/-- Try to prove a side condition `p` (such as `0 < ε`, `N ≤ n` or `x ∈ s`) with the
cheap closers. Leaves the goals as they were. -/
def proveSide (p : Expr) : TacticM (Option Expr) := do
  let m ← mkFreshExprMVar p
  let gs ← getGoals
  setGoals [m.mvarId!]
  let ok ← tryClose false
  setGoals gs
  if ok then return some (← instantiateMVars m) else return none

/-- Is `e` a structure-like hypothesis worth destructing (`∃`, `∧`, a structure)? -/
def isDestructible (ty : Expr) : MetaM Bool := do
  let ty ← whnfR ty
  match ty.getAppFn with
  | .const n _ =>
    if n == ``Exists || n == ``And then return true
    if n == ``Nat || n == ``Int || n == ``Bool || n == ``Fin then return false
    return isStructure (← getEnv) n
  | _ => return false

/-- Destruct every `∃`, `∧` and structure hypothesis. -/
partial def destructAll : TacticM Unit := do
  let g ← getMainGoal
  for d in (← g.getDecl).lctx do
    if d.isImplementationDetail then continue
    if ← isDestructible d.type then
      let gs ← g.cases d.fvarId
      if h : gs.size = 1 then
        replaceMainGoal [gs[0].mvarId]
        destructAll
        return

/-- Light normalisation: intro everything, beta-reduce, substitute, destruct. -/
def normalize : TacticM Unit := do
  try evalTactic (← `(tactic| repeat intro)) catch _ => pure ()
  try evalTactic (← `(tactic| simp only [ge_iff_le, gt_iff_lt, ne_eq, Set.subset_def, Set.mem_setOf_eq] at *)) catch _ => pure ()
  try evalTactic (← `(tactic| subst_vars)) catch _ => pure ()
  try destructAll catch _ => pure ()
  try evalTactic (← `(tactic| repeat intro)) catch _ => pure ()

/-- Candidate values of type `ty`: (values built from local variables, small numerals). -/
def candidates (ty : Expr) : TacticM (Array Expr × Array Expr) := do
  let ty ← whnfR ty
  if ty.isConstOf ``Bool then return (#[], #[mkConst ``Bool.true, mkConst ``Bool.false])
  let isNat := ty.isConstOf ``Nat
  let isInt := ty.isConstOf ``Int
  let isField := ty.isConstOf ``Rat || ty.isConstOf ``Real
  unless isNat || isInt || isField do return (#[], #[])
  let mut locals : Array Expr := #[]
  for d in (← getMainGoal >>= (·.getDecl)).lctx do
    if d.isImplementationDetail then continue
    if ← isDefEq d.type ty then locals := locals.push d.toExpr
  let lit (n : Nat) : MetaM Expr :=
    if isNat then pure (mkNatLit n) else mkAppOptM ``OfNat.ofNat #[ty, mkRawNatLit n, none]
  let mut out : Array Expr := #[]
  for x in locals do
    out := out.push x
    out := out.push (← mkAppM ``HAdd.hAdd #[x, ← lit 1])
    out := out.push (← mkAppM ``HMul.hMul #[← lit 2, x])
    out := out.push (← mkAppM ``HAdd.hAdd #[← mkAppM ``HMul.hMul #[← lit 2, x], ← lit 1])
    out := out.push (← mkAppM ``HSub.hSub #[x, ← lit 1])
    out := out.push (← mkAppM ``HSub.hSub #[x, ← lit 2])
  let mut nums : Array Expr := #[]
  for n in [0, 1, 2, 3, 4, 6, 100] do
    nums := nums.push (← lit n)
  if isField then nums := nums.push (← mkAppM ``HDiv.hDiv #[← lit 1, ← lit 2])
  return (out, nums)

/-- Depth-limited search. `fuel` bounds the number of witness choices on a branch.
With `strong`, negations in the goal are pushed inwards first (so that `¬ ∀ x, P x`
becomes `∃ x, ¬ P x` and the witness search applies), and Mathlib's heavier tactics
close the leaves. -/
partial def solve (fuel : Nat) (strong : Bool := false) : TacticM Unit := do
  if strong then
    try evalTactic (← `(tactic| push_neg)) catch _ => pure ()
  -- finite statements: decide them before introducing any variables
  if ← closesWith "decide (finite)" (← `(tactic| decide)) then return
  if ← closesWith "decide +kernel (finite)" (← `(tactic| decide +kernel)) then return
  normalize
  if (← getUnsolvedGoals).isEmpty then return
  if ← tryClose strong then return
  if fuel == 0 then throwError "out of fuel"
  let g ← getMainGoal
  g.withContext do
    let tgt ← whnfR (← instantiateMVars (← g.getType))
    -- split conjunctions
    if tgt.isAppOfArity ``And 2 then
      let s ← saveState
      try
        evalTactic (← `(tactic| constructor))
        let gs ← getGoals
        for sub in gs do
          setGoals [sub]
          solve fuel strong
        setGoals []
        return
      catch _ => s.restore
    -- the three kinds of moves, cheapest / most promising first
    let tryWitnesses (useNums : Bool) : TacticM Bool := do
      unless tgt.isAppOfArity ``Exists 2 do return false
      let α := tgt.getArg! 0
      let p := tgt.getArg! 1
      let (ls, ns) ← candidates α
      for c in (if useNums then ns else ls) do
        let s ← saveState
        try
          let body := (mkApp p c).headBeta
          let m ← mkFreshExprSyntheticOpaqueMVar body
          g.assign (← mkAppOptM ``Exists.intro #[α, p, c, m])
          setGoals [m.mvarId!]
          solve (fuel - 1) strong
          return true
        catch _ => s.restore
      return false
    let trySpecialize (useNums : Bool) : TacticM Bool := do
      for d in (← g.getDecl).lctx do
        if d.isImplementationDetail then continue
        let ty ← whnfR d.type
        if let .forallE _ dom _ _ := ty then
          if (← inferType dom).isProp then continue
          let (ls, ns) ← candidates dom
          -- from local variables: x, x + 1, 2x and 2x + 1 (the doubles reach the even and
          -- odd terms of sequences defined by parity, such as `n % 2 * n`)
          for c in (if useNums then ns else ls.filter (fun e => e.isFVar || e.isAppOfArity ``HAdd.hAdd 6
              || e.isAppOfArity ``HMul.hMul 6)) do
            let s ← saveState
            try
              let mut e := mkApp d.toExpr c
              let mut ety := (← instantiateForall ty #[c]).headBeta
              -- discharge side conditions such as `0 < ε`, `N ≤ n` or `x ∈ s`
              repeat
                match ← whnfR ety with
                | .forallE _ p q _ =>
                  if q.hasLooseBVars || !(← inferType p).isProp then break
                  match ← proveSide p with
                  | some pf => e := mkApp e pf; ety := q
                  | none => break
                | _ => break
              let (_, g') ← (← g.assert `spec ety e).intro1P
              setGoals [g']
              solve (fuel - 1) strong
              return true
            catch _ => s.restore
      return false
    -- use a negated hypothesis `h : ¬ Q` to close `False`: it is enough to prove `Q`.
    -- The hypothesis is cleared on that branch, so the move cannot repeat itself.
    let tryNegHyp : TacticM Bool := do
      unless tgt.isConstOf ``False do return false
      for d in (← g.getDecl).lctx do
        if d.isImplementationDetail then continue
        let ty ← whnfR d.type
        let some q := ty.not? | continue
        let s ← saveState
        try
          let m ← mkFreshExprSyntheticOpaqueMVar q
          g.assign (mkApp d.toExpr m)
          let m' ← m.mvarId!.clear d.fvarId
          setGoals [m']
          solve (fuel - 1) strong
          return true
        catch _ => s.restore
      return false
    -- a goal `False` with a hypothesis `¬ Q` usually comes from refuting a conjunction
    -- such as "the mutant accepts every good sequence and rejects every bad one": the
    -- cheapest route is to prove `Q`, so that move goes first
    if ← tryNegHyp then return
    if ← trySpecialize false then return
    if ← tryWitnesses false then return
    if ← tryWitnesses true then return
    if ← trySpecialize true then return
    throwError "search failed"

/-- One attempt: prove `P` after unfolding the given definitions (throws on failure). -/
def proveCore (P : Expr) (unfolds : Array Ident) (fuel : Nat) (strong : Bool) : TermElabM Bool := do
  let m ← mkFreshExprSyntheticOpaqueMVar P
  let rest ← withTheReader Core.Context (fun c => { c with maxHeartbeats := 400000 * 1000 }) <|
    withCurrHeartbeats <| Tactic.run m.mvarId! (do
      for id in unfolds do
        try evalTactic (← `(tactic| unfold $id:ident)) catch _ => pure ()
      solve fuel strong)
  let r ← instantiateMVars m
  return rest.isEmpty && !r.hasSyntheticSorry && !r.hasSorry && !r.hasExprMVar

/-- Try to prove `P`; never throws, always restores the state. -/
def tryProve (P : Expr) (unfolds : Array Ident) (fuel : Nat) (strong := false) : TermElabM Bool := do
  let s ← saveState
  let ok ← tryCatchRuntimeEx (proveCore P unfolds fuel strong) (fun _ => pure false)
  s.restore
  return ok

/-! ## Test commands -/

syntax unfoldClause := " unfolding " ident+

/-- `#expect_true "name" : P` — the definition should make `P` true. -/
syntax (name := expectTrue) "#expect_true " str (unfoldClause)? " : " term : command
/-- `#expect_false "name" : P` — the definition should make `P` false. -/
syntax (name := expectFalse) "#expect_false " str (unfoldClause)? " : " term : command
/-- `#expect_open "name" : P` — neither `P` nor `¬P` should be easy. -/
syntax (name := expectOpen) "#expect_open " str (unfoldClause)? " : " term : command
/-- `#expect_caught "name" : P` — a mutation test. `P` says that a wrong definition
(a *mutant*) agrees with every probe of the player's test suite. It should be false:
then some probe catches the mutant. -/
syntax (name := expectCaught) "#expect_caught " str (unfoldClause)? " : " term : command

def getUnfolds : Option (TSyntax ``unfoldClause) → Array Ident
  | some stx => match stx with
    | `(unfoldClause| unfolding $ids*) => ids
    | _ => #[]
  | none => #[]

def fuelDefault : Nat := 3
/-- Depth of the last, strong pass of `settle`. -/
def fuelStrong : Nat := 1

/-- Iterative deepening, alternating between `P` and `¬P`:
fuel 0 for `P`, fuel 0 for `¬P`, fuel 1 for `P`, … Returns `(proved, refuted)`. -/
def settle (P : Expr) (unfolds : Array Ident) : TermElabM (Bool × Bool) := do
  failedRef.set {}
  let nP := mkNot P
  for f in List.range (fuelDefault + 1) do
    if ← tryProve P unfolds f then return (true, false)
    if ← tryProve nP unfolds f then return (false, true)
  -- last resort: a shallow search in which Mathlib's heavier tactics close the leaves
  if ← tryProve P unfolds fuelStrong true then return (true, false)
  if ← tryProve nP unfolds fuelStrong true then return (false, true)
  return (false, false)

def bump (k : Nat) : CommandElabM Unit := do
  scoreRef.modify fun s => match k with
    | 0 => { s with passed := s.passed + 1 }
    | 1 => { s with failed := s.failed + 1 }
    | _ => { s with unknown := s.unknown + 1 }

def runTest (name : String) (t : Term) (unfolds : Array Ident) (mode : Nat) : CommandElabM Unit := do
  if ← blockedRef.get then return
  let res ← liftTermElabM do
    let P ← Term.withoutErrToSorry do
      let P ← Term.elabType t
      Term.synthesizeSyntheticMVarsNoPostponing
      instantiateMVars P
    settle P unfolds
  let (pos, neg) := res
  match mode, pos, neg with
  -- should be true
  | 0, true, _ => bump 0; logInfo m!"✅ {name}"
  | 0, false, true => bump 1; logWarning m!"❌ {name}\n   The referee PROVED THE NEGATION under your definition."
  | 0, false, false => bump 2; logWarning m!"❓ {name}\n   The referee could not settle this (neither proved nor refuted)."
  -- should be false
  | 1, false, true => bump 0; logInfo m!"✅ {name}"
  | 1, true, _ => bump 1; logWarning m!"❌ {name}\n   This should be FALSE, but the referee PROVED it under your definition."
  | 1, false, false => bump 2; logWarning m!"❓ {name}\n   The referee could not settle this (neither proved nor refuted)."
  -- a mutant should be caught (`P`, "the mutant agrees with every probe", is false)
  | 3, false, true => bump 0; logInfo m!"✅ {name}\n   (one of your probes tells it apart from the right definition)"
  | 3, true, _ => bump 1; logWarning m!"❌ {name}\n   This wrong definition SURVIVES: it gives the right verdict on every one of your probes, so your tests cannot tell it apart from the right definition."
  | 3, false, false => bump 2; logWarning m!"❓ {name}\n   The referee could not settle whether one of your probes catches this mutant."
  -- should be open
  | _, false, false => bump 0; logInfo m!"✅ {name}\n   (the referee could not settle it, as expected)"
  | _, true, _ => bump 1; logWarning m!"❌ {name}\n   The referee PROVED this. A famous open problem should not be this easy: your statement is probably vacuous."
  | _, false, true => bump 1; logWarning m!"❌ {name}\n   The referee REFUTED this. Your statement is false for a silly reason."

elab_rules : command
  | `(#expect_true $n:str $[$u]? : $t) => runTest n.getString t (getUnfolds u) 0
  | `(#expect_false $n:str $[$u]? : $t) => runTest n.getString t (getUnfolds u) 1
  | `(#expect_open $n:str $[$u]? : $t) => runTest n.getString t (getUnfolds u) 2
  | `(#expect_caught $n:str $[$u]? : $t) => runTest n.getString t (getUnfolds u) 3

/-! ## Model tests for structures

`#expect_model "name" : S.mk d₁ d₂ …` supplies the data fields of a structure `S`.
The remaining arguments of `S.mk` are the axioms, and the referee tries to
settle each one in this concrete model. -/

syntax (name := expectModel) "#expect_model " str " : " term : command
syntax (name := expectNotModel) "#expect_not_model " str " : " term : command

/-- Settle every remaining (axiom) argument of a partially applied constructor. -/
def settleAxioms (t : Term) : CommandElabM (Array (Name × Bool × Bool)) := liftTermElabM do
  let e ← Term.withoutErrToSorry do
    let e ← Term.elabTerm t none
    Term.synthesizeSyntheticMVarsNoPostponing
    instantiateMVars e
  let ty ← whnf (← inferType e)
  let mut ty := ty
  let mut acc : Array (Name × Bool × Bool) := #[]
  repeat
    match ty with
    | .forallE n dom body _ =>
      let r ← settle dom #[]
      -- axioms are propositions: later fields do not depend on the proof
      acc := acc.push (n, r.1, r.2)
      ty := body.instantiate1 (← mkSorry dom false)
    | _ => break
  return acc

elab_rules : command
  | `(#expect_model $n:str : $t) => do
    if ← blockedRef.get then return
    let rs ← settleAxioms t
    let bad := rs.filter (fun r => r.2.2)
    let unk := rs.filter (fun r => !r.2.1 && !r.2.2)
    if !bad.isEmpty then
      bump 1
      logWarning m!"❌ {n.getString}\n   This SHOULD be a model, but your axiom(s) {bad.map (·.1)} FAIL here."
    else if !unk.isEmpty then
      bump 2
      logWarning m!"❓ {n.getString}\n   Could not settle axiom(s) {unk.map (·.1)} in this model."
    else
      bump 0; logInfo m!"✅ {n.getString}"
  | `(#expect_not_model $n:str : $t) => do
    if ← blockedRef.get then return
    let rs ← settleAxioms t
    let bad := rs.filter (fun r => r.2.2)
    let unk := rs.filter (fun r => !r.2.1 && !r.2.2)
    if !bad.isEmpty then
      bump 0; logInfo m!"✅ {n.getString}\n   (ruled out by {bad.map (·.1)})"
    else if !unk.isEmpty then
      bump 2
      logWarning m!"❓ {n.getString}\n   Could not settle axiom(s) {unk.map (·.1)} in this model."
    else
      bump 1
      logWarning m!"❌ {n.getString}\n   This junk model satisfies ALL your axioms, so your structure does not rule it out."

/-- `#no_sorry foo` — reject definitions that use `sorry`. -/
elab "#no_sorry " id:ident : command => do
  let n ← liftCoreM <| realizeGlobalConstNoOverloadWithInfo id
  let axs ← liftCoreM <| collectAxioms n
  let missing := axs.contains ``sorryAx
  if missing then blockedRef.set true
  if missing then
    throwError "`{n}` still contains `sorry`: write your definition first."

elab "#level_start " title:str : command => do
  scoreRef.set {}
  logInfo m!"━━━ {title.getString} ━━━"

elab "#level_report" : command => do
  if ← blockedRef.get then
    logInfo "Fill in the `sorry` in your Player file, then run the level again."
    return
  let s ← scoreRef.get
  let total := s.passed + s.failed + s.unknown
  let verdict :=
    if s.passed == total then "🏆 LEVEL CLEARED"
    else if s.failed == 0 then "🤔 No test failed, but some could not be settled. Make your definition easier for the referee to work with (or ask a stronger prover)."
    else "🔁 Not yet: read the ❌ tests above, they tell you what your definition gets wrong."
  logInfo m!"Score: {s.passed}/{total} passed · {s.failed} failed · {s.unknown} unsettled\n{verdict}"

end LeanCraftGame

namespace LeanCraftGame
elab "referee_solve " n:num : tactic => solve n.getNat
end LeanCraftGame

namespace LeanCraftGame
/-- `#referee_stats`: time spent in each closing tactic so far (for tuning the referee). -/
elab "#referee_stats" : command => do
  let rows := (← statsRef.get).toArray.qsort (fun a b => a.2.2.2 > b.2.2.2)
  logInfo <| "\n".intercalate <| rows.toList.map fun (t, c, k, ms) =>
    s!"{ms} ms · {c} calls · {k} closed · {t}"
end LeanCraftGame
