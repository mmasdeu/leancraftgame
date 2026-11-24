-- the Collatz map (from the Foundations world)
def collatz (n : Nat) : Nat := if n % 2 = 0 then n / 2 else 3 * n + 1

-- n is even (already done)
def IsEven (n : Nat) : Prop := n % 2 = 0

-- a divides b: b is a multiple of a (write it with %, not with ∣)
def Divides (a b : Nat) : Prop := b % a = 0

-- (a, b, c) is a Pythagorean triple: a² + b² = c²
def IsPythagorean (a b c : Nat) : Prop := a ^ 2 + b ^ 2 = c ^ 2

-- n is a fixed point of the Collatz map
def IsFixed (n : Nat) : Prop := collatz n = n
