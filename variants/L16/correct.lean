def evens : Set ℕ := {n | Even n}
def primes : Set ℕ := {n | Nat.Prime n}
def oddPrimes : Set ℕ := primes \ evens
def multiples (k : ℕ) : Set ℕ := {n | k ∣ n}
def fourOrSix : Set ℕ := ⋃ k ∈ ({4, 6} : Set ℕ), multiples k
def q1 : Fin 3 := 1
def q2 : Bool := true
