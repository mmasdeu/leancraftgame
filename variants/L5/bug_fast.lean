-- the Collatz map and its iterates (done)
def collatz (n : Nat) : Nat := if n % 2 = 0 then n / 2 else 3 * n + 1
def iter : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => iter k (collatz n)

-- two different ways to write a number as a sum of two squares: p₁² + p₂² = q₁² + q₂²,
-- with 0 < p₁ < p₂, 0 < q₁ < q₂ and p₁ < q₁
def p₁ : Nat := 1
def p₂ : Nat := 8
def q₁ : Nat := 4
def q₂ : Nat := 7

-- a start below 50 that does not reach 1 in the first 100 steps (but does within 200)
def slow : Nat := 32

-- a primitive Pythagorean triple x² + y² = z² with gcd(x, y) = 1 and z > 20
def x : Nat := 20
def y : Nat := 21
def z : Nat := 29
