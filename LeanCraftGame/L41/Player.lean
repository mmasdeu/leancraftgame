/-
# Cauchy sequences

A Cauchy sequence is one whose terms get close *to each other*, with no
limit in sight:

> for every `ε > 0` there is `N` such that `|u m - u n| < ε` for all
> `m, n ≥ N`.

Every convergent sequence is Cauchy. The converse is **completeness**, and
it is what distinguishes `ℝ` from `ℚ`: the decimal truncations of `√2` are
a Cauchy sequence of rationals with no rational limit. Cantor built `ℝ`
precisely as the Cauchy sequences of rationals, up to equivalence.

Both `m` and `n` must range over all indices from `N` on. Comparing only
consecutive terms (`|u (n+1) - u n| < ε`) is not enough: the partial sums
of the harmonic series `1 + 1/2 + 1/3 + ⋯` have consecutive differences
`1/(n+1) → 0` and diverge.

A sequence that is **eventually constant** is the simplest Cauchy sequence;
and its first terms do not matter at all.

## Your task

Define `IsEventuallyConstant u` and `IsCauchy u`.
-/
namespace L41

-- u converges to a (already done)
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε

-- from some index N on, every term equals u N
def IsEventuallyConstant (u : ℕ → ℝ) : Prop := sorry

-- u is a Cauchy sequence: for every ε > 0, from some index N on,
-- any two terms are within ε of each other
def IsCauchy (u : ℕ → ℝ) : Prop := sorry

end L41
