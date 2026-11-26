/-
# Spot the bug: counting

A colleague wrote the code below for a counting project. Each definition compiles, and
each one is wrong. Your job is not to fix them but to **prove them wrong**: give an
input on which each one gives the wrong answer. The referee computes both the
colleague's answer and the right one, and checks that they differ.

```lean
-- 1 + 2 + ⋯ + n
def triangle (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, i

-- the number of positive divisors of n
def numDivisors (n : ℕ) : ℕ := ((Finset.Ico 1 n).filter (· ∣ n)).card

-- the number of nodes of a binary tree
def size : BinTree → ℕ
  | empty => 0
  | node l r => size l + size r

-- "Gauss's formula": for all n, ∑ i ∈ Finset.range n, i = n * (n + 1) / 2
```

Read each one slowly: what does `Finset.range n` contain, what does `Ico 1 n`
contain, which nodes does `size` count?

## The trap

A wrong definition can still be right on some inputs, and the easy inputs are often
those. `triangle 0` is `0`, as it should be. A counterexample must be an input where the
two answers really differ.

## Your task

Give one counterexample for each definition. `BinTree` is the type of MIL 6.3, as in
the previous level.
-/
import Mathlib.Tactic

namespace L27

inductive BinTree where
  | empty : BinTree
  | node : BinTree → BinTree → BinTree

open BinTree

-- an input on which `triangle` is wrong
def tn : ℕ := sorry

-- an input on which `numDivisors` is wrong
def dn : ℕ := sorry

-- a tree on which `size` is wrong
def tree : BinTree := sorry

-- an `n` for which the colleague's "Gauss's formula" is false
def gn : ℕ := sorry

end L27
