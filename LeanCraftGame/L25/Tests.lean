/- Hidden test battery for Level Spot the bug: numbers. -/
import LeanCraftGame.Referee
import LeanCraftGame.L25.Player

namespace L25Ref
def diff (a b : ℕ) : ℤ := ((a - b : ℕ) : ℤ)
def IsReciprocal (x y : ℚ) : Prop := y = 1 / x
def average (a b : ℚ) : ℚ := a + b / 2
end L25Ref

#no_sorry L25.diffA
#no_sorry L25.diffB
#no_sorry L25.recX
#no_sorry L25.recY
#no_sorry L25.avgA
#no_sorry L25.avgB
#level_start "Spot the bug: numbers"

#expect_true "diff gets your two numbers wrong" unfolding L25Ref.diff L25.diffA L25.diffB :
  L25Ref.diff L25.diffA L25.diffB ≠ (L25.diffA : ℤ) - (L25.diffB : ℤ)
#expect_true "IsReciprocal accepts your two numbers" unfolding L25Ref.IsReciprocal L25.recX L25.recY :
  L25Ref.IsReciprocal L25.recX L25.recY
#expect_false "your two numbers multiply to 1" unfolding L25.recX L25.recY :
  L25.recX * L25.recY = 1
#expect_true "average gets your two numbers wrong" unfolding L25Ref.average L25.avgA L25.avgB :
  L25Ref.average L25.avgA L25.avgB ≠ (L25.avgA + L25.avgB) / 2

#level_report
