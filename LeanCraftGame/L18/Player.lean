/-
# Existence of a witness

**ACT I — SEQUENCES**

This is the same journey, in a new order: **sequences → limits → topology**. Your
current step is to **use ∃ for a zero, a large reading or another special observation, and distinguish naming a witness from proving universality.**

`∃ n, P n` means "there **exists** a natural number `n` such that `P n`
holds". Type `∃` as `\exists`, or write `exists`.

```lean
def HasBig (u : Nat → Nat) : Prop := ∃ n, 10 ≤ u n
```

This says that **at least one** term of `u` is at least 10.

* `∀` and `∃` are opposites: the opposite of "all terms are big" is "some term
  is small", not "all terms are small".
* To say that a position has *two* properties, join them inside the `∃`:
  `∃ n, P n ∧ Q n`.

## Your task

`HasBig` is done. Define `HasZero u` (some term is zero) and `HasEvenBig u`
(some term is even **and** at least 10, both for the same `n`).

## The road from here

Control the order in which witnesses are chosen.

-/
namespace L18

-- some term is at least 10 (already done)
def HasBig (u : Nat → Nat) : Prop := ∃ n, 10 ≤ u n

-- some term is zero
def HasZero (u : Nat → Nat) : Prop := sorry

-- some single term is both even and at least 10
def HasEvenBig (u : Nat → Nat) : Prop := sorry

end L18
