namespace L23
def middle (a b c : Nat) : Nat :=
  if a ≤ b then (if b ≤ c then b else c)
  else (if a ≤ c then a else c)
def isLeap (y : Nat) : Bool := y % 4 == 0 && y % 100 != 0
-- the other branch is wrong too: middle 3 2 1 is 1
def ma : Nat := 3
def mb : Nat := 2
def mc : Nat := 1
def year : Nat := 2400
end L23
