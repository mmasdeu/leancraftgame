/- Hidden test battery for Level Spot the bug: sums. -/
import LeanCraftGame.Referee
import LeanCraftGame.L38.Player

namespace L38Ref
def triangle (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, i
def triangleRight (n : ℕ) : ℕ := ∑ i ∈ Finset.Icc 1 n, i
def numDivisors (n : ℕ) : ℕ := (Finset.filter (fun d => d ∣ n) (Finset.Ico 1 n)).card
def numDivisorsRight (n : ℕ) : ℕ := (Finset.filter (fun d => d ∣ n) (Finset.Icc 1 n)).card
def primesUpTo (n : ℕ) : ℕ := (Finset.filter (fun p => Nat.Prime p) (Finset.range n)).card
def primesUpToRight (n : ℕ) : ℕ := (Finset.filter (fun p => Nat.Prime p) (Finset.range (n + 1))).card
def evenSquares (n : ℕ) : ℕ := (∑ i ∈ Finset.filter (fun i => i % 2 = 0) (Finset.range n), i) ^ 2
def evenSquaresRight (n : ℕ) : ℕ := ∑ i ∈ Finset.filter (fun i => i % 2 = 0) (Finset.range n), i ^ 2
end L38Ref

#no_sorry L38.tn
#no_sorry L38.dn
#no_sorry L38.pn
#no_sorry L38.en
#level_start "Spot the bug: sums"

#expect_true "triangle is wrong on your tn" unfolding L38Ref.triangle L38Ref.triangleRight L38.tn :
  L38Ref.triangle L38.tn ≠ L38Ref.triangleRight L38.tn
#expect_true "numDivisors is wrong on your dn" unfolding L38Ref.numDivisors L38Ref.numDivisorsRight L38.dn :
  L38Ref.numDivisors L38.dn ≠ L38Ref.numDivisorsRight L38.dn
#expect_true "primesUpTo is wrong on your pn" unfolding L38Ref.primesUpTo L38Ref.primesUpToRight L38.pn :
  L38Ref.primesUpTo L38.pn ≠ L38Ref.primesUpToRight L38.pn
#expect_true "evenSquares is wrong on your en" unfolding L38Ref.evenSquares L38Ref.evenSquaresRight L38.en :
  L38Ref.evenSquares L38.en ≠ L38Ref.evenSquaresRight L38.en

#level_report
