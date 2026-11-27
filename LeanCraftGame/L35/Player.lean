/-
# Sub-objects

*Noor needs sub-objects next: the even numbers inside ℕ, the multiples of 12 inside ℤ,
later a line inside the plane. Sam proposed "a subset closed under `+`", and the referee
found a subset that should not count before Sam had finished typing.*

A subgroup, a subring, a subspace: a subset that is closed under the operations. A
submonoid is a structure that bundles a set with the facts that make it one:

```lean
structure Submonoid₁ (M : Type) [Monoid M] where
  carrier : Set M                -- the subset
  -- the product of two elements of the submonoid is in it
  mul_mem {a b} : a ∈ carrier → b ∈ carrier → a * b ∈ carrier
  -- the unit is in it
  one_mem : 1 ∈ carrier
```

* `carrier : Set M` is a field that holds data: the subset.
* `mul_mem` and `one_mem` are fields that hold *propositions*: the axioms. A field such as
  `mul_mem {a b} : …` has its own binders; `{a b}` makes `a` and `b` implicit.

An instance `SetLike (Submonoid₁ M) M` then lets one write `x ∈ N` instead of
`x ∈ N.carrier`; Mathlib's `Submonoid`, `Subgroup`, `Ideal` and `Submodule` all work this
way.

For instance, in the `GaussInt` of level 30 the elements of norm 1, namely `1`, `-1`,
`i` and `-i`, form a submonoid for multiplication: `1` has norm 1, and since the norm is
multiplicative, a product of two elements of norm 1 has norm 1.

## Junk models

Leave out an axiom and the structure accepts subsets it should not. The set of numbers
`≥ 1` is closed under addition, but it is not an additive submonoid of ℕ: it misses `0`.
The referee checks your axioms against a zoo of subsets: real submonoids must satisfy
every axiom, and junk must break at least one.

## Set-builder notation

`{n : ℕ | P n}` is the set of `n` satisfying `P n`, as in the Sets and Functions world,
so `{n | n % 2 = 0}` is the even numbers, and `{n | k ∣ n}` the multiples of `k` (type
`\|` or `\mid` for `∣`).

## Your task

1. Complete `AddSubmonoid₁`, the additive version: the carrier is closed under `+` and
   contains `0`. Keep `carrier` as the first field and add the axioms after it.
2. Define `evens`, the even natural numbers, and `multiplesOf k`, the multiples of `k`.
-/
namespace L35

structure AddSubmonoid₁ (M : Type) [AddMonoid M] where
  carrier : Set M
  -- add the axioms here

-- the even natural numbers
def evens : Set ℕ := sorry

-- the natural numbers divisible by k
def multiplesOf (k : ℕ) : Set ℕ := sorry

end L35
