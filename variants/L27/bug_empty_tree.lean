inductive BinTree where
  | empty : BinTree
  | node : BinTree → BinTree → BinTree

open BinTree

def tn : ℕ := 1
def dn : ℕ := 6
def tree : BinTree := empty
def gn : ℕ := 1
