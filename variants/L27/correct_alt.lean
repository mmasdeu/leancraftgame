inductive BinTree where
  | empty : BinTree
  | node : BinTree → BinTree → BinTree

open BinTree

def tn : ℕ := 4
def dn : ℕ := 1
def tree : BinTree := node (node empty empty) empty
def gn : ℕ := 3
