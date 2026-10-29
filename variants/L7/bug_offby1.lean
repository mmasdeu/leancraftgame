namespace L7

-- n is at least 100 (already done)
def IsBig (n : Nat) : Prop := 100 ≤ n

-- n is even                        (IsEven 10 is true, IsEven 7 is false)
def IsEven (n : Nat) : Prop := n % 2 = 0

-- n is smaller than 10             (IsSmall 3 is true, IsSmall 10 is false)
def IsSmall (n : Nat) : Prop := n ≤ 10

-- dividing b by a leaves no remainder   (GoesInto 3 12 is true, GoesInto 5 12 is false)
def GoesInto (a b : Nat) : Prop := b % a = 0

end L7
