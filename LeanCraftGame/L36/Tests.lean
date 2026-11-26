/- Hidden test battery for Level 36: Groups in Mathlib. -/
import LeanCraftGame.Referee
import LeanCraftGame.L36.Player

#no_sorry L36.lagrange
#no_sorry L36.cauchy
#no_sorry L36.ord4
#no_sorry L36.σ
#no_sorry L36.τ
#level_start "Groups in Mathlib"

#expect_equiv "lagrange: the order of a subgroup divides the order of the group" :
  L36.lagrange ↔ ∀ {G : Type} [Group G] (H : Subgroup G), Nat.card H ∣ Nat.card G
  using fun H => Subgroup.card_subgroup_dvd_card H
#expect_equiv "cauchy: a prime divisor of |G| is the order of an element" :
  L36.cauchy ↔ ∀ {G : Type} [Group G] [Fintype G] (p : ℕ), p.Prime → p ∣ Fintype.card G →
    ∃ x : G, orderOf x = p
  using fun p hp hd => @exists_prime_orderOf_dvd_card _ _ _ p ⟨hp⟩ hd
#expect_true "3 • (4 : ZMod 12) = 0" :
  3 • (4 : ZMod 12) = 0
#expect_true "ord4 • 4 = 0 in ZMod 12" unfolding L36.ord4 :
  L36.ord4 • (4 : ZMod 12) = 0
#expect_true "no smaller positive multiple of 4 is 0 in ZMod 12" unfolding L36.ord4 :
  ∀ k < L36.ord4, 0 < k → k • (4 : ZMod 12) ≠ 0
#expect_true "σ ^ 3 = 1, and σ ≠ 1" unfolding L36.σ :
  L36.σ ^ 3 = 1 ∧ L36.σ ≠ 1
#expect_true "τ ^ 2 = 1, and τ ≠ 1" unfolding L36.τ :
  L36.τ ^ 2 = 1 ∧ L36.τ ≠ 1
#expect_true "Perm (Fin 3) is not commutative: σ * τ ≠ τ * σ" unfolding L36.σ L36.τ :
  L36.σ * L36.τ ≠ L36.τ * L36.σ

#level_report
