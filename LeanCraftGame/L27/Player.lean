/-
# Spot the bug: counting

*Sam wrote some counting code in an afternoon, to test primality: a prime has exactly two
divisors. Each definition compiles, and each is wrong. Noor asks you to **prove them
wrong**, not fix them.*

Sam's code is in the editor: `triangle`, `numDivisors`, `size` and a "Gauss's formula".
The comment above each says what it should compute. Two new bits of notation:

* `(· ∣ n)` is `fun d => d ∣ n`: the `·` stands for the missing input.
* `BinTree` is the tree type from level 26, given again.

A counterexample is an input (a number, or a tree) on which Sam's answer and the right
answer differ. The referee computes both and checks that they differ.

## The trap

A wrong definition can be right on easy inputs. Try each one on a few small inputs and
compare with the right value by hand.

## Your task

One counterexample per definition.
-/
import Mathlib.Tactic

namespace L27

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

-- Your counterexamples

-- an input on which `triangle` is wrong
def tn : ℕ := sorry

-- an input on which `numDivisors` is wrong
def dn : ℕ := sorry

-- a tree on which `size` is wrong
def tree : BinTree := sorry

-- an `n` for which Sam's "Gauss's formula" is false
def gn : ℕ := sorry

end L27
