/- Hidden test battery for Level 38: Spot the bug: algebra. -/
import LeanCraftGame.Referee
import LeanCraftGame.L38.Player

open L38

#no_sorry L38.junk
#no_sorry L38.x
#no_sorry L38.p
#no_sorry L38.q
#no_sorry L38.a
#no_sorry L38.σ
#no_sorry L38.τ

-- membership in an ideal of ℤ, behind a name the referee's normalisation does not unfold
attribute [simp] Ideal.mem_span_singleton
@[irreducible] def InSpan2 (y : ℤ) : Prop := y ∈ Ideal.span {(2 : ℤ)}
@[simp] theorem InSpan2_iff (y : ℤ) : InSpan2 y ↔ y ∈ Ideal.span {(2 : ℤ)} := by unfold InSpan2; rfl

#level_start "Spot the bug: algebra"

#expect_true "Claim 1: junk contains 0 and is closed under +" unfolding L38.junk :
  0 ∈ L38.junk ∧ ∀ a b, a ∈ L38.junk → b ∈ L38.junk → a + b ∈ L38.junk
#expect_true "Claim 1: …and yet junk is not closed under negation" unfolding L38.junk :
  ∃ a, a ∈ L38.junk ∧ -a ∉ L38.junk
#expect_true "Claim 2: x is in Ideal.span {2}" unfolding L38.x : InSpan2 L38.x
#expect_true "Claim 2: …and x is not divisible by both 4 and 6" unfolding L38.x :
  ¬ (4 ∣ L38.x ∧ 6 ∣ L38.x)
#expect_true "Claim 3: the degree of p * q is not the sum of the degrees" unfolding L38.p L38.q :
  (L38.p * L38.q).natDegree ≠ L38.p.natDegree + L38.q.natDegree
#expect_true "Claim 4: in ZMod 7 every nonzero element has an inverse (7 is prime)" :
  ∀ b : ZMod 7, b ≠ 0 → ∃ c, b * c = 1
#expect_true "Claim 4: a is not 0 in ZMod 6" unfolding L38.a : L38.a ≠ 0
#expect_true "Claim 4: …and no b has a * b = 1" unfolding L38.a : ∀ b : ZMod 6, L38.a * b ≠ 1
#expect_true "Claim 5: σ * τ ≠ τ * σ" unfolding L38.σ L38.τ : L38.σ * L38.τ ≠ L38.τ * L38.σ

#level_report
