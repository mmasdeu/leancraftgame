/-
# Spot the bug: counting

*Sam wrote this counting code in an afternoon, to test primality: a prime has exactly two
divisors. Each definition compiles, and each is wrong. Noor asks you to **prove them
wrong**, not fix them.*

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

For each, give an input where it's wrong. The referee computes Sam's answer and the right
one and checks they differ. What does `Finset.range n` contain? `Ico 1 n`? Which nodes
does `size` count? (Would `7` have two divisors under Sam's `numDivisors`?)

## The trap

A wrong definition can be right on easy inputs. `triangle 0` is `0`, as it should be. Pick
an input where the answers really differ.

## Your task

One counterexample per definition. `BinTree` is the tree type from level 26.
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
