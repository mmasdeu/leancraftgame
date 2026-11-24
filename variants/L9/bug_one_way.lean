-- if 4 divides n then 2 divides n
def FourThenTwo (n : Nat) : Prop := 4 ∣ n → 2 ∣ n

-- the converse: if 2 divides n then 4 divides n
def TwoThenFour (n : Nat) : Prop := 2 ∣ n → 4 ∣ n

-- a number for which the converse fails
def breaksConverse : Nat := 6

-- "a prime is odd": if p is prime then p is odd
def PrimeThenOdd (p : Nat) : Prop := Nat.Prime p → p % 2 = 1

-- the only number that breaks it
def breaksPrimeOdd : Nat := 2

-- a and b have the same parity: a is even if and only if b is even
def SameParity (a b : Nat) : Prop := a % 2 = 0 → b % 2 = 0
