
open Polynomial

structure AddSubmonoidℤ where
  carrier : Set ℤ
  zero_mem : 0 ∈ carrier
  add_mem {a b} : a ∈ carrier → b ∈ carrier → a + b ∈ carrier

structure AddSubgroupℤ where
  carrier : Set ℤ
  zero_mem : 0 ∈ carrier
  add_mem {a b} : a ∈ carrier → b ∈ carrier → a + b ∈ carrier
  neg_mem {a} : a ∈ carrier → -a ∈ carrier

-- Claim 1: an additive submonoid of ℤ that is not a subgroup
def junk : Set ℤ := {n | 0 ≤ n ∧ n % 2 = 0}

-- Claim 2: in Ideal.span {2}, but not divisible by both 4 and 6
def x : ℤ := -14

-- Claim 3: natDegree (p * q) ≠ natDegree p + natDegree q
def p : ℤ[X] := X ^ 2
def q : ℤ[X] := 0

-- Claim 4: nonzero, and not invertible in ZMod 6
def a : ZMod 6 := 3

-- Claim 5: two permutations that do not commute
def σ : Equiv.Perm (Fin 3) := Equiv.swap 0 2
def τ : Equiv.Perm (Fin 3) := Equiv.swap 0 1

