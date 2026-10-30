/- Hidden test battery for Level Spot the bug: numbers. -/
import LeanCraftGame.Referee
import LeanCraftGame.L12.Player

namespace L25Ref
def diff (a b : ℕ) : ℤ := ((a - b : ℕ) : ℤ)
def IsReciprocal (x y : ℚ) : Prop := y = 1 / x
def average (a b : ℚ) : ℚ := a + b / 2
end L25Ref

#no_sorry L12.diffA
#no_sorry L12.diffB
#no_sorry L12.recX
#no_sorry L12.recY
#no_sorry L12.avgA
#no_sorry L12.avgB
#level_start "Spot the bug: numbers"

#expect_true "diff gets your two numbers wrong" unfolding L25Ref.diff L12.diffA L12.diffB :
  L25Ref.diff L12.diffA L12.diffB ≠ (L12.diffA : ℤ) - (L12.diffB : ℤ)
#expect_true "IsReciprocal accepts your two numbers" unfolding L25Ref.IsReciprocal L12.recX L12.recY :
  L25Ref.IsReciprocal L12.recX L12.recY
#expect_true "your two numbers do not multiply to 1" unfolding L12.recX L12.recY :
  ¬ (L12.recX * L12.recY = 1)
#expect_true "average gets your two numbers wrong" unfolding L25Ref.average L12.avgA L12.avgB :
  L25Ref.average L12.avgA L12.avgB ≠ (L12.avgA + L12.avgB) / 2

#level_report
