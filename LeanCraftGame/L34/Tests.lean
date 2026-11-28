/- Hidden test battery for Level 37: Rings, ideals, polynomials. -/
import LeanCraftGame.Referee
import LeanCraftGame.L34.Player

#no_sorry L34.I
#no_sorry L34.p
#no_sorry L34.inv3
#no_sorry L34.crt

-- The referee's normalisation would unfold `x ∈ Ideal.span s` into statements about sets:
-- membership in the player's ideal hides behind an irreducible name, and simp rewrites it
-- to divisibility (`Ideal.mem_span_singleton`).
attribute [simp] Ideal.mem_span_singleton L34.I
@[irreducible] def InI (x : ℤ) : Prop := x ∈ L34.I
@[simp] theorem InI_iff (x : ℤ) : InI x ↔ x ∈ L34.I := by unfold InI; rfl

#level_start "Rings, ideals, polynomials"

#expect_true "24 is in I" : InI 24
#expect_true "-36 is in I" : InI (-36)
#expect_false "6 is in I" : InI 6
#expect_false "4 is in I" : InI 4
#expect_true "p (2) = 0" unfolding L34.p : L34.p.eval 2 = 0
#expect_true "p (3) = 0" unfolding L34.p : L34.p.eval 3 = 0
#expect_true "p (0) = 6" unfolding L34.p : L34.p.eval 0 = 6
#expect_true "p (1) = 2" unfolding L34.p : L34.p.eval 1 = 2
#expect_true "3 * inv3 = 1 in ZMod 7" unfolding L34.inv3 : 3 * L34.inv3 = 1
#expect_equiv "crt: coprime moduli split ZMod (m * n)" :
  L34.crt ↔ ∀ m n : ℕ, Nat.Coprime m n → Nonempty (ZMod (m * n) ≃+* ZMod m × ZMod n)
  using fun m n h => ⟨ZMod.chineseRemainder h⟩

#level_report
