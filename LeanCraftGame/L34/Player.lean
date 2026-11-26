/-
# Morphisms

A structure is not studied alone: what matters is the maps that respect it. MIL 8.2
defines a homomorphism of monoids as a *bundled* structure, a function together with
the facts that it respects the operations:

```lean
structure MonoidHom₁ (G H : Type) [Monoid G] [Monoid H] where
  toFun : G → H
  map_one : toFun 1 = 1
  map_mul : ∀ g g', toFun (g * g') = toFun g * toFun g'
```

Mathlib's version is written `G →* H` (and `G →+ H` for additive monoids, `R →+* S` for
rings). A bundled map can be applied like a function, `f x`: Lean inserts a
**coercion** `⇑f : G → H` for you, which appears as `⇑f` in messages.

## Bundled and unbundled

A bundled `f : ℕ →* ℕ` is a function *with* its proofs. Sometimes you want to say of a
plain function `f : M → N` that it *is* a homomorphism: that is a predicate, an
"unbundled" definition. It must ask for exactly what the bundled structure asks for:

* `map_one`: `f 1 = 1`;
* `map_mul`: `f (a * b) = f a * f b` for all `a`, `b`.

Neither condition follows from the other. In `(ℕ, *, 1)`, the constant map `0` respects
multiplication (`0 = 0 * 0`) but sends `1` to `0`.

## Homomorphisms and bijections

A homomorphism need not be surjective (`n ↦ 2n` on `(ℤ, +)` misses the odd numbers), and
a bijection need not be a homomorphism: being a bijection is about the *sets*, being a
homomorphism is about the *operations*.

## Your task

1. `IsMonoidHom f`: `f` preserves `1` and `*`, for any two monoids `M` and `N`.
2. `IsAddMonoidHom f`: `f` preserves `0` and `+`, for any two additive monoids.
3. `homNotOnto`: an additive homomorphism `ℤ → ℤ` that is not surjective.
4. `bijNotHom`: a map `ℤ → ℤ` that is its own inverse (so it is a bijection) and is not
   an additive homomorphism.

The referee checks your predicates on many maps, and also that every bundled map
`f : M →* N` satisfies your `IsMonoidHom ⇑f`.
-/
namespace L34

-- f preserves 1 and multiplication
def IsMonoidHom {M N : Type} [Monoid M] [Monoid N] (f : M → N) : Prop := sorry

-- f preserves 0 and addition
def IsAddMonoidHom {M N : Type} [AddMonoid M] [AddMonoid N] (f : M → N) : Prop := sorry

-- an additive homomorphism of ℤ that is not surjective
def homNotOnto : ℤ → ℤ := sorry

-- a map of ℤ that is its own inverse, and is not an additive homomorphism
def bijNotHom : ℤ → ℤ := sorry

end L34
