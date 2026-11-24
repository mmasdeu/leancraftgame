def median3 (a b c : Nat) : Nat :=
  if a ≤ b then (if b ≤ c then b else if a ≤ c then c else a)
  else (if a ≤ c then a else if b ≤ c then c else b)

def daysInYear (y : Nat) : Nat :=
  if y % 4 = 0 then (if y % 100 = 0 then (if y % 400 = 0 then 366 else 365) else 366) else 365
