/-
# Compactness

An open cover is a family `C : Set (Set α)` of open sets whose union is `univ`.
Compactness says that **every** such cover has a finite-subfamily subcover.
The finite set matters: selecting the whole infinite cover again does not solve
the problem. Indexed covers are equivalent; the unindexed version avoids
technology-specific universe bookkeeping.

Finite spaces are compact, infinite discrete spaces are not. An infinite
cofinite space is compact: one nonempty open cover member leaves only finitely
many points to cover. Continuous images of compact spaces are compact.

The `checks` for this level use general Lean/Mathlib theorems for finite and
infinite examples; finite enumeration is not used as a substitute for them.

## Your task

Define `MyCompact` using arbitrary open covers and `F : Finset (Set α)`.
Require `↑F ⊆ C` and `(⋃₀ (↑F : Set (Set α))) = Set.univ`.
-/
namespace T12

open LeanCraftGame.Topology

def MyCompact {α : Type*} (τ : MyTopology α) : Prop := sorry

end T12
