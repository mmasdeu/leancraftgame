/-
# Challenge: witnesses

An existence statement is proved by exhibiting an object: a **witness**.
"Some number is a sum of two squares in two ways" is settled by `65 = 1² +
8² = 4² + 7²`. Finding the witness is the mathematics; checking it is
computation, and the referee does it for you.

Here the definitions are numbers, chosen by you. The tests state what they
must satisfy. A few things you may want to know:

* A number is a sum of two squares exactly when each prime `≡ 3 (mod 4)`
  divides it an even number of times (Fermat, Euler); and products of such
  numbers have several representations, by the identity
  `(a² + b²)(c² + d²) = (ac - bd)² + (ad + bc)²`. Try `5 · 13`.
* Primitive Pythagorean triples are `(m² - n², 2mn, m² + n²)` with
  `m > n`, coprime, not both odd (Euclid).
* The Collatz trajectories of `27, 31, 41, 47` are unusually long.

`Nat.gcd a b` is the greatest common divisor.

## Your task

Choose the witnesses. You may compute in the editor: `#eval iter 100 27`
prints a value (and is ignored by the referee).
-/

namespace L5

-- the Collatz map and its iterates (done)
def collatz (n : Nat) : Nat := if n % 2 = 0 then n / 2 else 3 * n + 1
def iter : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => iter k (collatz n)

-- two different ways to write a number as a sum of two squares: p₁² + p₂² = q₁² + q₂²,
-- with 0 < p₁ < p₂, 0 < q₁ < q₂ and p₁ < q₁
def p₁ : Nat := sorry
def p₂ : Nat := sorry
def q₁ : Nat := sorry
def q₂ : Nat := sorry

-- a start below 50 that does not reach 1 in the first 100 steps (but does within 200)
def slow : Nat := sorry

-- a primitive Pythagorean triple x² + y² = z² with gcd(x, y) = 1 and z > 20
def x : Nat := sorry
def y : Nat := sorry
def z : Nat := sorry

end L5
