/-
# Families of sets

An **indexed family** of subsets of `α` is a function `ι → Set α`: each index
chooses one subset. We also work with an **unindexed family** `C : Set (Set α)`,
a set whose elements are themselves sets.

For unindexed families, `⋃₀ D` is the union of every set in `D`. Closure under
arbitrary unions says that whenever `D ⊆ C`, we also have `⋃₀ D ∈ C`.
Closure under binary intersections is a different condition.

## Your tasks

1. Define `Family α ι` as the type of `ι`-indexed families of subsets of `α`.
2. Define `ClosedUnderUnions C` using *every* subfamily `D ⊆ C`.
3. Define `ClosedUnderBinaryIntersections C` using every `s,t ∈ C`.
4. Give a family on `Fin 3` that is closed under binary intersections but not
   arbitrary unions. The intended family is `{∅, {0}, {1}, univ}`: its binary
   intersections are present, but `{0} ∪ {1} = {0,1}` is missing.
-/
namespace T2

def Family (α : Type*) (ι : Type*) : Type _ := sorry

def ClosedUnderUnions {α : Type*} (C : Set (Set α)) : Prop := sorry

def ClosedUnderBinaryIntersections {α : Type*} (C : Set (Set α)) : Prop := sorry

def FiniteButNotUnionClosed : List (Finset (Fin 3)) := sorry

end T2
