namespace L5

-- twice the input        (double 4 is 8)
def double (n : Nat) : Nat := 2 * n

-- the input times itself  (squared 5 is 25)
def squared (n : Nat) : Nat := n * n

-- ten more than the input (addTen 1 is 11)
def addTen (n : Nat) : Nat := n + 10

-- one less than the input, but 0 stays 0   (minusOne 5 is 4, minusOne 0 is 0)
def minusOne (n : Nat) : Nat := n - 1

end L5
