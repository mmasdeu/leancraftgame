/-
# Cluster values

A sequence that does not converge can still have numbers it keeps coming back to:
`0, 1, 0, 1, …` has no limit, yet it visits `0` and `1` forever. Two notions say
this precisely.

* `u` **diverges** when it converges to *no* real number. (Careful: this is a
  statement about *all* `a`; see "What can go wrong".)
* `a` is a **cluster value** of `u` when `u` comes within `ε` of `a` *again and
  again*: for every `ε > 0` and every starting index `N`, some term `u n` with
  `n ≥ N` is within `ε` of `a`.

Compare with "Limits": a limit needs *all* late terms close to `a`; a cluster
value needs only *some* late terms close, however late you start. The quantifiers
`∀ ε > 0, ∀ N, ∃ n ≥ N, …` are in a new order.

```lean
-- the worked example: u converges to a
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε
```

## What can go wrong

* Negation. "`u` converges to no number" is `¬ ∃ a, …`, or `∀ a, ¬ …`. It is *not*
  `∃ a, ¬ …`: that only says that some `a` is not the limit, which is true of
  every sequence.
* For a cluster value, `n` must be beyond `N`, and `N` is chosen *first*. If you
  only ask for *some* `n`, the first term could do all the work; if you choose `N`
  yourself, the sequence only has to come close once.
* `ε > 0`, as always.

## Your task

`ConvergesTo` is done. Define `Diverges u` and `ClusterValue u a`.
-/
namespace L112

-- u converges to a (already done)
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε

-- u converges to no real number
def Diverges (u : ℕ → ℝ) : Prop := sorry

-- however small ε > 0 and however large N, some term u n with n ≥ N
-- is within ε of a
def ClusterValue (u : ℕ → ℝ) (a : ℝ) : Prop := sorry

end L112
