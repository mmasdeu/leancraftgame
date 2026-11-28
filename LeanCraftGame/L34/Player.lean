/-
# Morphisms

*What matters about a structure is the maps that respect it. Sam's first homomorphism
checked products and forgot the unit.*

`[Monoid M]` says `M` has `*` and `1` with the monoid laws; `[AddMonoid M]` says the same
for `+` and `0`. Mathlib defines a monoid homomorphism as a **bundled** structure, a function plus the facts
that it respects the operations:

```lean
structure MonoidHom₁ (G H : Type) [Monoid G] [Monoid H] where
  toFun : G → H
  map_one : toFun 1 = 1
  map_mul : ∀ g g', toFun (g * g') = toFun g * toFun g'
```

Mathlib writes it `G →* H` (and `G →+ H` for additive monoids, `R →+* S` for rings). You
apply a bundled map like a function, `f x`.

## Bundled and unbundled

Sometimes you want to say that a plain function `f : M → N` is a homomorphism. That's a
predicate, an "unbundled" definition. It must ask for exactly what the bundled structure
asks for:

* `map_one`: `f 1 = 1`;
* `map_mul`: `f (a * b) = f a * f b` for all `a`, `b`.

Neither implies the other: a map can respect `*` and still send `1` elsewhere.

You've met one homomorphism already: the norm `N(a + bi) = a² + b²` of the `GaussInt` of
level 30. It has `N(zw) = N(z) N(w)` and `N(1) = 1`, so it's a monoid homomorphism from
`(ℤ[i], ·, 1)` to `(ℤ, ·, 1)`.

## Your task

1. `IsMonoidHom f`: `f` preserves `1` and `*`, for any two monoids `M` and `N`. Join the
   conditions with `∧` (level 11).
2. `IsAddMonoidHom f`: `f` preserves `0` and `+`, for any two additive monoids.
3. `homNotOnto`: an additive homomorphism `ℤ → ℤ` that isn't surjective.
4. `bijNotHom`: a map `ℤ → ℤ` with `f (f n) = n` for every `n` (so a bijection) that isn't
   an additive homomorphism.

The referee tests your predicates on many maps. It also checks that every bundled
`f : M →* N` satisfies your `IsMonoidHom`.
-/
namespace L34

-- f preserves 1 and multiplication
def IsMonoidHom {M N : Type} [Monoid M] [Monoid N] (f : M → N) : Prop := sorry

-- f preserves 0 and addition
def IsAddMonoidHom {M N : Type} [AddMonoid M] [AddMonoid N] (f : M → N) : Prop := sorry

-- an additive homomorphism of ℤ that isn't surjective
def homNotOnto : ℤ → ℤ := sorry

-- a map of ℤ with f (f n) = n that isn't an additive homomorphism
def bijNotHom : ℤ → ℤ := sorry

end L34
