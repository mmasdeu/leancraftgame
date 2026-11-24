/-
# For all

A **sequence** of natural numbers is a function `u : ℕ → ℕ`: the term of
index `n` is `u n`. Sequences are written with `fun`: `fun n => 2 * n` is
`0, 2, 4, 6, …`, and `fun n => n % 3` is `0, 1, 2, 0, 1, 2, …`. The referee
uses such sequences to test your definitions.

Statements about *all* terms use the universal quantifier:

```lean
def AllBig (u : ℕ → ℕ) : Prop := ∀ n, 10 ≤ u n
```

reads "for every `n`, `10 ≤ u n`" (type `∀` as `\forall`). The variable
after `∀` is bound: renaming it changes nothing.

A universal statement is refuted by **one** counterexample, and confirmed
by no number of examples: `n² + n + 41` is prime for `n = 0, 1, …, 39`, and
not for `n = 40`. The referee proves universal statements by reasoning, not
by trying cases.

Typing symbols: the **Symbols** button at the top right lists them all.

## Your task

`AllBig` is done. Define `AlwaysBelow u B` (every term is at most `B`: the
sequence is bounded by `B`) and `AllEven u` (every term is even).
-/
namespace L16

-- every term is at least 10 (already done)
def AllBig (u : Nat → Nat) : Prop := ∀ n, 10 ≤ u n

-- every term is at most B
def AlwaysBelow (u : Nat → Nat) (B : Nat) : Prop := sorry

-- every term is even
def AllEven (u : Nat → Nat) : Prop := sorry

end L16
