/-
# Cluster values

A sequence with no limit can still accumulate somewhere. `a` is a
**cluster value** (accumulation point) of `u` when `u` comes back within
`ε` of `a` infinitely often, for every `ε > 0`:

> for every `ε > 0` and every `N` there is `n ≥ N` with `|u n - a| < ε`.

Compare with the limit: "eventually always close" there, "infinitely often
close" here; the same two notions as in the Sequence world, now with an `ε`.
The sequence `(-1)^n` has two cluster values, `1` and `-1`, and no limit.

Cluster values are exactly the limits of **subsequences**: `u (φ 0),
u (φ 1), …` with `φ` strictly increasing (so that the indices go to
infinity and never repeat). The Bolzano–Weierstrass theorem says that every
bounded real sequence has a convergent subsequence: compactness of `[a, b]`
in sequential form.

## Your task

Define `ClusterValue u a` and `IsSubseqLimit u φ a`.
-/
namespace L42

-- u converges to a (already done)
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε

-- however small ε > 0 and however large N, some term u n with n ≥ N
-- is within ε of a
def ClusterValue (u : ℕ → ℝ) (a : ℝ) : Prop := sorry

-- φ is strictly increasing, and the sequence u (φ 0), u (φ 1), … converges to a
def IsSubseqLimit (u : ℕ → ℝ) (φ : ℕ → ℕ) (a : ℝ) : Prop := sorry

end L42
