/-
# If, then, for all

Most universal statements in mathematics are **restricted**: "for every
`n ≥ 3`, …", "for every even `n`, …". In Lean the restriction is an
implication inside the quantifier:

```lean
def BigAfter (u : ℕ → ℕ) : Prop := ∀ n, 3 ≤ n → 10 ≤ u n
```

"for every `n`, if `3 ≤ n` then `10 ≤ u n`". For `n < 3` the implication is
vacuously true, so the early terms are unconstrained, which is exactly what
"from index 3 on" means. (Lean also accepts the shorthand `∀ n ≥ 3, …`.)

This is the shape of the definition of convergence ("for every `n ≥ N`"),
of continuity, and of most of the analysis to come. The `→` inside a `∀`
is not optional: `∀ n, 3 ≤ n ∧ 10 ≤ u n` claims that *every* `n` is at
least 3, which is false.

## Your task

Define `LateBig u` (from index 5 on, the terms are at least 3) and
`EvenToEven u` (`u` sends even indices to even values: for every `n`, if `n`
is even then `u n` is even).
-/
namespace L17

-- from index 3 on, the terms are at least 10 (already done)
def BigAfter (u : Nat → Nat) : Prop := ∀ n, 3 ≤ n → 10 ≤ u n

-- from index 5 on, the terms are at least 3
def LateBig (u : Nat → Nat) : Prop := sorry

-- if n is even then u n is even
def EvenToEven (u : Nat → Nat) : Prop := sorry

end L17
