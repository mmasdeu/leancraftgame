/-
# Irrational roots

MIL §5.1 proves that `√2` is irrational, and it does so with natural numbers: if
`√2 = m / n` in lowest terms, then `m² = 2 n²`, which is impossible. One fact, three
statements, each with its own Lean:

```lean
Irrational (√2)                                      -- Mathlib's notion, on ℝ
¬ ∃ q : ℚ, q ^ 2 = 2                                  -- no rational squares to 2
∀ m n : ℕ, Nat.Coprime m n → m ^ 2 ≠ 2 * n ^ 2        -- MIL's version, on ℕ
```

## Reading Mathlib's `Irrational`

```lean
def Irrational (x : ℝ) : Prop := x ∉ Set.range ((↑) : ℚ → ℝ)
```

`(↑) : ℚ → ℝ` is the **cast** (the coercion) from rationals to reals, and its range is the
set of reals that are rationals. `√2` is `Real.sqrt 2`, typed `\sqrt`.

## Casts

`q : ℚ` and `√2 : ℝ` have different types, so `q = √2` cannot be an equation in `ℚ`.
Lean inserts the cast for you and reads it as `(q : ℝ) = √2`, written `↑q = √2`. In the
other direction there is no cast: `√2` is not a rational. When the types are not obvious,
write the cast yourself: `((q : ℝ)) ^ 2 = 2`.

## Hypotheses that matter

Without `Nat.Coprime m n`, the statement on ℕ is false: `m = n = 0` gives `0 = 0`. MIL's
generalisation to any prime `p` needs `n ≠ 0` instead:

```lean
example {m n p : ℕ} (nnz : n ≠ 0) (prime_p : p.Prime) : m ^ 2 ≠ p * n ^ 2
```

## Your task

State, in the forms above:

1. `irr_sqrt2`: `√2` is irrational, with `Irrational`.
2. `no_rat_sqrt`: no rational number, cast to ℝ, equals `√2`.
3. `sqrt2_nat`: MIL's version on ℕ, with `Nat.Coprime`.
4. `prime_sqrt`: MIL's generalisation to a prime `p` (implicit `{m n p : ℕ}`, then the
   two hypotheses `n ≠ 0` and `p.Prime`).
-/
namespace L21

statement irr_sqrt2 : sorry

statement no_rat_sqrt : sorry

statement sqrt2_nat : sorry

statement prime_sqrt : sorry

end L21
