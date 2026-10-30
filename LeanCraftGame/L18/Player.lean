/-
# Spot the bug: quantifiers

A colleague wrote three predicates about sequences. Each one compiles and
each one is wrong, in the way you learned to avoid in this world.

```lean
-- f has a root other than 0
def HasPositiveRoot (f : ℕ → ℕ) : Prop := ∃ n, n > 0 → f n = 0

-- from some index on, every term of u is 0
def EventuallyZero (u : ℕ → ℕ) : Prop := ∀ N, ∃ n ≥ N, u n = 0

-- u takes arbitrarily large values
def Unbounded (u : ℕ → ℕ) : Prop := ∃ M, ∀ n, M ≤ u n
```

This time the counterexamples are **functions**. Write them with `fun`, as the
referee's tests did in the earlier levels: `fun n => n % 2` is the sequence
0, 1, 0, 1, …. You may use `if … then … else …`.

## Translate before you hunt

Read each definition aloud, *as written*, quantifier by quantifier. Then ask:
what does it really say, and how does that differ from the comment?

* `∃ n, n > 0 → …`: is there an `n` for which the implication holds
  trivially?
* `∀ N, ∃ n ≥ N, …`: "after every index there is another one with …". Is
  that "from some index on"?
* `∃ M, ∀ n, M ≤ u n`: which `M` always works?

## Your task

Each counterexample must be **accepted** by the colleague's predicate, although
it does **not** have the property the comment describes:

* `noRoot`: no root other than 0, yet `HasPositiveRoot` accepts it.
* `notEventuallyZero`: not eventually 0, yet `EventuallyZero` accepts it.
* `bounded`: bounded, yet `Unbounded` accepts it.
-/
namespace L18

-- The colleague's code, to read (the referee uses its own copy).
def HasPositiveRoot (f : ℕ → ℕ) : Prop := ∃ n, n > 0 → f n = 0
def EventuallyZero (u : ℕ → ℕ) : Prop := ∀ N, ∃ n ≥ N, u n = 0
def Unbounded (u : ℕ → ℕ) : Prop := ∃ M, ∀ n, M ≤ u n

-- accepted by HasPositiveRoot, but no root other than 0
def noRoot : ℕ → ℕ := sorry

-- accepted by EventuallyZero, but not eventually 0
def notEventuallyZero : ℕ → ℕ := sorry

-- accepted by Unbounded, but bounded
def bounded : ℕ → ℕ := sorry

end L18
