/-
# Spot the bug: counting

*Sam wrote the counting code below in an afternoon, and plans to test primality with it:
a prime is a number with exactly two divisors. Each definition compiles, and each one is
wrong. Noor does not ask you to fix them, but to **prove them wrong**.*

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

Give an input on which each one gives the wrong answer. The referee computes both Sam's
answer and the right one, and checks that they differ. Read each one slowly, with the
last three levels in mind: what does `Finset.range n` contain, what does `Ico 1 n`
contain, which nodes does `size` count? (With Sam's `numDivisors`, would `7` have two
divisors?)

## The trap

A wrong definition can still be right on some inputs, and the easy inputs are often
those. `triangle 0` is `0`, as it should be. A counterexample must be an input where the
two answers really differ.

## Your task

Give one counterexample for each definition. `BinTree` is the type of trees of level 26.
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

-- an `n` for which Sam's "Gauss's formula" is false
def gn : ℕ := sorry

end L27
