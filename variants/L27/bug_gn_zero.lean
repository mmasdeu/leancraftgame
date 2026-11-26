inductive BinTree where
  | empty : BinTree
  | node : BinTree → BinTree → BinTree

open BinTree

def tn : ℕ := 1
def dn : ℕ := 6
def tree : BinTree := node empty empty
def gn : ℕ := 0
