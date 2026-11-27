/-
# Divisibility and primes

*A new project. The Prover says it has proved there are infinitely many primes, and Noor
wants the Annex to check that claim (level 23). First the team needs the vocabulary of
divisibility, stated exactly, junk values included.*

Mathlib's number theory on ℕ starts with these:

```lean
a ∣ b            -- a divides b (type \|, it is not the bar |): ∃ c, b = a * c
Nat.gcd a b      -- the greatest common divisor; Nat.gcd 12 8 = 4
Nat.Coprime a b  -- Nat.gcd a b = 1
Nat.Prime p      -- p is prime; also written p.Prime
```

You met `∣` in level 15, where the multiples of `k` were `{n | k ∣ n}`. Since `p : ℕ`,
`p.Prime` means `Nat.Prime p`: Lean looks up `Prime` in the namespace `Nat` of the type
of `p`. This *dot notation* is everywhere in Mathlib.

Mathlib states facts with these, such as

```lean
theorem Nat.Prime.two_le {p : ℕ} (hp : p.Prime) : 2 ≤ p
theorem Nat.Coprime.dvd_of_dvd_mul_left {k m n : ℕ} (H1 : Nat.Coprime k m) (H2 : k ∣ m * n) : k ∣ n
```

The second one says: if `k` is coprime to `m` and divides `m * n`, it divides `n`. You
can't drop `Nat.Coprime k m`: `4 ∣ 2 * 2` but `4 ∤ 2`.

## Junk values

Lean's `/` on ℕ is total: `a / 0 = 0` (the junk values of level 7). And `Nat.gcd 0 0 = 0`.
So a formula like `a * b / Nat.gcd a b` has *some* value at `a = b = 0`, and you should
know what it is. What should happen at zero?

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
