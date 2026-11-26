/- Hidden test battery for Level 27: Spot the bug: counting. -/
import LeanCraftGame.Referee
import LeanCraftGame.L27.Player

namespace L27Ref
open L27.BinTree
def triangle (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, i
def triangleRight (n : ℕ) : ℕ := ∑ i ∈ Finset.Icc 1 n, i
def numDivisors (n : ℕ) : ℕ := ((Finset.Ico 1 n).filter (· ∣ n)).card
def numDivisorsRight (n : ℕ) : ℕ := ((Finset.Icc 1 n).filter (· ∣ n)).card
def size : L27.BinTree → ℕ
  | empty => 0
  | node l r => size l + size r
def sizeRight : L27.BinTree → ℕ
  | empty => 0
  | node l r => sizeRight l + sizeRight r + 1
end L27Ref

#no_sorry L27.tn
#no_sorry L27.dn
#no_sorry L27.tree
#no_sorry L27.gn
#level_start "Spot the bug: counting"

#expect_true "the colleague's triangle is right at 0" :
  L27Ref.triangle 0 = L27Ref.triangleRight 0
#expect_true "triangle is wrong on your tn" unfolding L27Ref.triangle L27Ref.triangleRight L27.tn :
  L27Ref.triangle L27.tn ≠ L27Ref.triangleRight L27.tn
#expect_true "numDivisors is wrong on your dn" unfolding L27Ref.numDivisors L27Ref.numDivisorsRight L27.dn :
  L27Ref.numDivisors L27.dn ≠ L27Ref.numDivisorsRight L27.dn
#expect_true "size is wrong on your tree" unfolding L27.tree :
  L27Ref.size L27.tree ≠ L27Ref.sizeRight L27.tree
#expect_true "the colleague's formula is false for your gn" unfolding L27.gn :
  ∑ i ∈ Finset.range L27.gn, i ≠ L27.gn * (L27.gn + 1) / 2

#level_report
