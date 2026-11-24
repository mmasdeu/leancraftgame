/-
# Families of sets

A topology is not a property of a set: it is a *family* of subsets with good
closure properties. Before the axioms, we need a precise vocabulary for
families.

In this world the spaces are finite: the points are `Fin n = {0, 1, …, n-1}`,
a subset is a `Finset (Fin n)`, and a family of subsets has the type

```lean
Family n   -- an abbreviation for Finset (Finset (Fin n))
```

You write a family by listing its members: `({∅, {1}, {0, 1}} : Family 2)`.
Membership is `U ∈ F`; union, intersection and complement are `U ∪ V`,
`U ∩ V` and `Uᶜ`, and `Finset.univ` is the whole space. Everything here is
finite, so the referee checks your definitions *exhaustively*: it does not
search for a proof, it computes.

## Binary is enough (with a caveat)

A family closed under binary intersections is closed under every *nonempty*
finite intersection, by induction: `U₁ ∩ U₂ ∩ U₃ = (U₁ ∩ U₂) ∩ U₃`. The
*empty* intersection is the whole space, which induction never produces; this
is why a topology asks for the whole space separately. On a finite set every
union is a finite union, so the same remark applies to unions and `∅`.

The bounded quantifier `∀ U ∈ F, …` reads "for every member `U` of `F`, …".

## Your task

1. Define `UnionClosed F`: the union of any two members of `F` is a member.
2. Define `InterClosed F`: the intersection of any two members is a member.
3. Construct `lopsided`, a family on `{0, 1, 2}` that is closed under
   intersections but **not** under unions.

Before you run: is the empty family closed under unions?
-/
import LeanCraftGame.Lib.Topology

namespace L59

-- the union of any two members of F is a member of F
def UnionClosed {n : Nat} (F : Family n) : Prop := sorry

-- the intersection of any two members of F is a member of F
def InterClosed {n : Nat} (F : Family n) : Prop := sorry

-- a family on {0, 1, 2}, closed under intersections but not under unions
def lopsided : Family 3 := sorry

end L59
