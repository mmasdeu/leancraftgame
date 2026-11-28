/-
# Divisibility and primes

*A new project. The Prover says it proved there are infinitely many primes, and you'll
audit that claim in level 23. First the team needs divisibility, stated exactly, junk
values included.*

```lean
a ∣ b            -- a divides b (type \|, it is not the bar |): ∃ c, b = a * c
Nat.gcd a b      -- the greatest common divisor; Nat.gcd 12 8 = 4
Nat.Coprime a b  -- Nat.gcd a b = 1
Nat.Prime p      -- p is prime; also written p.Prime
```

You met `∣` in level 15. Since `p : ℕ`, `p.Prime` means `Nat.Prime p`: Lean looks up
`Prime` in the namespace `Nat` of `p`'s type. This *dot notation* is all over Mathlib, and
works on any expression in brackets: `(n * n).Prime`.

Two Mathlib facts:

```lean
theorem Nat.Prime.two_le {p : ℕ} (hp : p.Prime) : 2 ≤ p
theorem Nat.Coprime.dvd_of_dvd_mul_left {k m n : ℕ} (H1 : Nat.Coprime k m) (H2 : k ∣ m * n) : k ∣ n
```

The second says: if `k` is coprime to `m` and divides `m * n`, it divides `n`. The
coprimality is needed: `4 ∣ 2 * 2` but `4 ∤ 2`.

## Junk values

On ℕ, `a / 0 = 0` (level 7) and `Nat.gcd 0 0 = 0`. So `a * b / Nat.gcd a b` has *some*
value at `a = b = 0`, not an error. Work it out before you run.

## Your task

1. `TwinPrime p`: `p` and `p + 2` are both prime.
2. `PrimitiveTriple a b c`: `(a, b, c)` is a primitive Pythagorean triple: `a² + b² = c²`,
   and `a` and `b` are coprime.
3. `lcm' a b`: the least common multiple, by the formula `a b / gcd(a, b)`.
4. `prime_two_le`: state `Nat.Prime.two_le`: if `p : ℕ` is prime then `2 ≤ p`.
5. `coprime_dvd`: state `Nat.Coprime.dvd_of_dvd_mul_left` (variables `k m n`, hypotheses
   in that order).

For 4 and 5, use the binders of the Mathlib lines: implicit variables in `{ }`, named
hypotheses in `( )`.
-/
namespace L20

def TwinPrime (p : ℕ) : Prop := sorry

def PrimitiveTriple (a b c : ℕ) : Prop := sorry

def lcm' (a b : ℕ) : ℕ := sorry

statement prime_two_le : sorry

statement coprime_dvd : sorry

end L20
