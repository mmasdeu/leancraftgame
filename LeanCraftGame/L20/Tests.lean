/- Hidden test battery for Level 20: Divisibility and primes. -/
import LeanCraftGame.Referee
import LeanCraftGame.L20.Player

open L20

#no_sorry TwinPrime
#no_sorry PrimitiveTriple
#no_sorry lcm'
#no_sorry L20.prime_two_le
#no_sorry L20.coprime_dvd
#level_start "Divisibility and primes"

#expect_true "11 and 13 are twin primes" unfolding TwinPrime : TwinPrime 11
#expect_false "7 and 9 are twin primes" unfolding TwinPrime : TwinPrime 7
#expect_true "(3, 4, 5) is a primitive triple" unfolding PrimitiveTriple : PrimitiveTriple 3 4 5
#expect_false "(6, 8, 10) is a primitive triple" unfolding PrimitiveTriple : PrimitiveTriple 6 8 10
#expect_false "(1, 1, 1) is a primitive triple" unfolding PrimitiveTriple : PrimitiveTriple 1 1 1
#expect_true "lcm' 4 6 = 12" unfolding lcm' : lcm' 4 6 = 12
#expect_true "lcm' 3 5 = 15" unfolding lcm' : lcm' 3 5 = 15
#expect_true "lcm' 0 0 = 0" unfolding lcm' : lcm' 0 0 = 0
#expect_equiv "prime_two_le says a prime is at least 2" :
  L20.prime_two_le ↔ ∀ {p : ℕ}, p.Prime → 2 ≤ p
  using fun hp => hp.two_le
#expect_equiv "coprime_dvd says: coprime to m and dividing m n implies dividing n" :
  L20.coprime_dvd ↔ ∀ {k m n : ℕ}, Nat.Coprime k m → k ∣ m * n → k ∣ n
  using fun H1 H2 => H1.dvd_of_dvd_mul_left H2

#level_report
