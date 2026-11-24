-- the Collatz map: halve an even number, send an odd number n to 3n + 1
def collatz (n : Nat) : Nat := if n % 2 = 0 then n / 2 else 3 * n + 1

-- the distance |a - b| between two natural numbers
def gap (a b : Nat) : Nat := a - b

-- the number of real roots of x² + b·x + c (0, 1 or 2), counted without multiplicity
def rootCount (b c : Nat) : Nat :=
  if b * b > 4 * c then 2 else if b * b = 4 * c then 1 else 0
