/-
# Subspace topology

The subspace topology on `A : Set α` is the topology induced by the inclusion
`Subtype.val : A → α`. For a set `s : Set A`, this means `s` is an inverse image
of some ambient open set `U`. Equivalently, in coordinates, its elements are
those of `A ∩ U`.

Mathlib calls this `TopologicalSpace.induced`; its theorem `continuous_induced_dom`
proves that the inclusion is continuous. A subset can be open in a larger space
without being closed. In Sierpiński space `{true}` is open but its complement
`{false}` is not open.

## Your tasks

Define `subspaceTopology` using `induced`, define `SubspaceOpen` by an ambient
open preimage, and supply `chosenSubset` and `openNotClosedSet`, both intended
to be `{true}` in `Bool`.
-/
namespace T10

def subspaceTopology {α : Type*} (τ : TopologicalSpace α) (A : Set α) :
    TopologicalSpace A := sorry

def SubspaceOpen {α : Type*} (τ : TopologicalSpace α) (A : Set α) (s : Set A) : Prop := sorry

def chosenSubset : Set Bool := sorry

def openNotClosedSet : Set Bool := sorry

end T10
