/-
# Cluster values

A sequence that does not converge can still have numbers it keeps coming back to:
`0, 1, 0, 1, …` has no limit, yet it visits `0` and `1` forever. Two notions say
this precisely.

* `a` is a **cluster value** of `u : ℕ → ℝ` when `u` comes within `ε` of `a`
  *again and again*: for every `ε > 0` and every starting index `N`, some term
  `u n` with `n ≥ N` is within `ε` of `a`.
* `u` has a **subsequence converging to `a`**: pick indices `φ 0 < φ 1 < φ 2 < …`
  (here `φ : ℕ → ℕ` is a function that *strictly increases*), keep only the terms
  `u (φ 0), u (φ 1), u (φ 2), …`, and ask that *these* converge to `a`. For
  `0, 1, 0, 1, …` the choice `φ n = 2 * n` keeps `0, 0, 0, …`.

Compare cluster values with "Limits": a limit needs *all* late terms close to `a`;
a cluster value needs only *some* late terms close, however late you start. The
quantifiers `∀ ε > 0, ∀ N, ∃ n ≥ N, …` are in a new order. (A real theorem says
that the two notions in this level are equivalent; here you only write them.)

```lean
-- the worked example: u converges to a
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε
```

## What can go wrong

* For a cluster value, `n` must be beyond `N`, and `N` is chosen *first*. If you
  only ask for *some* `n`, the first term could do all the work; if you choose `N`
  yourself, the sequence only has to come close once.
* A subsequence must move forward: `φ` strictly increasing, `φ m < φ n` whenever
  `m < n`. Without it, `φ n = 0` "selects" the first term forever, and
  `φ n = n / 2` repeats every term twice.
* The subsequence is `fun n => u (φ n)`: it is *that* sequence which must converge
  to `a`, not `u` itself.
* `ε > 0`, as always.

## Your task

`ConvergesTo` is done. Define `ClusterValue u a`, then
`IsSubseqLimit u φ a`: "`u ∘ φ` is a subsequence of `u` converging to `a`".
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
