/- Hidden test battery for Level Spot the bug: numbers. -/
import LeanCraftGame.Referee
import LeanCraftGame.L15.Player

namespace L15Ref
def diff (a b : ℕ) : ℤ := ((a - b : ℕ) : ℤ)
def IsReciprocal (x y : ℚ) : Prop := y = 1 / x
def average (a b : ℚ) : ℚ := a + b / 2
end L15Ref

#no_sorry L15.diffA
#no_sorry L15.diffB
#no_sorry L15.recX
#no_sorry L15.recY
#no_sorry L15.avgA
#no_sorry L15.avgB
#level_start "Spot the bug: numbers"

#expect_true "diff gets your two numbers wrong" unfolding L15Ref.diff L15.diffA L15.diffB :
  L15Ref.diff L15.diffA L15.diffB ≠ (L15.diffA : ℤ) - (L15.diffB : ℤ)
#expect_true "IsReciprocal accepts your two numbers" unfolding L15Ref.IsReciprocal L15.recX L15.recY :
  L15Ref.IsReciprocal L15.recX L15.recY
#expect_true "your two numbers do not multiply to 1" unfolding L15.recX L15.recY :
  ¬ (L15.recX * L15.recY = 1)
#expect_true "average gets your two numbers wrong" unfolding L15Ref.average L15.avgA L15.avgB :
  L15Ref.average L15.avgA L15.avgB ≠ (L15.avgA + L15.avgB) / 2

#level_report
