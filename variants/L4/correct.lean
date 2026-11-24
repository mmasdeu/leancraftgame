-- the Collatz map (done)
def collatz (n : Nat) : Nat := if n % 2 = 0 then n / 2 else 3 * n + 1

-- the Collatz map applied k times to n:  iter 0 n = n,  iter 1 n = collatz n, …
def iter : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => iter k (collatz n)

-- the Fibonacci numbers 0, 1, 1, 2, 3, 5, 8, …
def fib : Nat → Nat
  | 0 => 0
  | 1 => 1
  | n + 2 => fib (n + 1) + fib n

-- the sum 1 + 3 + 5 + ⋯ + (2n - 1) of the first n odd numbers
def oddSum : Nat → Nat
  | 0 => 0
  | n + 1 => oddSum n + (2 * n + 1)
