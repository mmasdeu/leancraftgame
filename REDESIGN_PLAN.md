# Lean Craft Game v3: a redesign that follows *Mathematics in Lean*

**Status:** a proposal for you to validate. No code has been written.

## 1. Goals

1. **Fewer levels, none silly.** v2 has 75 levels. This plan has **50**, in 13 worlds. Each
   level teaches one piece of syntax or one reading/writing skill that a working Lean user
   needs. Exercises that test a programming idiom and not mathematics go (cards, scores,
   versions, calendars, percentages, rectangle perimeters).
2. **Follow MIL chapter by chapter.** There is one world per chapter of *Mathematics in Lean*
   (Introduction to Integration and Measure Theory). The number of levels per world varies
   with how much new syntax the chapter brings. The coverage table in §5 maps every MIL
   section to the levels that cover it.
3. **No proofs.** Where MIL proves something, the player does one of these things instead,
   and the referee does any proving that is needed:
   * writes the **statement** in Lean,
   * writes a **definition** that the statement depends on,
   * gives a **witness** or a **counterexample**,
   * **reads** a Lean statement or definition and says what it means.
4. **Reading as much as writing.** MIL readers spend most of their time reading Mathlib
   signatures. About 40% of the levels are reading levels.
5. **Mathlib, not home-made copies.** From the Logic world on, levels use Mathlib's own
   names: `Set`, `Function.Injective`, `Filter.Tendsto`, `Submodule`, `deriv`, `∫`. The
   player learns the library they will actually use. Home-made versions appear only where
   MIL itself builds one to explain the idea (Structures, Hierarchies).

## 2. What changes in the mechanics

### 2.1 Exercise types (the tag above each lesson)

The v2 tags are kept, with two changes:

| Tag                 | The player…                                                                                       | Checked by                                                                                           |
| ------------------- | -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| **Write**     | writes a definition or a statement from a mathematical description                                 | tests on instances, plus an equivalence test against a reference statement (§2.3)                   |
| **Read**      | answers questions about a given Lean text: true/false, "which of these means…", predicting values | the answer key (Booleans, or `Fin k` for multiple choice), with the existing `predict` mechanism |
| **Construct** | gives a witness: a number, a function, a set, a structure instance                                 | tests on the witness                                                                                 |
| **Refute**    | gives a counterexample to a false statement, or to a colleague's definition                        | tests on the counterexample                                                                          |
| **Repair**    | fixes a colleague's definition or statement so that it means what was intended                     | equivalence and instance tests                                                                       |
| **Audit**     | decides whether a formal statement says what it claims, and why not                                | toy-world tests, as in v2's Audit world                                                              |

*Define* is merged into *Write*. *Classify*, *Connect* and *Referee* become variants of
*Read* and *Construct*. Mutation testing (v2's "Be the referee") survives as one level, in
the Logic world.

### 2.2 Writing a statement without proving it

MIL's basic unit is a `theorem` with binders and hypotheses. That syntax is worth teaching
on its own, so add a command to the referee:

```lean
statement add_pos_of_pos {a b : ℝ} (ha : 0 < a) (hb : 0 < b) : 0 < a + b
```

It elaborates to `def add_pos_of_pos : Prop := ∀ {a b : ℝ}, 0 < a → 0 < b → 0 < a + b`. It
teaches binders, implicit and explicit arguments, and the hypotheses-before-colon style,
without asking for a proof. The tests then refer to the statement by its name.

### 2.3 New test kinds

| Command                                | Meaning                                                                                                                                                                                                   | Use                                                                                         |
| -------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `#expect_equiv "name" : P ↔ Q`      | The player's statement `P` is equivalent to the reference `Q`. The referee tries `Iff.rfl`, `simp`, `push_neg`, `tauto` and its own search; it gives ❓ rather than ❌ when it cannot decide. | Write and Repair levels about statements                                                    |
| `#expect_type "name" : e : T`        | `e` elaborates with type `T`. A type error becomes ❌ with Lean's message.                                                                                                                            | Reading-level checks that a term has the right shape (`f '' s : Set β`, `V →ₗ[K] W`) |
| `#expect_choice "name" : answer = k` | A multiple-choice answer. This is sugar for `#expect_true` on `Fin k` and Bool equality.                                                                                                              | Read levels                                                                                 |

**Honesty rule (unchanged from v2).** ❌ needs a proof of the opposite. For statements, a
❌ means one of three things: the referee proved `¬ (P ↔ Q)`, or it found an instance where
`P` and `Q` differ, or a mutant reference that should differ from `P` agrees with it.

### 2.4 Checking material the referee cannot compute

Worlds 8 to 12 are about objects the referee cannot evaluate: modules, filters, derivatives,
integrals. In those worlds the checks are deliberately **syntactic and type-level**:

* `#expect_type` checks the shape of the player's term.
* `#expect_equiv` compares with a reference that is written the way a Mathlib user would
  write it. Rewriting with Mathlib's `simp` set closes the usual variations.
* Concrete instances where Mathlib's `simp`/`norm_num` already know the answer, such as
  `deriv (fun x => x ^ 2) 3 = 6` or `∫ x in (0:ℝ)..1, x = 1 / 2`. Each such instance is
  prototyped first (milestone M1). Any instance that comes out ❓ is dropped.
* Read questions, which are checked against an answer key.

## 3. Design principles for every level

1. **One new construct per level.** The new construct appears in the lesson as a worked
   example taken from MIL or close to it.
2. **Mathematically real objects only.** Examples come from MIL's own: the AM-GM
   inequality, `ConvergesTo`, Schröder–Bernstein, √2, primes, Fibonacci, Catalan numbers,
   Gaussian integers, `ℤ/nℤ`, linear maps on `ℝ²`, `𝓝`, `atTop`.
3. **Every level has a trap, and a prediction aims at it.** Examples: truncated
   subtraction, implicit arguments, precedence of `→` and `∧`, `∃ x, P → Q`,
   `f '' (s ∩ t)`, `Finset.range n` without `n`, `⊥` in Mathlib's filters, `deriv` of a
   non-differentiable function being `0`.
4. **Each world ends with a "Spot the bug" (Refute or Repair) level, where it helps.** The
   last world ends with an Audit level instead.
5. **Few, high-yield tests per level** (6–12). Every test catches a mistake that a sample
   `bug_*.lean` answer actually makes.

## 4. Worlds and levels

**Legend.** "MIL" is the section the level follows. **R**/**W** means mainly Reading or mainly
Writing. *Check* summarises how the referee judges the answer.

### World 1: Getting Started (MIL 1), 2 levels

| # | Level                            | R/W | Content                                                                                                                                                                                                                                            | Check       |
| - | -------------------------------- | --- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| 1 | **Reading a Lean file**    | R   | What `def`, `theorem`, `example`, `#check`, `#eval`, `sorry`, comments and `variable` are. The player answers questions about a short MIL-style file: which line is a definition, what type `#check` prints, what `#eval` gives. | answer key  |
| 2 | **Your first definitions** | W   | `def` with a type, functions `fun x ↦ …`, application without brackets, `ℕ` vs `ℝ` literals (`(2 : ℝ)`). Define `sq`, `amgm_rhs a b := (a + b) / 2`.                                                                            | computation |

### World 2: Basics (MIL 2), 5 levels

MIL's chapter on calculating, rewriting and algebraic structures becomes a chapter on
**reading and writing statements**.

| # | Level                              | R/W    | Content                                                                                                                                                                                                                                                                                                                                | Check                               |
| - | ---------------------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------- |
| 3 | **How Lean parses**          | R      | Precedence and associativity:`a * b + c`, `-x ^ 2`, `a / b * c`, `f x + 1` vs `f (x + 1)`, `a - b + c` on ℕ. Predict values and choose the bracketing.                                                                                                                                                                    | answer key,`#eval`                |
| 4 | **Anatomy of a theorem**     | R      | Read Mathlib signatures as `#check` shows them (`mul_le_mul`, `add_pow_two`, `abs_sub_lt_iff`): explicit `( )`, implicit `{ }`, instance `[ ]` arguments; hypotheses and conclusion. Questions: how many explicit arguments? which is the conclusion?                                                                    | answer key                          |
| 5 | **Stating theorems**         | W      | Introduces `statement` (§2.2). Write MIL's warm-ups as statements: `(a + b)² = a² + 2ab + b²`, the two-variable AM-GM `2ab ≤ a² + b²`, `                                                                                                                                                                                  | ab                                  |
| 6 | **Generic statements**       | W      | `variable {R : Type*} [CommRing R]` and `[Lattice α]`, `[PartialOrder α]`. Restate facts from MIL 2.2 and 2.5 for an arbitrary ring, lattice or metric space (`dist x y ≥ 0`, absorption laws). Trap: a statement that needs `[LinearOrder α]` but asks only for `[PartialOrder α]` does not typecheck, or says less. | `#expect_type`, `#expect_equiv` |
| 7 | **Spot the bug: statements** | Refute | A colleague's statements: AM-GM over ℕ with truncated subtraction, a missing hypothesis `0 ≤ a`, `x / y * y = x` without `y ≠ 0`. Give counterexamples, then repair one.                                                                                                                                                      | counterexample tests; equivalence   |

### World 3: Logic (MIL 3), 7 levels

| #  | Level                                     | R/W       | Content                                                                                                                                                                                              | Check                                           |
| -- | ----------------------------------------- | --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| 8  | **∀ and →**                       | W         | MIL's `FnUb`, `FnLb`, `FnHasUb` (upper bounds of functions), `Monotone f` as `∀ {a b}, a ≤ b → f a ≤ f b`. Implicit binders in definitions.                                            | instance tests                                  |
| 9  | **∃**                              | W         | `FnHasUb f := ∃ a, FnUb f a`. Witness exercises: give an upper bound, give `x` with `f x = 0`. Scope: `∃ x, P x ∧ Q x` vs `(∃ x, P x) ∧ (∃ x, Q x)`.                                 | instance tests; witnesses                       |
| 10 | **¬ and the order of quantifiers** | W         | Negations as MIL writes them (`¬ FnHasUb f`, `¬ Monotone f`). The player writes the pushed-negation form by hand. Swapping `∀∃` vs `∃∀`.                                               | `#expect_equiv` against the `push_neg` form |
| 11 | **∧, ∨ and ↔**                   | W         | MIL's `x ≤ y ∧ x ≠ y`, `abs` and `∨`, `↔` statements. Trap: precedence of `→` over `∧`, `∃ x, P x → Q x`.                                                                     | equivalence, instances                          |
| 12 | **Sequences and convergence**       | W         | MIL 3.6:`ConvergesTo s a`, then convergence of a sum, uniqueness, Cauchy. The player writes `ConvergesTo` and states, without proving, the three theorems MIL proves.                            | instance tests (from v2 L39),`#expect_equiv`  |
| 13 | **Be the referee**                  | Construct | Mutation testing: choose four sequences that catch hidden mutants of `ConvergesTo` (a quantifier swapped, `ε ≥ 0`, `∃ n` instead of `∀ n ≥ N`). Reuses v2 L27's mechanism, moved to ℝ. | `#expect_caught`                              |
| 14 | **Spot the bug: logic**             | Refute    | v2's quantifier and convergence bugs, merged (Alice and Bob from v2 L43,`∃ n, n > 0 → …`).                                                                                                      | counterexamples                                 |

### World 4: Sets and Functions (MIL 4), 5 levels

| #  | Level                                                  | R/W    | Content                                                                                                                                                                                                                                                                                       | Check                                                                                                                                                 |
| -- | ------------------------------------------------------ | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| 15 | **Set notation**                                 | R+W    | `Set α`, `{x                                                                                                                                                                                                                                                                               | P x}`, `∈`, `⊆`, `∩ ∪ \ ᶜ `, `∅`, `univ `, indexed `⋃ i, A i `and`⋂ i, A i `, `⋃₀`. Read `s ∩ (t ∪ u)`aloud. Write`{n |
| 16 | **Images and preimages**                         | W      | `f '' s`, `f ⁻¹' t`, `Set.range f`. Statements of MIL 4.2 (`f '' (s ∪ t) = …`). Refute `f '' (s ∩ t) = f '' s ∩ f '' t` with a witness.                                                                                                                                       | `#expect_type`, counterexample tests                                                                                                                |
| 17 | **Injective, surjective, inverses**              | W      | `Function.Injective`, `InjOn f s`, `Surjective`, `LeftInverse`; MIL's `Function.invFun` and why it needs `[Nonempty α]`. Read the type of `invFun`.                                                                                                                            | instance tests (from v2 L25), Read questions                                                                                                          |
| 18 | **Reading a construction: Schröder–Bernstein** | R      | MIL 4.3's `sbAux`, `sbSet`, `sbFun` are given. The player answers questions about them: which set is defined by recursion, what `sbFun` does on `sbSet` and off it, why `invFun g` appears. Then compute `sbSet` for an explicit pair of injections ℕ → ℕ on small elements. | answer key, computed membership                                                                                                                       |
| 19 | **Spot the bug: sets**                           | Refute | `{n                                                                                                                                                                                                                                                                                           | k % n = 0}`meant as the multiples of`k `, `⋃ i, ⋂ j `swapped,`f ⁻¹' (f '' s) = s`.                                                          |

### World 5: Elementary Number Theory (MIL 5), 4 levels

| #  | Level                             | R/W   | Content                                                                                                                                                                                                                                                            | Check                                                                   |
| -- | --------------------------------- | ----- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------- |
| 20 | **Divisibility and primes** | W     | `∣`, `Nat.Prime`, `Nat.Coprime`, `Nat.gcd`, `Nat.factorization`. Write `IsSquarefree`-like definitions and state MIL 5.1's lemmas (`Nat.Prime.two_le`, `Nat.Coprime` facts).                                                                      | computation                                                             |
| 21 | **Irrational roots**        | W     | State "√2 is irrational" three ways:`Irrational (√2)`, `¬ ∃ q : ℚ, q ^ 2 = 2`, `∀ m n : ℕ, Coprime m n → m ^ 2 ≠ 2 * n ^ 2`. The trap is the casts (`(q : ℝ)`). Read Mathlib's `Irrational`. Then MIL's generalisation `m ^ k ≠ p * n ^ k`. | `#expect_equiv` where the referee manages, `#expect_type` otherwise |
| 22 | **Recursion and induction** | W     | Pattern matching,`fac`, `fib`, sums by recursion vs `∑ i ∈ range n`, the Collatz map. State (do not prove) MIL's closed forms. Trap: `range n` omits `n`.                                                                                              | computation, equivalence on instances                                   |
| 23 | **Infinitely many primes**  | Audit | v2's "AI proved the infinitude of primes" audit, plus MIL 5.3's `∀ n, ∃ p, n ≤ p ∧ p.Prime`, primes ≡ 3 mod 4, and strong recursion (`termination_by`) read, not written.                                                                                 | toy worlds (from v2 L73)                                                |

### World 6: Discrete Mathematics (MIL 6), 4 levels

| #  | Level                                | R/W    | Content                                                                                                                                                                                                              | Check           |
| -- | ------------------------------------ | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| 24 | **Finset and Fintype**         | W      | `Finset.range`, `Icc`, `filter`, `image`, `card`, `powerset`, `Fintype.card`, `Finset.univ`. The difference between `Set` and `Finset`. Write the set of divisors and the subsets of size `k`. | computation     |
| 25 | **Big operators and counting** | W      | `∑`, `∏`, `#s` and `s.card`. Count with sums (MIL 6.2): pairs `i < j`, subsets, triangle-free graphs on 4 vertices as a Finset count. Gauss's and Nicomachus's sums as statements.                       | computation     |
| 26 | **Inductive types**            | W      | `inductive` à la MIL 6.3: binary trees, `size`, `height`, Catalan numbers counted by trees; `List` as an inductive type. Define functions by structural recursion.                                          | computation     |
| 27 | **Spot the bug: counting**     | Refute | v2's off-by-one sums and divisor counts, and a tree `size` that forgets the root.                                                                                                                                  | counterexamples |

### World 7: Structures (MIL 7), 4 levels

| #  | Level                              | R/W    | Content                                                                                                                                                                     | Check                                    |
| -- | ---------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------- |
| 28 | **Defining structures**      | W      | MIL's `Point`: fields, `⟨ , ⟩`, `.mk`, `{ x := … }`, `@[ext]`, `Point.add` and dot notation, `StandardTwoSimplex` (a structure with propositional fields). | field tests,`#expect_model`            |
| 29 | **Algebraic structures**     | Repair | MIL's `Group₁` as a structure with axioms as fields. A colleague uses mixed one-sided axioms: find the junk model, then repair (v2 L52, which is good as it is).         | `#expect_model`, `#expect_not_model` |
| 30 | **Gaussian integers**        | W      | MIL 7.3:`GaussInt` with `re`, `im`, `norm`, `add`, `mul`, `conj`; 65 = 1² + 8² = 4² + 7² via Brahmagupta's identity (v2 L44–45 merged).                  | computation                              |
| 31 | **Spot the bug: structures** | Refute | Wrong `GaussInt.mul` sign, a `Point` average that is not symmetric, an axiom field that is vacuous.                                                                     | counterexamples                          |

### World 8: Hierarchies (MIL 8), 4 levels

| #  | Level                           | R/W | Content                                                                                                                                                                                                                                                 | Check                                    |
| -- | ------------------------------- | --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------- |
| 32 | **Classes and instances** | W   | MIL 8.1:`class One₁`, `class Monoid₁ extends Semigroup₁, One₁`, notation via classes (`*`, `1`, `+`), instances for ℕ, ℤ, `Bool` with xor, `ℕ → ℕ` with composition. One definition (`mpow`) for every monoid (v2 L53).        | computation                              |
| 33 | **Reading the hierarchy** | R   | Read `#check` output for `CommRing ℤ`, `Field ℚ`, `[NormedAddCommGroup E] [InnerProductSpace ℝ E]`; questions such as "which classes does `ℝ` get from `Field`?" and "why does `ℕ` have no `Neg`?".                                | answer key                               |
| 34 | **Morphisms**             | W   | MIL 8.2:`MonoidHom₁` as a structure (`toFun`, `map_one`, `map_mul`), Mathlib's `M →* N`, `R →+* S`, coercion to a function. Construct `n ↦ 2ⁿ : Multiplicative`-flavoured examples; a bijection that is not a homomorphism (v2 L48). | instance tests                           |
| 35 | **Sub-objects**           | W   | MIL 8.3:`Submonoid₁` with `carrier`, `mul_mem`, `one_mem`; `SetLike`; even numbers as a submonoid of `(ℕ, +)`; odd numbers are not one (junk model).                                                                                      | `#expect_model`, `#expect_not_model` |

### World 9: Groups and Rings (MIL 9), 3 levels

| #  | Level                                | R/W    | Content                                                                                                                                                                                                                                                | Check                                                  |
| -- | ------------------------------------ | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------ |
| 36 | **Groups in Mathlib**          | R+W    | `Group`, `Subgroup`, `orderOf`, `MonoidHom.ker`, `QuotientGroup`, `ZMod n`, `Equiv.Perm (Fin 3)`. Write the statements of Lagrange's theorem and Cauchy's theorem in Mathlib syntax. Compute orders in `ZMod 12` and `Perm (Fin 3)`. | `#expect_type`, computation in `ZMod` and `Perm` |
| 37 | **Rings, ideals, polynomials** | W      | `Ideal`, `Ideal.span {a}`, `Ideal.Quotient`, the Chinese remainder theorem's statement, `Polynomial` syntax (`X ^ 2 + C a * X`, `Polynomial.eval`, `.degree`, `.roots`), `ZMod p`.                                                   | computation of `eval` and `ZMod`; `#expect_type` |
| 38 | **Spot the bug: algebra**      | Refute | A "subgroup" missing inverses (ℕ in ℤ), "ideal" generated by the wrong element,`degree` of `0`.                                                                                                                                                  | counterexamples, junk models                           |

### World 10: Linear Algebra (MIL 10), 4 levels

| #  | Level                                   | R/W | Content                                                                                                                                                                                                                                                                    | Check                                                |
| -- | --------------------------------------- | --- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| 39 | **Vector spaces and linear maps** | W   | `[Field K] [AddCommGroup V] [Module K V]`, `V →ₗ[K] W` as a bundled map (fields `toFun`, `map_add'`, `map_smul'`), `LinearMap.ker`/`range`. Construct the rotation of `ℝ²` and the projection to a coordinate; refute the linearity of `x ↦ x + 1`. | `#expect_model` on `Fin 2 → ℚ`, instance tests |
| 40 | **Subspaces and quotients**       | W   | `Submodule K V`, `⊥`, `⊤`, `⊔`, `⊓`, `Submodule.span`, `V ⧸ W`. Decide which subsets of `ℚ²` are subspaces (lines through 0, the parabola).                                                                                                         | `#expect_model`, `#expect_not_model`             |
| 41 | **Endomorphisms**                 | R+W | `Module.End K V`, `HasEigenvalue`, `LinearMap.det`, `minpoly`. State "every endomorphism of a finite-dimensional complex space has an eigenvalue" in Mathlib syntax; read `Module.End.HasEigenvector`.                                                           | `#expect_type`, `#expect_equiv`                  |
| 42 | **Matrices, bases and dimension** | W   | `Matrix (Fin 2) (Fin 2) ℚ`, `!![a, b; c, d]`, `Matrix.det`, `mulVec`, `Basis ι K V`, `Module.finrank`. Compute determinants, write the matrix of a rotation, Fibonacci via matrix powers (from v2 L47).                                                      | computation (`decide`, `norm_num` on `!![…]`) |

### World 11: Topology (MIL 11), 5 levels

| #  | Level                                | R/W    | Content                                                                                                                                                                                                                                                                                            | Check                                                             |
| -- | ------------------------------------ | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| 43 | **Filters**                    | R+W    | MIL 11.1:`Filter`, `atTop`, `𝓝 x`, `principal`, `Tendsto f l₁ l₂`, `∀ᶠ x in l, P x`, `∃ᶠ`. Translate "eventually" and "infinitely often" from the Logic world into filter notation. Trap: Mathlib's filters allow `⊥`.                                                     | `#expect_equiv` against `Filter.eventually_atTop` forms; Read |
| 44 | **Metric spaces**              | W      | `[MetricSpace X]`, `dist`, `Metric.ball`, `closedBall`, `Cauchy`/`CauchySeq`, `IsCompact`, `Continuous` in ε–δ form (`Metric.continuous_iff`). State uniform continuity. Integer metrics as models (from v2 L51).                                                             | `#expect_model`, `#expect_equiv`                              |
| 45 | **Topological spaces**         | W      | MIL 11.3:`TopologicalSpace`, `IsOpen`, `Continuous`, neighbourhoods. Finite spaces as a checkable gallery: Sierpiński space and the particular-point topology (v2's library, compressed from 15 levels to this one and the next). Write the axioms as a structure; continuity by preimages. | exhaustive `decide` on `Fin n` (v2 Lib)                       |
| 46 | **Separation and compactness** | R+W    | T0, T1, T2 (`T2Space`), `IsCompact` via finite subcovers; Sierpiński is T0 and not T1; finite T1 spaces are discrete; the cover of ℕ with no finite subcover (v2 L69, L71).                                                                                                                  | `decide`, witnesses                                             |
| 47 | **Spot the bug: topology**     | Refute | Continuity with images instead of preimages,`Tendsto` arguments swapped, "convergent ⇒ Cauchy" written backwards.                                                                                                                                                                               | counterexamples (finite spaces), equivalence                      |

### World 12: Differential Calculus (MIL 12), 2 levels

| #  | Level                                  | R/W | Content                                                                                                                                                                                                    | Check                       |
| -- | -------------------------------------- | --- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------- |
| 48 | **Derivatives**                  | R+W | `deriv f x`, `HasDerivAt f f' x`, `DifferentiableAt ℝ f x`, and the junk value `deriv                                                                                                               | ·                          |
| 49 | **Derivatives in normed spaces** | R   | `fderiv ℝ f x : E →L[ℝ] F`, `‖x‖`, `HasFDerivAt`, `ContDiff ℝ n f`. Read the types: what kind of object is the derivative of `f : ℝ² → ℝ`? Which arguments of `fderiv` are explicit? | answer key,`#expect_type` |

### World 13: Integration and Measure Theory (MIL 13), 1 level + final audit

| #    | Level                                          | R/W   | Content                                                                                                                                                                                                                                           | Check                                                                           |
| ---- | ---------------------------------------------- | ----- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| 50   | **Integrals and measures**               | R+W   | `∫ x in a..b, f x`, `MeasureTheory.volume`, `MeasurableSet`, `∀ᵐ x ∂μ, P x`, `∫ x, f x ∂μ`. State the fundamental theorem of calculus and dominated convergence (read Mathlib's version). Compute `∫ x in (0:ℝ)..1, x ^ 2`. | `norm_num [integral_pow]` instances (prototype first), `#expect_type`, Read |
| (51) | **Final audit: the AI proved Goldbach!** | Audit | Optional capstone. v2's Collatz and Goldbach audits merged into one level that uses statements from all worlds.                                                                                                                                   | toy worlds                                                                      |

That is **50 levels** (51 with the capstone): 2 + 5 + 7 + 5 + 4 + 4 + 4 + 4 + 3 + 4 + 5 + 2 + 1.
The densest worlds are Logic and Topology, where MIL itself introduces the most notation.

## 5. Coverage: every MIL section is used

| MIL section                                    | Level(s)                                       |
| ---------------------------------------------- | ---------------------------------------------- |
| 1.1 Getting Started, 1.2 Overview              | 1, 2                                           |
| 2.1 Calculating                                | 3, 5                                           |
| 2.2 Proving Identities in Algebraic Structures | 6                                              |
| 2.3 Using Theorems and Lemmas                  | 4                                              |
| 2.4 More examples using apply and rw           | 4, 5 (as statements:`min`, `max`, `abs`) |
| 2.5 Proving Facts about Algebraic Structures   | 6, 7                                           |
| 3.1 Implication and the Universal Quantifier   | 8                                              |
| 3.2 The Existential Quantifier                 | 9                                              |
| 3.3 Negation                                   | 10                                             |
| 3.4 Conjunction and Iff                        | 11                                             |
| 3.5 Disjunction                                | 11                                             |
| 3.6 Sequences and Convergence                  | 12, 13                                         |
| 4.1 Sets                                       | 15                                             |
| 4.2 Functions                                  | 16, 17                                         |
| 4.3 The Schröder–Bernstein Theorem           | 18                                             |
| 5.1 Irrational Roots                           | 20, 21                                         |
| 5.2 Induction and Recursion                    | 22                                             |
| 5.3 Infinitely Many Primes                     | 23                                             |
| 5.4 More Induction                             | 22, 23 (strong recursion read)                 |
| 6.1 Finsets and Fintypes                       | 24                                             |
| 6.2 Counting Arguments                         | 25                                             |
| 6.3 Inductively Defined Types                  | 26                                             |
| 7.1 Defining structures                        | 28                                             |
| 7.2 Algebraic Structures                       | 29                                             |
| 7.3 Building the Gaussian Integers             | 30                                             |
| 8.1 Basics                                     | 32, 33                                         |
| 8.2 Morphisms                                  | 34                                             |
| 8.3 Sub-objects                                | 35                                             |
| 9.1 Monoids and Groups                         | 36                                             |
| 9.2 Rings                                      | 37                                             |
| 10.1 Vector spaces and linear maps             | 39                                             |
| 10.2 Subspaces and quotients                   | 40                                             |
| 10.3 Endomorphisms                             | 41                                             |
| 10.4 Matrices, bases and dimension             | 42                                             |
| 11.1 Filters                                   | 43                                             |
| 11.2 Metric spaces                             | 44                                             |
| 11.3 Topological spaces                        | 45, 46                                         |
| 12.1 Elementary Differential Calculus          | 48                                             |
| 12.2 Differential Calculus in Normed Spaces    | 49                                             |
| 13.1 Elementary Integration                    | 50                                             |
| 13.2 Measure Theory                            | 50                                             |
| 13.3 Integration                               | 50                                             |

## 6. What happens to v2's 75 levels

* **Kept, possibly merged:**
  * Collatz and Fibonacci (in 22);
  * Gaussian integers (30);
  * matrices (42);
  * the colleague's groups (29);
  * morphisms (34);
  * Be the referee (13, moved to ℝ);
  * convergence, Cauchy and the Alice/Bob bug (12, 14);
  * injective/surjective (17);
  * Finset sums and off-by-one (24, 25, 27);
  * the finite-topology gallery, compressed from 15 levels to 2 (45, 46);
  * compactness on ℕ (46);
  * the three audits, compressed to 2 (23, 51).
* **Dropped as silly or redundant:**
  * cards, rectangles, settings, dates/moments, versions, scores, marks, `Size` classes;
  * percentages and rounding;
  * the separate syntax-only structure levels (`Defaults and updates`), whose syntax folds into 28;
  * the repetitive quantifier drills (v2 L16–L21 become 8–11);
  * the calendar and leap-year exercises;
  * T1–T3 of the Topology world (sets and relations are now World 4);
  * products and subspaces as separate levels (now a Read question in 45).
* **Reused infrastructure:**
  * referee and test commands;
  * predictions, hidden tests and stepped hints;
  * the shared library (`Lib/Topology.lean`);
  * the online build with the library in the prelude;
  * plain-language verdicts;
  * `check_levels.py` and the variants.

## 7. Implementation milestones

| Milestone                                       | Work                                                                                                                                                                                                                                                                                                                                        | Done when                                                                                             |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| **M0. Validate this plan**                | You review §4 and §8.                                                                                                                                                                                                                                                                                                                     | Level list frozen.                                                                                    |
| **M1. Referee prototypes** (largest risk) | The `statement` command; `#expect_equiv`, `#expect_type`, `#expect_choice`; Read-level UI (multiple choice rendered from `level.json`). Prototype the checkable instances of Worlds 8–13: `ZMod`, `Perm (Fin 3)`, `!![…]` determinants, `deriv` and `∫` instances, `#expect_model` on `Fin 2 → ℚ` linear maps. | Every planned instance is ✅ for a right answer and ❌ for a wrong one in under 30 s, or is replaced. |
| **M2. Worlds 1–3** (levels 1–14)        | New lessons and tests; migrate the reused v2 tests.                                                                                                                                                                                                                                                                                         | `check_levels.py` clean; playtest with 5 simulated weak learners.                                   |
| **M3. Worlds 4–6** (15–27)              | Including the Schröder–Bernstein reading level and inductive types.                                                                                                                                                                                                                                                                       | Same.                                                                                                 |
| **M4. Worlds 7–9** (28–38)              | Structures, hierarchies, groups and rings.                                                                                                                                                                                                                                                                                                  | Same.                                                                                                 |
| **M5. Worlds 10–13** (39–51)            | Linear algebra, topology, calculus, integration.                                                                                                                                                                                                                                                                                            | Same; no ❓ on a correct sample answer.                                                               |
| **M6. Integration and release**           | Welcome page, CURRICULUM.md, AUTHORING.md, the online build, a full regression and a playtest across the whole game; publish at `/v3` (or replace `/v2`).                                                                                                                                                                               | Regression clean; Pages workflow publishes without touching `/play` and `/beta`.                  |

Order of work: M1 comes first because Worlds 8–13 depend on it. If a construct cannot be
checked reliably, its level becomes a Read level with an answer key, and the plan does not
otherwise change.

## 8. Questions to settle before implementation

1. **Length.** Is 50 about right, or do you want a harder cap (for example 40, by merging
   levels 3+4, 8+9, 24+25, 39+40 and dropping 47)?
   50 is about right.
2. **The `statement` command.** Is writing theorem statements (binders, hypotheses) without
   proofs the right core skill for Worlds 2–13, or should statements stay as
   `def … : Prop`?
   Better use def and Prop, since it's closer to real life.
3. **Mathlib from the start.** Using `Set`, `Function.Injective`, `Filter` etc. from World 3
   on means fewer home-made definitions. Fine?
   This is fine.
4. **Finite topology.** Keep the exhaustively checked finite spaces in levels 45–46, or
   switch fully to Mathlib's `TopologicalSpace` with Read-type checks?
   I will let you decide.
5. **Calculus and integration.** These worlds are mostly reading. Acceptable, or would you
   rather end the game after Topology and leave MIL 12–13 out?
   Keep them out.
6. **Publishing.** A new `/v3`, or replace `/v2`?
   A new /v3 is good.
