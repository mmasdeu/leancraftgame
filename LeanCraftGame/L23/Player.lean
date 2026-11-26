/-
# Infinitely many primes

MIL §5.3 proves Euclid's theorem, in the form Mathlib states it:

```lean
theorem Nat.exists_infinite_primes (n : ℕ) : ∃ p, n ≤ p ∧ Nat.Prime p
```

"For every bound `n` there is a prime at least `n`": that is how "infinitely many" is
said with quantifiers. This level is an **audit**: an AI also claims to have proved
Euclid's theorem, and Lean accepts its proof. Your job is to decide whether its
*statement* says what it claims.

## How to audit a formalisation

1. **Say the formal statement out loud**, quantifier by quantifier.
2. **Check every definition on its borders**: `0`, `1`, `2`.
3. **Test in toy worlds.** Replace the notion ("prime") by a made-up one where you know
   the answer. A statement that holds in a world where there are *not* infinitely many
   "primes" does not say "infinitely many".

The AI's statement is written for any notion of "prime" `P`, which makes step 3 easy:

```lean
def IsPrime (p : ℕ) : Prop := ∀ d, d ∣ p → d = 1 ∨ d = p
def AIClaim (P : ℕ → Prop) : Prop := ∀ n, ∃ p, P p ∧ p ≠ n
theorem ai_primes : AIClaim IsPrime := …     -- Lean accepts the proof
```

## Strong recursion (MIL §5.4), read only

Not every recursion is on `n` and `n + 1`. This one calls itself on `n / 10`:

```lean
def digitSum (n : ℕ) : ℕ :=
  if n < 10 then n else n % 10 + digitSum (n / 10)
termination_by n
decreasing_by omega
```

`termination_by n` names the quantity that decreases, and `decreasing_by` proves that it
does (here `n / 10 < n` when `n ≥ 10`): Lean only accepts a recursion that stops.

## Your task

1. `Unbounded P`: the faithful "there are infinitely many numbers satisfying `P`".
2. `smallWorld`: a toy notion of "prime", with only numbers between 2 and 100, in which
   the AI's claim holds but there are not infinitely many "primes".
3. `fakePrime`: a number that the AI's `IsPrime` accepts but `Nat.Prime` rejects.
4. State Euclid as Mathlib does (`euclid`), and its variant for the primes `p` with
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
