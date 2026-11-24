/-
# Quantifiers in order

Quantifiers are read from left to right, and **the order matters**.

* `∀ m, ∃ n, f n = m`: every `m` is a value of `f`. The `n` may depend on
  `m`. This is **surjectivity**.
* `∃ n, ∀ m, f n = m`: one single `n` with `f n` equal to every `m` at
  once. This is absurd as soon as there are two values of `m`.

The same swap separates "for every `ε` there is a `δ`" (continuity) from
"there is a `δ` that works for every `ε`", and continuity from uniform
continuity ("for every `ε` there is a `δ` that works at every point").
Most errors in formalisation are quantifier swaps.

Unboundedness is a `∀ ∃` statement too: "however large `M`, some term is at
least `M`". Its negation, boundedness, is `∃ M, ∀ n, u n < M`: negation
swaps the quantifiers.

## Your task

Define `HitsEverything f` (`f` is surjective: every natural number is a value
of `f`) and `Unbounded u` (for every `M` some term of `u` is at least `M`).
-/
namespace L19

-- every natural number is a value of f
def HitsEverything (f : Nat → Nat) : Prop := sorry

-- the sequence gets above every bound M at least once
def Unbounded (u : Nat → Nat) : Prop := sorry

end L19
