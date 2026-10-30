-- under 5 or at least 65          (FreeTicket 3 is true, FreeTicket 30 is false)
def FreeTicket (age : Nat) : Prop := age < 5 ∧ 65 ≤ age

-- everybody else pays full price: the opposite of FreeTicket
def PaysFull (age : Nat) : Prop := ¬ FreeTicket age

-- n is neither 0 nor 1            (NotTiny 5 is true, NotTiny 1 is false)
def NotTiny (n : Nat) : Prop := ¬ (n = 0 ∨ n = 1)
