/- Hidden test battery for Level 36: Groups in Mathlib. -/
import LeanCraftGame.Referee
import LeanCraftGame.L33.Player

#no_sorry L33.lagrange
#no_sorry L33.cauchy
#no_sorry L33.ord4
#no_sorry L33.σ
#no_sorry L33.τ
#level_start "Groups in Mathlib"

#expect_equiv "lagrange: the order of a subgroup divides the order of the group" :
  L33.lagrange ↔ ∀ {G : Type} [Group G] (H : Subgroup G), Nat.card H ∣ Nat.card G
  using fun H => Subgroup.card_subgroup_dvd_card H
#expect_equiv "cauchy: a prime divisor of |G| is the order of an element" :
  L33.cauchy ↔ ∀ {G : Type} [Group G] [Fintype G] (p : ℕ), p.Prime → p ∣ Fintype.card G →
    ∃ x : G, orderOf x = p
  using fun p hp hd => @exists_prime_orderOf_dvd_card _ _ _ p ⟨hp⟩ hd
#expect_true "3 • (4 : ZMod 12) = 0" :
  3 • (4 : ZMod 12) = 0
#expect_true "ord4 • 4 = 0 in ZMod 12" unfolding L33.ord4 :
  L33.ord4 • (4 : ZMod 12) = 0
#expect_true "no smaller positive multiple of 4 is 0 in ZMod 12" unfolding L33.ord4 :
  ∀ k < L33.ord4, 0 < k → k • (4 : ZMod 12) ≠ 0
#expect_true "σ ^ 3 = 1, and σ ≠ 1" unfolding L33.σ :
  L33.σ ^ 3 = 1 ∧ L33.σ ≠ 1
#expect_true "τ ^ 2 = 1, and τ ≠ 1" unfolding L33.τ :
  L33.τ ^ 2 = 1 ∧ L33.τ ≠ 1
#expect_true "Perm (Fin 3) is not commutative: σ * τ ≠ τ * σ" unfolding L33.σ L33.τ :
  L33.σ * L33.τ ≠ L33.τ * L33.σ

#level_report
