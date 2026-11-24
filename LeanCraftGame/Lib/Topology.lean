/-
# The shared library of the Topology world

Finite topological spaces, small enough for the referee to check everything by
exhaustive computation (`decide`). The points of a finite space are `Fin n =
{0, 1, …, n-1}`, a subset is a `Finset (Fin n)`, and a *family* of subsets is a
`Finset (Finset (Fin n))`. On a finite set every union is a finite union, so the
topology axioms only need `∅`, the whole set, binary unions and binary
intersections.

The definitions in the namespace `Ref` are the referee's own: the tests state
facts about the standard examples with them (for example "the family you built
is a topology"), so that a level never depends on a definition the player wrote
in an earlier level. The player writes their own definitions, under their own
names, in each level.
-/
import Mathlib.Tactic

/-- A family of subsets of the finite set `Fin n = {0, 1, …, n-1}`. -/
abbrev Family (n : Nat) := Finset (Finset (Fin n))

namespace Top

/-! ## The standard examples (T5 asks the player to build them; later levels use these) -/

/-- The Sierpiński space: two points `0` and `1`, and `{1}` is open but `{0}` is not. -/
def sierpinski : Family 2 := {∅, {1}, Finset.univ}

/-- The discrete topology: every subset is open. -/
def discrete (n : Nat) : Family n := Finset.univ.powerset

/-- The indiscrete topology: only `∅` and the whole space are open. -/
def indiscrete (n : Nat) : Family n := {∅, Finset.univ}

/-- The particular-point topology: the open sets are `∅` and the sets containing `p`. -/
def particularPoint (n : Nat) (p : Fin n) : Family n :=
  insert ∅ (Finset.univ.powerset.filter (fun U => p ∈ U))

/-- The excluded-point topology: the open sets are the whole space and the sets missing `p`. -/
def excludedPoint (n : Nat) (p : Fin n) : Family n :=
  insert Finset.univ (Finset.univ.powerset.filter (fun U => p ∉ U))

/-- A chain of three points: `∅ ⊂ {0} ⊂ {0, 1} ⊂ {0, 1, 2}`. -/
def chain3 : Family 3 := {∅, {0}, {0, 1}, Finset.univ}

/-! ## The referee's definitions -/

namespace Ref

/-- The inverse image `f⁻¹(V)`. -/
def pre {m n : Nat} (f : Fin m → Fin n) (V : Finset (Fin n)) : Finset (Fin m) :=
  Finset.univ.filter (fun x => f x ∈ V)

/-- The image `f(A)`. -/
def img {m n : Nat} (f : Fin m → Fin n) (A : Finset (Fin m)) : Finset (Fin n) :=
  Finset.univ.filter (fun y => ∃ x ∈ A, f x = y)

def IsTopology {n : Nat} (T : Family n) : Prop :=
  ∅ ∈ T ∧ Finset.univ ∈ T ∧ ∀ U ∈ T, ∀ V ∈ T, U ∪ V ∈ T ∧ U ∩ V ∈ T

instance {n : Nat} (T : Family n) : Decidable (IsTopology T) := by
  unfold IsTopology; infer_instance

def IsClosed {n : Nat} (T : Family n) (A : Finset (Fin n)) : Prop := Aᶜ ∈ T

def IsContinuous {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop :=
  ∀ V ∈ S, pre f V ∈ T

instance {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) :
    Decidable (IsContinuous T S f) := by
  unfold IsContinuous; infer_instance

def IsBijective {m n : Nat} (f : Fin m → Fin n) : Prop :=
  (∀ x y, f x = f y → x = y) ∧ ∀ y, ∃ x, f x = y

instance {m n : Nat} (f : Fin m → Fin n) : Decidable (IsBijective f) := by
  unfold IsBijective; infer_instance

/-- Homeomorphic: some bijection is continuous with continuous inverse, that is, it is
continuous and sends open sets to open sets. -/
def Homeomorphic {m n : Nat} (T : Family m) (S : Family n) : Prop :=
  ∃ f : Fin m → Fin n, IsBijective f ∧ IsContinuous T S f ∧ ∀ U ∈ T, img f U ∈ S

instance {m n : Nat} (T : Family m) (S : Family n) : Decidable (Homeomorphic T S) := by
  unfold Homeomorphic; infer_instance

def IsConnected {n : Nat} (T : Family n) : Prop :=
  ∀ U ∈ T, Uᶜ ∈ T → U = ∅ ∨ U = Finset.univ

instance {n : Nat} (T : Family n) : Decidable (IsConnected T) := by
  unfold IsConnected; infer_instance

def IsT0 {n : Nat} (T : Family n) : Prop :=
  ∀ x y : Fin n, x ≠ y → ∃ U ∈ T, (x ∈ U ∧ y ∉ U) ∨ (y ∈ U ∧ x ∉ U)

def IsT1 {n : Nat} (T : Family n) : Prop :=
  ∀ x y : Fin n, x ≠ y → ∃ U ∈ T, x ∈ U ∧ y ∉ U

def IsT2 {n : Nat} (T : Family n) : Prop :=
  ∀ x y : Fin n, x ≠ y → ∃ U ∈ T, ∃ V ∈ T, x ∈ U ∧ y ∈ V ∧ U ∩ V = ∅

instance {n : Nat} (T : Family n) : Decidable (IsT0 T) := by unfold IsT0; infer_instance
instance {n : Nat} (T : Family n) : Decidable (IsT1 T) := by unfold IsT1; infer_instance
instance {n : Nat} (T : Family n) : Decidable (IsT2 T) := by unfold IsT2; infer_instance

end Ref

end Top
