/- Hidden test battery for Level 31: Spot the bug: structures. -/
import LeanCraftGame.Referee
import LeanCraftGame.L31.Player

namespace L31Ref
def mul (z w : L31.GaussInt) : L31.GaussInt :=
  ⟨z.re * w.re + z.im * w.im, z.re * w.im + z.im * w.re⟩
def mulRight (z w : L31.GaussInt) : L31.GaussInt :=
  ⟨z.re * w.re - z.im * w.im, z.re * w.im + z.im * w.re⟩
def mid (a b : L31.Point) : L31.Point :=
  ⟨(a.x + b.x) / 2, (a.y + b.y) / 2, (a.z + a.z) / 2⟩
structure UnitInterval where
  t : ℚ
  in_range : 0 ≤ t ∨ t ≤ 1
end L31Ref

#no_sorry L31.gz
#no_sorry L31.gw
#no_sorry L31.pa
#no_sorry L31.pb
#no_sorry L31.badT
#level_start "Spot the bug: structures"

#expect_false "with the colleague's product, i · i = -1" unfolding L31Ref.mul :
  (L31Ref.mul ⟨0, 1⟩ ⟨0, 1⟩).re = -1
#expect_true "the colleague's product of gz and gw is wrong" unfolding L31Ref.mul L31Ref.mulRight L31.gz L31.gw :
  (L31Ref.mul L31.gz L31.gw).re ≠ (L31Ref.mulRight L31.gz L31.gw).re
#expect_true "the colleague's midpoint of pa and pb depends on the order" unfolding L31Ref.mid L31.pa L31.pb :
  (L31Ref.mid L31.pa L31.pb).z ≠ (L31Ref.mid L31.pb L31.pa).z
#expect_model "badT satisfies the colleague's in_range" : L31Ref.UnitInterval.mk L31.badT
#expect_true "badT is not between 0 and 1" unfolding L31.badT : ¬ (0 ≤ L31.badT ∧ L31.badT ≤ 1)

#level_report
