namespace L15

-- 1 * 2 * … * n (already done)
def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * factorial n

-- 0 + 1 + 2 + … + n          (sumTo 4 is 10)
def sumTo : Nat → Nat
  | 0 => 0
  | n + 1 => sumTo n + (n + 1)

-- 2 multiplied by itself n times   (pow2 3 is 8, pow2 0 is 1)
def pow2 : Nat → Nat
  | 0 => 1
  | n + 1 => 2 * pow2 n

-- the Fibonacci numbers 0, 1, 1, 2, 3, 5, 8, …: each one is the sum of the two before it
def fib : Nat → Nat
  | 0 => 0
  | 1 => 1
  | n + 2 => fib n + fib (n + 1)

end L15
