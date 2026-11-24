/-
# Morphisms

A structure is only half of the story; the other half is the maps that
**preserve** it. A homomorphism of monoids `(M, ·, 1) → (N, ·, 1)` is a map
with `f(1) = 1` and `f(xy) = f(x) f(y)`. Continuous maps preserve
topologies, linear maps preserve linear combinations, monotone maps preserve
order.

Two of the commonest confusions:

* **Preserving the operation is not the same as being bijective.** The map
  `n ↦ 2n` preserves addition and misses every odd number. Swapping `0` and
  `1` is a bijection of `ℕ` that preserves nothing.
* **A morphism goes between two structures, which may differ.** The
  exponential `n ↦ 2ⁿ` is a homomorphism from `(ℕ, +, 0)` to `(ℕ, ·, 1)`:
  `2^(a+b) = 2^a · 2^b`, and `2⁰ = 1`. This is the whole point of
  logarithms, and of the exponential map of a Lie group.

An **isomorphism** is a morphism with an inverse morphism. For groups, a
bijective homomorphism is automatically an isomorphism; for topological
spaces a continuous bijection need not be a homeomorphism (the Topology
world has the counterexample). Which structures have this property is a
real question.

## Your task

Define the two kinds of homomorphism, and construct the two
counterexamples.
-/

namespace L48

-- f is a homomorphism of (ℕ, +, 0) to itself: f 0 = 0 and f (a + b) = f a + f b
def IsAddHom (f : ℕ → ℕ) : Prop := sorry

-- f is a homomorphism of (ℕ, +, 0) to (ℕ, ·, 1): f 0 = 1 and f (a + b) = f a · f b
def IsExpHom (f : ℕ → ℕ) : Prop := sorry

-- an additive homomorphism that is not surjective
def homNotOnto : ℕ → ℕ := sorry

-- a bijection of ℕ that is its own inverse and is not an additive homomorphism
def bijNotHom : ℕ → ℕ := sorry

end L48
