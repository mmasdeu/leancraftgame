inductive BinTree where
  | empty : BinTree
  | node : BinTree → BinTree → BinTree
  deriving DecidableEq

open BinTree

def size : BinTree → ℕ
  | empty => 0
  | node l r => size l + size r + 1

def height : BinTree → ℕ
  | empty => 0
  | node l r => max (height l) (height r)

def mirror : BinTree → BinTree
  | empty => empty
  | node l r => node (mirror r) (mirror l)

def sumList : List ℕ → ℕ
  | [] => 0
  | x :: xs => x + sumList xs
