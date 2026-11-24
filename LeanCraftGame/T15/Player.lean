/-

# Neighbourhoods, filters and convergence

A **neighbourhood** of `x` is a set containing an open set containing `x`; the
neighbourhood set need not itself be open. A sequence `u : ℕ → α` converges to
`x` when every neighbourhood of `x` contains the sequence **eventually**.

Mathlib packages all neighbourhoods of `x` as the filter `𝓝 x` and writes
`Filter.Tendsto u Filter.atTop (𝓝 x)`. A `Filter` here may be the improper
bottom filter; do not silently identify it with a pedagogical *proper* filter.

In a discrete space convergence implies eventual equality to the limit. In
Sierpiński space the constant-`true` sequence converges both to `true` and to
`false`: the only open set containing `false` is `univ`. Hausdorffness prevents
such non-uniqueness; `tendsto_nhds_unique` is the Mathlib theorem.

**ACT III — TOPOLOGY**

The earlier acts gave you the vocabulary needed here: functions and quantifiers from
**sequences**, inverse images and local approximation from **limits**, and packaged
axioms from **structures**. This level turns those tools toward general spaces.

## The road from here

The coda returns to mathematical auditing: test whether a purported theorem and its definitions deserve confidence.


## Your tasks

Define `IsNeighbourhood`, `MyConverges`, `MathlibConverges`, `NeighbourhoodFilter`,
and set `dualLimitSequence` to be constantly `true`.
-/
namespace T15

open LeanCraftGame.Topology

def IsNeighbourhood {α : Type*} (τ : MyTopology α) (x : α) (s : Set α) : Prop := sorry

def MyConverges {α : Type*} (τ : MyTopology α) (u : ℕ → α) (x : α) : Prop := sorry

def MathlibConverges {α : Type*} [TopologicalSpace α] (u : ℕ → α) (x : α) : Prop := sorry

def NeighbourhoodFilter {α : Type*} [TopologicalSpace α] (x : α) : Filter α := sorry

def dualLimitSequence : ℕ → Bool := sorry

end T15
