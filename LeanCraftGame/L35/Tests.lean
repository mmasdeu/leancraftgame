/- Hidden test battery for Level 35: Sub-objects. -/
import LeanCraftGame.Referee
import LeanCraftGame.L35.Player

open L35

#no_sorry evens
#no_sorry multiplesOf
#level_start "Sub-objects"

#expect_true "evens contains 0 and 4, but not 7" unfolding evens :
  0 ∈ evens ∧ 4 ∈ evens ∧ 7 ∉ evens
#expect_true "multiplesOf 3 contains 0 and 6, but not 4" unfolding multiplesOf :
  0 ∈ multiplesOf 3 ∧ 6 ∈ multiplesOf 3 ∧ 4 ∉ multiplesOf 3

#expect_model "the even numbers are an additive submonoid of ℕ" :
  AddSubmonoid₁.mk (M := ℕ) {n | n % 2 = 0}
#expect_model "the multiples of 3 are an additive submonoid of ℕ" :
  AddSubmonoid₁.mk (M := ℕ) {n | 3 ∣ n}
#expect_model "{0} is an additive submonoid of ℕ" :
  AddSubmonoid₁.mk (M := ℕ) {0}
#expect_model "all of ℤ is an additive submonoid of ℤ" :
  AddSubmonoid₁.mk (M := ℤ) Set.univ

#expect_not_model "the odd numbers are not an additive submonoid" :
  AddSubmonoid₁.mk (M := ℕ) {n | n % 2 = 1}
#expect_not_model "the numbers ≥ 1 are not an additive submonoid" :
  AddSubmonoid₁.mk (M := ℕ) {n | 1 ≤ n}
#expect_not_model "{0, 1} is not an additive submonoid" :
  AddSubmonoid₁.mk (M := ℕ) {0, 1}
#expect_not_model "the numbers other than 2 are not an additive submonoid" :
  AddSubmonoid₁.mk (M := ℕ) {n | n ≠ 2}

#level_report
