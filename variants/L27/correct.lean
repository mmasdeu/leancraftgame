inductive BinTree where
  | empty : BinTree
  | node : BinTree → BinTree → BinTree

open BinTree

-- Sam's code (given, don't edit; the referee uses its own copy)

-- 1 + 2 + ⋯ + n
def triangle (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, i

-- the number of positive divisors of n
def numDivisors (n : ℕ) : ℕ := ((Finset.Ico 1 n).filter (· ∣ n)).card

-- the number of nodes of a binary tree
def size : BinTree → ℕ
  | empty => 0
  | node l r => size l + size r

-- "Gauss's formula"
statement samGauss (n : ℕ) : ∑ i ∈ Finset.range n, i = n * (n + 1) / 2

def tn : ℕ := 1
def dn : ℕ := 6
def tree : BinTree := node empty empty
def gn : ℕ := 1
