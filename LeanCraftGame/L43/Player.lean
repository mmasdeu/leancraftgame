/-
# Filters

*A new project at the Annex: the topology library. Noor's first request is to retire the
home-made limits of the Logic world. "Every analysis library reinvents convergence," Noor
says. "Mathlib has one notion for all of them. Learn to read it."*

## Eventually, infinitely often

Here is the `ConvergesTo` you wrote in level 12:

```lean
def ConvergesTo (s : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n - a| < ε
```

Its inner part has a shape you will meet everywhere: `∃ N, ∀ n ≥ N, P n`, "`P n` holds
**eventually**". Swap the quantifiers and you get `∀ N, ∃ n ≥ N, P n`, "`P n` holds
**infinitely often**": the alternating sequence `0, 1, 0, 1, …` of level 13 is `0`
infinitely often, but not eventually. Mathlib says both with **filters**.

## What a filter is

A filter `F : Filter X` is a collection of subsets of `X`, thought of as the "large"
sets: it contains `univ`, it contains every superset of its members, and it is closed
under intersection. The important ones:

* `atTop : Filter ℕ`: the sets that contain all `n` from some point on, `{n | N ≤ n}`;
* `𝓝 x` (type `\MCN`, after `open Topology`): the neighbourhoods of `x`, the sets that
  contain an open set around `x`;
* `Filter.principal s` (`𝓟 s`): the supersets of `s`.

## Filter notation

```lean
∀ᶠ n in atTop, P n      -- the set {n | P n} is in atTop: P n holds eventually
∃ᶠ n in atTop, P n      -- P n holds for arbitrarily large n: infinitely often
Tendsto f l₁ l₂         -- for every s ∈ l₂, the preimage f ⁻¹' s is in l₁
```

`Filter.eventually_atTop` says that `∀ᶠ n in atTop, P n ↔ ∃ N, ∀ n ≥ N, P n`, and
`Metric.tendsto_atTop` that `Tendsto s atTop (𝓝 a)` is your `ConvergesTo s a`, with the
distance `dist (s n) a` in place of `|s n - a|`. With `Tendsto`, all the limits of
analysis are one notion:

```lean
Tendsto u atTop (𝓝 a)      -- the sequence u converges to a
Tendsto u atTop atTop      -- u tends to infinity
Tendsto f (𝓝 x) (𝓝 (f x))  -- f is continuous at x
```

Read the arguments in order: the **function**, the filter on its **inputs** (where the
variable goes), the filter on its **outputs** (where the values go).

## The trap: the filter `⊥`

Mathlib allows the filter `⊥ = 𝓟 ∅`, which contains every set, even `∅`. Then
`∀ᶠ x in ⊥, P x` holds for every `P`, even `False`, and `Tendsto f ⊥ l` holds for every `f`
and `l`. Hand the Prover a limit along `⊥` and it proves it at once, whatever the sequence.
Theorems that need a "real" filter carry the hypothesis `[NeBot l]`.

## Your task

Write each definition with filter notation (no explicit `∃ N`), then answer the
questions below the lesson.
-/
import Mathlib.Topology.Instances.Real.Lemmas

namespace L43

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

end L43
