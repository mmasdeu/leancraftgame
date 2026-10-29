/-
# Quantifiers in order

Quantifiers are read from left to right, and **the order matters**.

* `∀ m, ∃ n, f n = m`: for every `m` there is an `n` with `f n = m`.
  The `n` may depend on `m`.
* `∃ n, ∀ m, f n = m`: there is **one** `n` that works for every `m`.
  This is much stronger. For `f n = n` the first is true and the second false.

```lean
def EveryValueIsHit (f : Nat → Nat) : Prop := ∀ m, ∃ n, f n = m
```

## Your task

Define `HitsEverything f` (every natural number is the value of `f` at some
position) and `Unbounded u` (however large `M` is, some term of `u` is at least
`M`). These two are exactly the kind of definitions the next level builds on.
-/
namespace L13

-- every natural number is a value of f
def HitsEverything (f : Nat → Nat) : Prop := sorry

-- the sequence gets above every bound M at least once
def Unbounded (u : Nat → Nat) : Prop := sorry

end L13
