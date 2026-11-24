/-
# There exists

The existential quantifier `∃ n, P n` (type `\exists`) says that **some**
`n` satisfies `P`:

```lean
def HasBig (u : ℕ → ℕ) : Prop := ∃ n, 10 ≤ u n
```

An existential statement is proved by a **witness**: `HasBig (fun n => n)`
holds because `n = 10` works. The referee searches for witnesses among
small numbers and among expressions built from the variables in sight.

Mind the scope. "Some term is even and some term is at least 10" is

```lean
(∃ n, u n % 2 = 0) ∧ (∃ m, 10 ≤ u m)
```

with two possibly different witnesses, while "some term is both" is
`∃ n, u n % 2 = 0 ∧ 10 ≤ u n`, with a single one. The sequence `4, 11, 11,
11, …` satisfies the first and not the second.

And the restricted form: "some `n` with `P n` has `Q n`" is
`∃ n, P n ∧ Q n`, with `∧`, not `→` (see the last level of this world).

## Your task

Define `HasZero u` (some term is zero) and `HasEvenBig u` (some single term is
both even and at least 10).
-/
namespace L18

-- some term is at least 10 (already done)
def HasBig (u : Nat → Nat) : Prop := ∃ n, 10 ≤ u n

-- some term is zero
def HasZero (u : Nat → Nat) : Prop := sorry

-- some single term is both even and at least 10
def HasEvenBig (u : Nat → Nat) : Prop := sorry

end L18
