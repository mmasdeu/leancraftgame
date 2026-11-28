/- Hidden test battery for Level 16: Images and preimages. -/
import LeanCraftGame.Referee
import LeanCraftGame.L17.Player

open L17

#no_sorry squares
#no_sorry evensPre
#no_sorry L17.preimage_inter'
#no_sorry f₀
#no_sorry s₀
#no_sorry t₀
#no_sorry y₀
#level_start "Images and preimages"

#expect_true "9 ∈ squares" unfolding squares Set.range : 9 ∈ squares
#expect_true "16 ∈ squares" unfolding squares Set.range : 16 ∈ squares
#expect_true "2 ∈ evensPre" unfolding evensPre Set.preimage : 2 ∈ evensPre
#expect_false "3 ∈ evensPre" unfolding evensPre Set.preimage : 3 ∈ evensPre
#expect_true "8 ∈ evensPre" unfolding evensPre Set.preimage : 8 ∈ evensPre
#expect_equiv "preimage_inter' says f ⁻¹' (u ∩ v) = f ⁻¹' u ∩ f ⁻¹' v" :
  L17.preimage_inter' ↔ ∀ {α β : Type} (f : α → β) (u v : Set β), f ⁻¹' (u ∩ v) = f ⁻¹' u ∩ f ⁻¹' v
  using fun _ _ _ => Set.preimage_inter
#expect_true "y₀ is in the image of s₀" unfolding y₀ f₀ s₀ Set.image : y₀ ∈ f₀ '' s₀
#expect_true "y₀ is in the image of t₀" unfolding y₀ f₀ t₀ Set.image : y₀ ∈ f₀ '' t₀
#expect_true "y₀ is not in the image of s₀ ∩ t₀" unfolding y₀ f₀ s₀ t₀ Set.image : y₀ ∉ f₀ '' (s₀ ∩ t₀)

#level_report
