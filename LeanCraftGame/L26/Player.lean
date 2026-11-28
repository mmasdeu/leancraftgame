/-
# Inductive types

*Counting reaches trees. Noor wants to check that binary trees with `n` nodes follow the
Catalan numbers, so the Annex needs trees and recursive functions on them.*

An *inductive* type lists the ways to build its elements. Binary trees:

```lean
inductive BinTree where
  | empty : BinTree
  | node : BinTree → BinTree → BinTree
```

A tree is `empty`, or a `node` with a left and a right subtree. These **constructors** are
the only ways to build one: `node empty (node empty empty)` has two nodes. ℕ is built the
same way from `0` and `n + 1`, which is why `fac` (level 22) had one line for each.

## Structural recursion

Say what the function does on each constructor. In the `node` case it may call itself on
the smaller subtrees `l` and `r`, so it stops.

```lean
def leaves : BinTree → ℕ
  | empty => 1
  | node l r => leaves l + leaves r
```

`leaves (node empty empty)` is `leaves empty + leaves empty = 2`.

Lists work the same way. A list is `[]` or `x :: xs` (`x` in front of `xs`), and
`[1, 2, 3]` is `1 :: 2 :: 3 :: []`.

## Counting trees

The number of trees with `n` nodes is the **Catalan number** `C n`, starting from
`C 0 = 1` (the empty tree). The referee lists small trees and counts those of each size,
using your `size`.

## Your task

Fill in each case. In the editor, `deriving DecidableEq` lets Lean decide whether two trees
are equal, and `open BinTree` lets you write `empty` and `node` for `BinTree.empty` and
`BinTree.node`.
-/
import Mathlib.Tactic

namespace L26

-- binary trees, as in the lesson (given)
inductive BinTree where
  | empty : BinTree
  | node : BinTree → BinTree → BinTree
  deriving DecidableEq

open BinTree

-- the number of nodes (`empty` has none)
def size : BinTree → ℕ
  | empty => sorry
  | node l r => sorry

-- the height: `empty` has height 0, and a node is one more than its higher subtree
def height : BinTree → ℕ
  | empty => sorry
  | node l r => sorry

-- the mirror image: swap left and right at every node
def mirror : BinTree → BinTree
  | empty => sorry
  | node l r => sorry

-- the sum of a list of natural numbers
def sumList : List ℕ → ℕ
  | [] => sorry
  | x :: xs => sorry

end L26
