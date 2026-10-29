namespace L24
def IsTeen (n : Nat) : Prop := 13 ≤ n ∨ n ≤ 19
def IsWeekend (d : Nat) : Prop := d = 6 ∧ d = 7
def BothOdd (a b : Nat) : Prop := ¬ a % 2 = 0 ∧ b % 2 = 0
def teen : Nat := 5
def weekendDay : Nat := 3
def oddA : Nat := 1
def oddB : Nat := 2
end L24
