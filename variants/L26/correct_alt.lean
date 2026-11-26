inductive BinTree where
  | empty : BinTree
  | node : BinTree → BinTree → BinTree
  deriving DecidableEq

open BinTree

def size : BinTree → ℕ
  | empty => 0
  | node l r => 1 + size l + size r

def height : BinTree → ℕ
  | empty => 0
  | node l r => if height l ≤ height r then height r + 1 else height l + 1

def mirror : BinTree → BinTree
  | empty => empty
  | node l r => node (mirror r) (mirror l)

def sumList : List ℕ → ℕ
  | [] => 0
  | x :: xs => sumList xs + x
