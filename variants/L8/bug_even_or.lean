namespace L8

-- lo ≤ n ≤ hi (already done)
def InRange (lo hi n : Nat) : Prop := lo ≤ n ∧ n ≤ hi

-- n is between 13 and 19, both included      (IsTeen 19 is true, IsTeen 20 is false)
def IsTeen (n : Nat) : Prop := 13 ≤ n ∧ n ≤ 19

-- n is even and lies between lo and hi        (EvenInRange 1 10 4 is true, EvenInRange 1 10 5 is false)
def EvenInRange (lo hi n : Nat) : Prop := n % 2 = 0 ∨ InRange lo hi n

end L8
