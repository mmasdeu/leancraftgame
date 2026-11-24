open LeanCraftGame.Topology

def MyT0 {α : Type*} (τ : MyTopology α) : Prop :=
  ∀ x y : α, x ≠ y → ∃ U, τ.IsOpen U ∧ (x ∈ U ∧ y ∉ U ∨ y ∈ U ∧ x ∉ U)

def MyT1 {α : Type*} (τ : MyTopology α) : Prop :=
  ∀ x y : α, x ≠ y → ∃ U, x ∈ U ∧ y ∉ U

def MyHausdorff {α : Type*} (τ : MyTopology α) : Prop :=
  ∀ x y : α, x ≠ y → ∃ U V, τ.IsOpen U ∧ τ.IsOpen V ∧ x ∈ U ∧ y ∈ V ∧ U ∩ V = ∅
