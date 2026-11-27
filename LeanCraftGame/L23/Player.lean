/-
# Infinitely many primes

*"The AI proved the infinitude of primes!" Lean accepts the proof. Noor's question: does
the **statement** say what the announcement claims? This level is your audit.*

Euclid's theorem, as Mathlib states it:

```lean
theorem Nat.exists_infinite_primes (n : ℕ) : ∃ p, n ≤ p ∧ Nat.Prime p
```

For every bound `n` there's a prime at least `n`. That's "infinitely many" in quantifiers.

## How to audit

1. **Read the statement out loud**, quantifier by quantifier.
2. **Check definitions at the borders**: `0`, `1`, `2`.
3. **Try toy worlds.** Swap "prime" for a made-up notion where you know the answer. If the
   statement holds with only finitely many "primes", it doesn't say "infinitely many".

The Prover's statement works for any notion `P`, which makes step 3 easy:

```lean
def IsPrime (p : ℕ) : Prop := ∀ d, d ∣ p → d = 1 ∨ d = p
def AIClaim (P : ℕ → Prop) : Prop := ∀ n, ∃ p, P p ∧ p ≠ n
theorem ai_primes : AIClaim IsPrime := …     -- Lean accepts the proof
```

Compare `IsPrime` with `Nat.Prime` (level 20) at the borders.

## Strong recursion, read only

Unlike `fac` (level 22), this recursion calls itself on `n / 10`, not `n - 1`:

```lean
def digitSum (n : ℕ) : ℕ :=
  if n < 10 then n else n % 10 + digitSum (n / 10)
termination_by n
decreasing_by omega
```

`termination_by n` names what goes down, and `decreasing_by` proves it does (`n / 10 < n`
when `n ≥ 10`). Lean only accepts recursions that stop.

## Your task

1. `Unbounded P`: an honest "infinitely many numbers satisfy `P`".
2. `smallWorld`: a toy "prime", using only numbers between 2 and 100, where the Prover's
   claim holds but there are only finitely many "primes".
3. `fakePrime`: a number the Prover's `IsPrime` accepts but `Nat.Prime` rejects.
4. State Euclid as Mathlib does (`euclid`), and its variant for primes `p` with
   `p % 4 = 3` (`euclid_mod4`: for every `n` a prime `p ≥ n` with `p % 4 = 3`), in the
   order "bound, prime, remainder".
5. Answer the two questions about `digitSum`.
-/
namespace L23

def IsPrime (p : ℕ) : Prop := ∀ d, d ∣ p → d = 1 ∨ d = p

def AIClaim (P : ℕ → Prop) : Prop := ∀ n, ∃ p, P p ∧ p ≠ n

def Unbounded (P : ℕ → Prop) : Prop := sorry

def smallWorld : ℕ → Prop := sorry

def fakePrime : ℕ := sorry

statement euclid : sorry

statement euclid_mod4 : sorry

def q1 : Fin 3 := sorry
def q2 : Bool := sorry

end L23
