def median3 (a b c : Nat) : Nat := max (min a b) (min (max a b) c)

def daysInYear (y : Nat) : Nat :=
  if y % 4 = 0 then (if y % 100 = 0 then 365 else 366) else 365
