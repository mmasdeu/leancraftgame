/-
# Divisibility and gcd

The greatest common divisor is usually defined as "the largest common
divisor". The better definition, which is the one that generalises to
polynomials, Gaussian integers and every principal ideal domain, does not
mention size:

> `d` is a gcd of `a` and `b` when `d` is a common divisor, and every
> common divisor divides `d`.

With it, `gcd(0, 0) = 0`: every number divides `0`, and `0` is the greatest
element for divisibility, although it is the least for `≤`.

Related notions, all defined by divisibility:

* `a`, `b` **coprime**: their only common divisor is `1`;
* `p` **prime**: `p ≥ 2` and its only divisors are `1` and `p`
  (with the boundary cases `0` and `1` excluded explicitly);
* `n` **squarefree**: no square `d²` with `d ≠ 1` divides `n`
  (`12 = 2² · 3` is not, `30` is).

Write the quantifiers so that the referee can check them: a divisor of a
positive `n` is at most `n`, so `∀ d, d ∣ n → …` is a finite check in
disguise.

## Your task

Define `Coprime'`, `IsGcd`, `IsPrime'` and `Squarefree'` (with a prime to
avoid clashing with Mathlib's names).
-/
namespace L31

-- d divides both a and b (already done)
def CommonDiv (d a b : ℕ) : Prop := d ∣ a ∧ d ∣ b

-- a and b have no common divisor other than 1       (Coprime' 8 15 is true)
def Coprime' (a b : ℕ) : Prop := sorry

-- d is a greatest common divisor of a and b: a common divisor that every
-- common divisor divides                            (IsGcd 12 18 6 is true)
def IsGcd (a b d : ℕ) : Prop := sorry

-- p is a prime number
def IsPrime' (p : ℕ) : Prop := sorry

-- no square d * d with d ≠ 1 divides n               (Squarefree' 6 is true)
def Squarefree' (n : ℕ) : Prop := sorry

end L31
