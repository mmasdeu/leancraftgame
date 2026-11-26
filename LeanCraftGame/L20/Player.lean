/-
# Divisibility and primes

MIL's fifth chapter works with Mathlib's number theory on ℕ. The vocabulary:

```lean
a ∣ b            -- a divides b (type \|, it is not the bar |): ∃ c, b = a * c
Nat.gcd a b      -- the greatest common divisor; Nat.gcd 12 8 = 4
Nat.Coprime a b  -- Nat.gcd a b = 1
Nat.Prime p      -- p is prime; also written p.Prime
```

Because `p : ℕ`, `p.Prime` means `Nat.Prime p`: Lean looks up `Prime` in the namespace
`Nat` of the type of `p`. This *dot notation* is everywhere in Mathlib.

MIL states facts with these, such as

```lean
theorem Nat.Prime.two_le {p : ℕ} (hp : p.Prime) : 2 ≤ p
theorem Nat.Coprime.dvd_of_dvd_mul_left {k m n : ℕ} (H1 : Nat.Coprime k m) (H2 : k ∣ m * n) : k ∣ n
```

Read the second one: "if `k` is coprime to `m` and divides `m * n`, it divides `n`". The
hypothesis `Nat.Coprime k m` is essential: `4 ∣ 2 * 2` but `4 ∤ 2`.

## Junk values

Lean's `/` on ℕ is total: `a / 0 = 0`. And `Nat.gcd 0 0 = 0`. A formula such as
`a * b / Nat.gcd a b` therefore has *some* value at `a = b = 0`, and you should know it.

## Your task

1. `TwinPrime p`: `p` and `p + 2` are both prime.
2. `PrimitiveTriple a b c`: `a² + b² = c²`, and `a` and `b` are coprime.
3. `lcm' a b`: the least common multiple, by the formula `a b / gcd(a, b)`.
4. `prime_two_le`: state `Nat.Prime.two_le` as above: for every `p : ℕ`, if `p` is prime then `2 ≤ p`.
5. `coprime_dvd`: state `Nat.Coprime.dvd_of_dvd_mul_left` as above (variables `k m n`,
   hypotheses in that order).
-/
namespace L20

def TwinPrime (p : ℕ) : Prop := sorry

def PrimitiveTriple (a b c : ℕ) : Prop := sorry

def lcm' (a b : ℕ) : ℕ := sorry

statement prime_two_le : sorry

statement coprime_dvd : sorry

end L20
