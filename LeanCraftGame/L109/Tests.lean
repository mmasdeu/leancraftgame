/- Hidden test battery for Level Relations. -/
import LeanCraftGame.Referee
import LeanCraftGame.L109.Player

open L109

#no_sorry Reflexive'
#no_sorry Symmetric'
#no_sorry Transitive'
#no_sorry Antisymmetric'
#no_sorry IsEquivalence'
#no_sorry IsPartialOrder'
#level_start "Relations"

#expect_true "Reflexive' (· ≤ ·) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Reflexive' (· ≤ ·)
#expect_false "Reflexive' (· < ·) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Reflexive' (· < ·)
#expect_true "Reflexive' (· ∣ ·) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Reflexive' (· ∣ ·)
#expect_true "Reflexive' (fun a b => a % 3 = b % 3) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Reflexive' (fun a b => a % 3 = b % 3)
#expect_false "Reflexive' (fun a b => a ≠ b) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Reflexive' (fun a b => a ≠ b)
#expect_false "Reflexive' (fun _ _ => False) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Reflexive' (fun _ _ => False)
#expect_true "Reflexive' (fun _ _ => True) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Reflexive' (fun _ _ => True)
#expect_false "Symmetric' (· ≤ ·) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Symmetric' (· ≤ ·)
#expect_false "Symmetric' (· < ·) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Symmetric' (· < ·)
#expect_false "Symmetric' (· ∣ ·) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Symmetric' (· ∣ ·)
#expect_true "Symmetric' (fun a b => a % 3 = b % 3) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Symmetric' (fun a b => a % 3 = b % 3)
#expect_true "Symmetric' (fun a b => a ≠ b) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Symmetric' (fun a b => a ≠ b)
#expect_true "Symmetric' (fun _ _ => False) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Symmetric' (fun _ _ => False)
#expect_true "Symmetric' (fun _ _ => True) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Symmetric' (fun _ _ => True)
#expect_true "Transitive' (· ≤ ·) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Transitive' (· ≤ ·)
#expect_true "Transitive' (· < ·) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Transitive' (· < ·)
#expect_true "Transitive' (fun a b => a % 3 = b % 3) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Transitive' (fun a b => a % 3 = b % 3)
#expect_false "Transitive' (fun a b => a ≠ b) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Transitive' (fun a b => a ≠ b)
#expect_true "Transitive' (fun _ _ => False) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Transitive' (fun _ _ => False)
#expect_true "Transitive' (fun _ _ => True) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Transitive' (fun _ _ => True)
#expect_true "Antisymmetric' (· ≤ ·) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Antisymmetric' (· ≤ ·)
#expect_true "Antisymmetric' (· < ·) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Antisymmetric' (· < ·)
#expect_false "Antisymmetric' (fun a b => a % 3 = b % 3) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Antisymmetric' (fun a b => a % 3 = b % 3)
#expect_false "Antisymmetric' (fun a b => a ≠ b) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Antisymmetric' (fun a b => a ≠ b)
#expect_true "Antisymmetric' (fun _ _ => False) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Antisymmetric' (fun _ _ => False)
#expect_false "Antisymmetric' (fun _ _ => True) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  Antisymmetric' (fun _ _ => True)
#expect_true "IsEquivalence' (fun a b => a % 3 = b % 3) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  IsEquivalence' (fun a b => a % 3 = b % 3)
#expect_true "IsEquivalence' (fun _ _ => True) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  IsEquivalence' (fun _ _ => True)
#expect_false "IsEquivalence' (fun _ _ => False) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  IsEquivalence' (fun _ _ => False)
#expect_false "IsEquivalence' (fun a b => a ≠ b) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  IsEquivalence' (fun a b => a ≠ b)
#expect_true "IsPartialOrder' (· ≤ ·) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  IsPartialOrder' (· ≤ ·)
#expect_false "IsPartialOrder' (fun _ _ => False) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  IsPartialOrder' (fun _ _ => False)
#expect_false "IsEquivalence' (· < ·) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  IsEquivalence' (fun a b => a < b)
#expect_false "IsPartialOrder' (· ≠ ·) is false" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  IsPartialOrder' (fun a b => a ≠ b)
#expect_true "IsPartialOrder' (· = ·) is true" unfolding Reflexive' Symmetric' Transitive' Antisymmetric' IsEquivalence' IsPartialOrder' :
  IsPartialOrder' (fun a b => a = b)

#level_report
