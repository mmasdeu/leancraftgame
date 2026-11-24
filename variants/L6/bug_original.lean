-- A colleague's code. Repair it; keep the names and the types.

-- the median (middle value) of three numbers
def median3 (a b c : Nat) : Nat :=
  if a ≤ b then (if b ≤ c then b else c)
  else (if a ≤ c then a else c)

-- the number of days in the year y of the Gregorian calendar
def daysInYear (y : Nat) : Nat :=
  if y % 4 = 0 then (if y % 100 = 0 then 365 else 366) else 365
