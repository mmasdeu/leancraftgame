namespace L16

-- a minus b, as an integer        (diff 3 5 is -2)
def diff (a b : ℕ) : ℤ := ((a - b : ℕ) : ℤ)

-- the distance between two integers, as a natural number   (distance 3 (-4) is 7)
def distance (a b : ℤ) : ℕ := (a - b).natAbs

-- x is negative
def IsNegative (x : ℤ) : Prop := x < 0

end L16
