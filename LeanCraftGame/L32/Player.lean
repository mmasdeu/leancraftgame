/-
# Sub-objects

*Noor needs sub-objects next: the even numbers inside ℕ, the multiples of 12 inside ℕ.
Sam proposed "a subset closed under `+`". The referee quickly found a subset that passes
and shouldn't.*

A submonoid is a structure that bundles a set with the facts that make it closed under the
operations:

```lean
structure Submonoid₁ (M : Type) [Monoid M] where
  carrier : Set M                -- the subset
  -- the product of two elements of the submonoid is in it
  mul_mem {a b} : a ∈ carrier → b ∈ carrier → a * b ∈ carrier
  -- the unit is in it
  one_mem : 1 ∈ carrier
```

* `carrier : Set M` holds data, the subset.
* `mul_mem` and `one_mem` hold propositions, the axioms. `mul_mem {a b} : …` has its own
  binders, and `{a b}` makes `a` and `b` implicit.

## Junk models

Leave out an axiom and junk gets in. The numbers `≥ 2` are closed under multiplication,
but they aren't a submonoid of `(ℕ, *, 1)`: `1` is missing. The referee tests your axioms
on many subsets. Real submonoids must satisfy every axiom, and junk must break at least one.

## Set-builder notation

`{n : ℕ | P n}` is the set of `n` satisfying `P n`, as in the Sets and Functions world. So
`{n | n % 2 = 0}` is the even numbers, and `{n | k ∣ n}` the multiples of `k` (type `\mid`
for `∣`). A list in braces, like `{0, 1}`, is the set with exactly those elements.

## Your task

1. Complete `AddSubmonoid₁`, the additive version: the carrier is closed under `+` and
   contains `0`. Keep `carrier` as the first field and add the axioms after it. Name them
   as you like, say `add_mem` and `zero_mem`.
2. Define `evens`, the even natural numbers, and `multiplesOf k`, the multiples of `k`.
-/
namespace L32

structure AddSubmonoid₁ (M : Type) [AddMonoid M] where
  carrier : Set M
  -- add the axioms here

-- the even natural numbers
def evens : Set ℕ := sorry

-- the natural numbers divisible by k
def multiplesOf (k : ℕ) : Set ℕ := sorry

end L32
