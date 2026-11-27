/-
# Irrational roots

*Three parts of the library need "`√2` is irrational", each in its own language: on ℝ,
on ℚ and on ℕ. Noor wants all three, plus the version for any prime `p`, each with exactly
the hypotheses that make it true.*

The classical proof: if `√2 = m / n` in lowest terms, then `m² = 2 n²`, which is
impossible. Three Lean statements of it:

```lean
Irrational (√2)                                      -- Mathlib's notion, on ℝ
¬ ∃ q : ℚ, q ^ 2 = 2                                  -- no rational squares to 2
∀ m n : ℕ, Nat.Coprime m n → m ^ 2 ≠ 2 * n ^ 2        -- the version on ℕ
```

"Lowest terms" is the `Nat.Coprime` of level 20.

## Mathlib's `Irrational`

```lean
def Irrational (x : ℝ) : Prop := x ∉ Set.range ((↑) : ℚ → ℝ)
```

`(↑) : ℚ → ℝ` is the **cast** from rationals to reals. Its range (level 16) is the reals
that are rational. `√2` is `Real.sqrt 2`, typed `\sqrt`.

## Casts

`q : ℚ` and `√2 : ℝ` have different types, so Lean reads `q = √2` as `(q : ℝ) = √2`,
shown `↑q = √2`. There's no cast the other way. When the types aren't obvious, write the
cast yourself: `((q : ℝ)) ^ 2 = 2`.

## Hypotheses that matter

Without `Nat.Coprime m n`, the ℕ version is false: `m = n = 0` gives `0 = 0`. For any
prime `p`, use `n ≠ 0` instead:

```lean
example {m n p : ℕ} (nnz : n ≠ 0) (prime_p : p.Prime) : m ^ 2 ≠ p * n ^ 2
```

## Your task

State, in the forms above:

1. `irr_sqrt2`: `√2` is irrational, with `Irrational`.
2. `no_rat_sqrt`: no rational number, cast to ℝ, equals `√2`.
3. `sqrt2_nat`: the version on ℕ, with `Nat.Coprime`.
4. `prime_sqrt`: the version for a prime `p` (implicit `{m n p : ℕ}`, then the two
   hypotheses `n ≠ 0` and `p.Prime`).
-/
namespace L21

statement irr_sqrt2 : sorry

statement no_rat_sqrt : sorry

statement sqrt2_nat : sorry

statement prime_sqrt : sorry

end L21
