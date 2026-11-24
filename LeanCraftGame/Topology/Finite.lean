/-
# Executable finite-model checks

This module checks finite lists of finite subsets. It is deliberately separate
from `MyTopology` and from the general proof referee: success is exhaustive only
for the candidate's finite model, never a proof for an infinite space.
-/
import LeanCraftGame.Topology.Basic

namespace LeanCraftGame.Topology.Finite

open LeanCraftGame.Topology

/-- The independently checkable topology conditions. -/
inductive Axiom where
  | emptySet
  | universalSet
  | binaryIntersection
  | arbitraryUnion
  deriving Repr, DecidableEq

/-- A stable error record. `witnesses` contains the offending sets; for an
intersection failure they are `s`, `t`, and `s ∩ t`, and for a union failure
they are the chosen subfamily followed by its union. -/
structure Issue (α : Type*) [DecidableEq α] where
  kind : Axiom
  witnesses : List (Finset α)

namespace Issue

def code {α : Type*} [DecidableEq α] (issue : Issue α) : String :=
  match issue.kind with
  | .emptySet => "axiom_violation/missing_empty_set"
  | .universalSet => "axiom_violation/missing_universal_set"
  | .binaryIntersection => "axiom_violation/binary_intersection"
  | .arbitraryUnion => "axiom_violation/arbitrary_union"

def message {α : Type*} [DecidableEq α] (issue : Issue α) : String :=
  match issue.kind with
  | .emptySet => "The empty set is missing from the family."
  | .universalSet => "The universal finite set is missing from the family."
  | .binaryIntersection => "Two proposed open sets have an intersection outside the family."
  | .arbitraryUnion => "A subfamily has a union outside the proposed family."

end Issue

variable {α : Type*} [DecidableEq α]

/-- Find `s,t` in the family whose intersection is not in the family. -/
def badIntersection (opens : List (Finset α)) : Option (Finset α × Finset α) :=
  (opens.flatMap fun s => opens.map fun t => (s, t)).find? fun (s, t) =>
    !opens.contains (s ∩ t)

/-- Find a subfamily whose union is not in the family. Checking all subfamilies
is exhaustive for finite models (including the empty subfamily). -/
def badUnion [Fintype α] (opens : List (Finset α)) : Option (List (Finset α)) :=
  opens.sublists.find? fun family =>
    !opens.contains (family.foldr (· ∪ ·) ∅)

/-- Return the first violated axiom and its concrete witnesses, or `none` when
this finite model passes every topology check. -/
def validate [Fintype α] (opens : List (Finset α)) : Option (Issue α) :=
  if !opens.contains ∅ then
    some ⟨.emptySet, []⟩
  else if !opens.contains Finset.univ then
    some ⟨.universalSet, []⟩
  else match badIntersection opens with
    | some (s, t) => some ⟨.binaryIntersection, [s, t, s ∩ t]⟩
    | none => match badUnion opens with
      | some family => some ⟨.arbitraryUnion, family ++ [family.foldr (· ∪ ·) ∅]⟩
      | none => none

/-- Boolean convenience predicate; `validate` should be used for feedback. -/
def isTopology [Fintype α] (opens : List (Finset α)) : Bool :=
  (validate opens).isNone

/-- Every finite subset, as the executable discrete topology. -/
def discreteFamily : List (Finset Bool) := [∅, {false}, {true}, Finset.univ]

/-- The two open sets of the executable indiscrete topology. -/
def indiscreteFamily [Fintype α] : List (Finset α) := [∅, Finset.univ]

/-- The three open sets of Sierpiński space. -/
def sierpinskiFamily : List (Finset Bool) := [∅, {true}, Finset.univ]

end LeanCraftGame.Topology.Finite
