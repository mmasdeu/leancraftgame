/-
# Using Mathlib

Mathlib, Lean's mathematical library, already defines thousands of notions.
Real definitions are built from them rather than from scratch:

* `Even n`, `Odd n`;
* `Nat.Prime p`: `p` is a prime number;
* `a ∣ b`: `a` divides `b`. The bar is **not** the keyboard `|`: type `\|` or
  `\mid`. (The keyboard `|` is for absolute values and set-builder notation.)
  Read it left to right: `3 ∣ 12` is true.
* `Function.Injective f`: `f a = f b` only when `a = b`;
  `Function.Surjective f`: every value is reached;
* `Monotone u`, `StrictMono u`.

## Names and namespaces

Names are grouped in *namespaces*: `Nat.Prime` is about natural numbers,
`Function.Injective` about functions. **Dot notation** saves typing: if
`p : ℕ`, then `p.Prime` means `Nat.Prime p`; if `f` is a function,
`f.Injective` means `Function.Injective f`.

Beware of near-misses. `Prime p` (without `Nat.`) is a different, more general
notion, about prime elements of any ring. For natural numbers it happens to
agree with `Nat.Prime`, but the automation treats it differently.

Mathlib's definitions may be stated differently from yours: `Even n` is
`∃ r, n = r + r`, not `n % 2 = 0`. They mean the same thing.

```lean
def BigEven (n : ℕ) : Prop := Even n ∧ 4 ≤ n
```

## Your task

`BigEven` is done. Define `TwinPrime`, `CommonDivisor` and `OneToOne` using
Mathlib's notions.
-/
namespace L20

-- n is even and at least 4 (already done)
def BigEven (n : ℕ) : Prop := Even n ∧ 4 ≤ n

-- p and p + 2 are both prime          (TwinPrime 5 is true: 5 and 7)
def TwinPrime (p : ℕ) : Prop := sorry

-- d divides both a and b              (CommonDivisor 3 6 9 is true)
def CommonDivisor (d a b : ℕ) : Prop := sorry

-- f never takes the same value twice (use Mathlib's name for this)
def OneToOne (f : ℕ → ℕ) : Prop := sorry

end L20
