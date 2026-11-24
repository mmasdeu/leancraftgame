/-

# Bases and generated topologies

A basis `B` covers every point and satisfies an **intersection-refinement**
condition: if `x ∈ U ∩ V` for basis sets `U,V`, some basis set `W` contains `x`
and satisfies `W ⊆ U ∩ V`. The second condition does **not** require `U ∩ V`
itself to belong to `B`.

A set is open in the generated topology exactly when it is a union of basis
sets. The two singleton subsets of `Bool` illustrate the distinction: they form
a basis for the discrete topology, but their family is not itself a topology
because its union closure adds `∅` and `univ`.

For the usual topology on `ℝ`, open intervals with rational endpoints satisfy
the same two conditions; density of `ℚ` supplies the refinements.

**ACT III — TOPOLOGY**

The earlier acts gave you the vocabulary needed here: functions and quantifiers from
**sequences**, inverse images and local approximation from **limits**, and packaged
axioms from **structures**. This level turns those tools toward general spaces.

## The road from here

Use basis-generated opens to define continuous maps and distinguish them from open maps.


## Your tasks

Define `CoversBy`, `IntersectionRefines`, and `GeneratedOpen`, then supply the
`twoPointBasis : Set (Set Bool)` consisting of `{true}` and `{false}`.
-/
namespace T7

def CoversBy {α : Type*} (B : Set (Set α)) : Prop := sorry

def IntersectionRefines {α : Type*} (B : Set (Set α)) : Prop := sorry

def GeneratedOpen {α : Type*} (B : Set (Set α)) (s : Set α) : Prop := sorry

def twoPointBasis : Set (Set Bool) := sorry

end T7
