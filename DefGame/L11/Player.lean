/-
# If … then …

Often a statement only concerns *some* positions: "from index 5 on, the terms
are at least 3". That is a statement of the form "**if** *this*, **then**
*that*", written `p → q`.

* Type `→` as `\to`, or write `->`.
* `p → q` is true when `p` is false, or when `q` is true.
* `→` binds weaker than `∧` and `∨`: `a → b ∧ c` means `a → (b ∧ c)`.

```lean
def BigAfter (u : Nat → Nat) : Prop := ∀ n, 3 ≤ n → 10 ≤ u n
```

Read it as: "for every `n`, **if** `n` is at least 3 **then** `u n` is at
least 10". It says nothing about `u 0`, `u 1` and `u 2`.

## A classic mistake

What about `∀ n, 3 ≤ n ∧ 10 ≤ u n`? That says that *every* `n`, even `n = 0`,
is at least 3, which is false for every sequence. When a statement is about
"the `n` such that …", use `→`, not `∧`.

## Your task

`BigAfter` is done. Define `LateBig u` (from index 5 on, every term is at
least 3) and `EvenToEven u` (whenever `n` is even, `u n` is even).
-/
namespace L11

-- from index 3 on, the terms are at least 10 (already done)
def BigAfter (u : Nat → Nat) : Prop := ∀ n, 3 ≤ n → 10 ≤ u n

-- from index 5 on, the terms are at least 3
def LateBig (u : Nat → Nat) : Prop := sorry

-- if n is even then u n is even
def EvenToEven (u : Nat → Nat) : Prop := sorry

end L11
