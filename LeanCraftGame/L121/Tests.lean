/- Hidden test battery for Level Spot the bug: sums. -/
import LeanCraftGame.Referee
import LeanCraftGame.L121.Player

namespace L121Ref
def triangle (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, i
def triangleRight (n : ℕ) : ℕ := ∑ i ∈ Finset.Icc 1 n, i
def numDivisors (n : ℕ) : ℕ := (Finset.filter (fun d => d ∣ n) (Finset.Ico 1 n)).card
def numDivisorsRight (n : ℕ) : ℕ := (Finset.filter (fun d => d ∣ n) (Finset.Icc 1 n)).card
def primesUpTo (n : ℕ) : ℕ := (Finset.filter (fun p => Nat.Prime p) (Finset.range n)).card
def primesUpToRight (n : ℕ) : ℕ := (Finset.filter (fun p => Nat.Prime p) (Finset.range (n + 1))).card
def evenSquares (n : ℕ) : ℕ := (∑ i ∈ Finset.filter (fun i => i % 2 = 0) (Finset.range n), i) ^ 2
def evenSquaresRight (n : ℕ) : ℕ := ∑ i ∈ Finset.filter (fun i => i % 2 = 0) (Finset.range n), i ^ 2
end L121Ref

#no_sorry L121.tn
#no_sorry L121.dn
#no_sorry L121.pn
#no_sorry L121.en
#level_start "Spot the bug: sums"

#expect_true "triangle is wrong on your tn" unfolding L121Ref.triangle L121Ref.triangleRight L121.tn :
  L121Ref.triangle L121.tn ≠ L121Ref.triangleRight L121.tn
#expect_true "numDivisors is wrong on your dn" unfolding L121Ref.numDivisors L121Ref.numDivisorsRight L121.dn :
  L121Ref.numDivisors L121.dn ≠ L121Ref.numDivisorsRight L121.dn
#expect_true "primesUpTo is wrong on your pn" unfolding L121Ref.primesUpTo L121Ref.primesUpToRight L121.pn :
  L121Ref.primesUpTo L121.pn ≠ L121Ref.primesUpToRight L121.pn
#expect_true "evenSquares is wrong on your en" unfolding L121Ref.evenSquares L121Ref.evenSquaresRight L121.en :
  L121Ref.evenSquares L121.en ≠ L121Ref.evenSquaresRight L121.en

#level_report
