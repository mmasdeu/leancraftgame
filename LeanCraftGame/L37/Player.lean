/-
# Filters

*New project at the Annex: the topology library. Noor wants the home-made limits of the
Logic world replaced by Mathlib's single notion of convergence.*

## Eventually, infinitely often

Here is the `ConvergesTo` you wrote in level 12:

```lean
def ConvergesTo (s : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n - a| < ε
```

Its inner part, `∃ N, ∀ n ≥ N, P n`, says `P n` holds **eventually**. Swap the
quantifiers, `∀ N, ∃ n ≥ N, P n`, and `P n` holds infinitely often. Sam's `blink` of
level 12, `0, 1, 0, 1, …`, is `0` infinitely often, but not eventually. Mathlib says both
with filters.

## What a filter is

A **filter** `F : Filter X` is a collection of "large" subsets of `X`. It contains `univ`,
every superset of its members, and the intersection of any two members. Two you'll use:

* `atTop : Filter ℕ`: the sets that contain all `n` from some point on, `{n | N ≤ n}`;
* `𝓝 x` (type `\MCN`): the neighbourhoods of `x`, the sets that contain an open set
  around `x`.

The line `open Filter Topology` in the code lets you write `atTop`, `Tendsto` and `𝓝`
without the `Filter.` prefix.

## Filter notation

```lean
∀ᶠ n in atTop, P n      -- the set {n | P n} is in atTop: P n holds eventually
∃ᶠ n in atTop, P n      -- P n holds for arbitrarily large n: infinitely often
Tendsto f l₁ l₂         -- for every s ∈ l₂, the preimage f ⁻¹' s is in l₁
```

You can copy these symbols from the lesson. Or write `nhds x` for `𝓝 x`, and
`Filter.Eventually (fun n => P n) atTop` for `∀ᶠ n in atTop, P n` (`Filter.Frequently`
for `∃ᶠ`).

`Tendsto s atTop (𝓝 a)` is your `ConvergesTo s a` (Mathlib's `Metric.tendsto_atTop`
says so, with `dist (s n) a`, which is `|s n - a|` on `ℝ`). All the limits of analysis
are `Tendsto`:

```lean
Tendsto u atTop (𝓝 a)      -- the sequence u converges to a
Tendsto u atTop atTop      -- u tends to infinity
Tendsto f (𝓝 x) (𝓝 (f x))  -- f is continuous at x
```

## The trap: the filter `⊥`

Mathlib allows the filter `⊥`, which contains every set, even `∅`. So
`∀ᶠ x in ⊥, P x` holds for every `P`, even `False`. A statement about a filter that
doesn't rule out `⊥` can be true for a silly reason.

## Your task

Write each definition with filter notation (no explicit `∃ N`), then answer the
questions below the lesson. Question 3 is answered `true` or `false`.
-/
import Mathlib.Topology.Instances.Real.Lemmas

namespace L37

open Filter Topology

-- u n is positive for every large enough n
def EventuallyPos (u : ℕ → ℝ) : Prop := sorry

-- u n = 0 for infinitely many n
def OftenZero (u : ℕ → ℝ) : Prop := sorry

-- u converges to a
def ConvTo (u : ℕ → ℝ) (a : ℝ) : Prop := sorry

-- u tends to infinity
def ToInfinity (u : ℕ → ℝ) : Prop := sorry

-- f is continuous at x
def ContAt (f : ℝ → ℝ) (x : ℝ) : Prop := sorry

def q1 : Fin 4 := sorry
def q2 : Fin 3 := sorry
def q3 : Bool := sorry

end L37
