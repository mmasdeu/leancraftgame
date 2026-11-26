/-
# Inductive types

MIL 6.3 builds new types *inductively*: by listing the ways to construct an element.
Its main example is the type of binary trees:

```lean
inductive BinTree where
  | empty : BinTree
  | node : BinTree → BinTree → BinTree
```

A binary tree is either `empty`, or a `node` with a left and a right subtree. These two
**constructors** are the only ways to build a tree, so `node empty (node empty empty)`
is a tree, with two nodes.

## Structural recursion

To define a function on trees, say what it does on each constructor. In the `node`
case, the function may call itself on the subtrees `l` and `r`: they are smaller, so
the recursion stops.

```lean
def leaves : BinTree → ℕ
  | empty => 1
  | node l r => leaves l + leaves r
```

`leaves (node empty empty)` is `leaves empty + leaves empty = 2`.

Lists are an inductive type too: a list is either `[]` or `x :: xs` (an element `x` in
front of a list `xs`), and `[1, 2, 3]` is `1 :: 2 :: 3 :: []`. Functions on lists
recurse the same way.

## Counting trees

The number of trees with `n` nodes is the `n`-th **Catalan number**: 1, 1, 2, 5, 14, …
MIL proves it; the referee will check your `size` against it on small trees.

## Your task

Fill in each case. The trap is the case that is easy to forget: a node is itself a
node, and is counted as one.
-/
import Mathlib.Tactic

namespace L26

-- binary trees, as in MIL 6.3 (already done)
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
