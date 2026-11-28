def evens : Set ℕ := {n | n % 2 = 0}
def primes : Set ℕ := {p | p.Prime}
def oddPrimes : Set ℕ := primes ∩ evensᶜ
def multiples (k : ℕ) : Set ℕ := {n | n % k = 0}
def fourOrSix : Set ℕ := multiples 4 ∪ multiples 6
def q1 : Fin 3 := 1
def q2 : Bool := true
