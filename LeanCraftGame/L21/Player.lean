/-
# Irrational roots

*Three parts of the library need "`√2` is irrational", each in its own language: on ℝ, on
ℚ and on ℕ. Noor also wants the version for any prime `p`. Each must have exactly the
hypotheses that make it true.*

The classical proof: if `√2 = m / n` in lowest terms, then `m² = 2 n²`, which is
impossible. So the fact has a version on ℕ with no `√` at all. "Lowest terms" is the
`Nat.Coprime` of level 20.

## Mathlib's `Irrational`

```lean
def Irrational (x : ℝ) : Prop := x ∉ Set.range ((↑) : ℚ → ℝ)
```

`(↑) : ℚ → ℝ` is the **cast** from rationals to reals, written as a function. Its range
(level 16) is the reals that are rational. `√2` is `Real.sqrt 2`: type `\sqrt`, then `2`.

## Casts

`q : ℚ` and `√2 : ℝ` have different types, so Lean reads `q = √2` as `(q : ℝ) = √2`,
shown `↑q = √2`. There's no cast the other way. When the types aren't obvious, write the
cast yourself. For example, "no rational squares to 2" can be said on ℚ or on ℝ:

```lean
¬ ∃ q : ℚ, q ^ 2 = 2
¬ ∃ q : ℚ, (q : ℝ) ^ 2 = 2
```

## Hypotheses that matter

`a ≠ b` (typed `\ne`) means `¬ (a = b)`. Without `Nat.Coprime m n`, the ℕ version is
false: `m = n = 0` gives `0 = 0`. For a prime `p` in place of `2`, ask for `n ≠ 0`
instead of coprimality.

## Your task

1. `irr_sqrt2`: `√2` is irrational, with `Irrational`.
2. `no_rat_sqrt`: no rational number, cast to ℝ, equals `√2`.
3. `sqrt2_nat`: for all `m n : ℕ` (written `∀ m n : ℕ, …`), if `m` and `n` are coprime,
   then `m ^ 2 ≠ 2 * n ^ 2`.
4. `prime_sqrt`: the version for a prime `p`: `m ^ 2 ≠ p * n ^ 2`, with implicit
   `{m n p : ℕ}`, then the two hypotheses `n ≠ 0` and `p.Prime`, in that order.
-/
namespace L21

statement irr_sqrt2 : sorry

statement no_rat_sqrt : sorry

statement sqrt2_nat : sorry

statement prime_sqrt : sorry

end L21
