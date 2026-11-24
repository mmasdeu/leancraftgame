-- n³
def cube (n : Nat) : Nat := n ^ 3

-- the n-th triangular number 0 + 1 + ⋯ + n, by Gauss's formula n(n + 1)/2
def triangular (n : Nat) : Nat := n / 2 * (n + 1)

-- the number of handshakes among n people, if each pair shakes hands once
def handshakes (n : Nat) : Nat := n * (n - 1) / 2
