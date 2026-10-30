-- the larger of two numbers (already done)
def biggest (a b : Nat) : Nat :=
  if a ≤ b then b else a

-- the smaller of two numbers           (smallest 3 8 is 3)
def smallest (a b : Nat) : Nat := if a ≤ b then a else b

-- the distance between two numbers, whichever is larger   (gap 10 4 is 6, gap 4 10 is 6)
def gap (a b : Nat) : Nat := a - b

-- 0 for the input 0, and 1 for any other input   (zeroOrOne 0 is 0, zeroOrOne 9 is 1)
def zeroOrOne (n : Nat) : Nat := if n = 0 then 0 else 1
