/-
# Naming things

Visiting Ramanujan in hospital, Hardy remarked that his taxi had a dull
number, 1729. Ramanujan replied that it was a very interesting number: the
smallest that is a sum of two cubes in two different ways.

Mathematics starts by giving names to things. In Lean a name is introduced
with `def`:

```lean
def hardy : Nat := 1729
```

* `hardy` is the name,
* `Nat` is its **type**: the natural numbers `0, 1, 2, …` (also written `ℕ`),
* `1729` is its value.

Every object in Lean has a type, and Lean checks that the value has the
type you announced. Arithmetic is written as usual: `+`, `*`, and `^` for
powers, so `12 ^ 3` is `12³`. A name can be used in later definitions.

In this game you only write **definitions**. Every statement about them is
checked by the **referee**, an automatic prover that proves or refutes it.
In this first world its job is easy: it computes.

## Your task

Replace each `sorry` (Lean's placeholder for "not written yet") by a value.
Then press **Run tests**.
-/

namespace L1

-- the number of Hardy's taxi
def hardy : Nat := sorry

-- 1³ + 12³, written with `^`
def firstWay : Nat := sorry

-- 9³ + 10³
def secondWay : Nat := sorry

end L1
