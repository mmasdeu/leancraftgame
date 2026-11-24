def median3 (a b c : Nat) : Nat := max (min a b) (min (max a b) c)

def daysInYear (y : Nat) : Nat :=
  if y % 400 = 0 then 366 else if y % 100 = 0 then 365 else if y % 4 = 0 then 366 else 365
