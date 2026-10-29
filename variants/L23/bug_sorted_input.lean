namespace L23
def middle (a b c : Nat) : Nat :=
  if a ≤ b then (if b ≤ c then b else c)
  else (if a ≤ c then a else c)
def isLeap (y : Nat) : Bool := y % 4 == 0 && y % 100 != 0
def ma : Nat := 1
def mb : Nat := 2
def mc : Nat := 3
def year : Nat := 2000
end L23
