/- Hidden test battery for Level 47: Spot the bug: topology. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L47.Player

open Top

namespace L47Ref
/-- Sam's continuity, with images. -/
def SamCont {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop :=
  ∀ U ∈ T, Ref.img f U ∈ S
instance {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) :
    Decidable (SamCont T S f) := by unfold SamCont; infer_instance
/-- The constant sequence at `p` converges to `x`. -/
def ConstConverges {n : Nat} (T : Family n) (p x : Fin n) : Prop := ∀ U ∈ T, x ∈ U → p ∈ U
instance {n : Nat} (T : Family n) (p x : Fin n) : Decidable (ConstConverges T p x) := by
  unfold ConstConverges; infer_instance
end L47Ref

#no_sorry L47.f₁
#no_sorry L47.f₂
#no_sorry L47.g
#no_sorry L47.p
#no_sorry L47.x
#no_sorry L47.y
#no_sorry L47.q1
#level_start "Spot the bug: topology"

#expect_true "Claim 1: f₁ is continuous from discrete 2 to Sierpiński space" unfolding L47.f₁ :
  Ref.IsContinuous (discrete 2) sierpinski L47.f₁
#expect_false "Claim 1: Sam's definition accepts f₁" unfolding L47.f₁ :
  L47Ref.SamCont (discrete 2) sierpinski L47.f₁
#expect_false "Claim 1: f₂ is continuous from Sierpiński space to discrete 2" unfolding L47.f₂ :
  Ref.IsContinuous sierpinski (discrete 2) L47.f₂
#expect_true "Claim 1: Sam's definition accepts f₂" unfolding L47.f₂ :
  L47Ref.SamCont sierpinski (discrete 2) L47.f₂
#expect_true "Claim 2: g is a bijection" unfolding L47.g : Ref.IsBijective L47.g
#expect_true "Claim 2: g is continuous from discrete 2 to Sierpiński space" unfolding L47.g :
  Ref.IsContinuous (discrete 2) sierpinski L47.g
#expect_false "Claim 2: g sends open sets to open sets (its inverse is continuous)" unfolding L47.g :
  ∀ U ∈ discrete 2, Ref.img L47.g U ∈ sierpinski
#expect_true "Claim 3: x and y are different" unfolding L47.x L47.y : L47.x ≠ L47.y
#expect_true "Claim 3: the constant sequence p converges to x" unfolding L47.p L47.x :
  L47Ref.ConstConverges sierpinski L47.p L47.x
#expect_true "Claim 3: the constant sequence p converges to y" unfolding L47.p L47.y :
  L47Ref.ConstConverges sierpinski L47.p L47.y
#expect_choice "Claim 4: does SamContAt hold for a constant function?" : L47.q1 = false

#level_report
