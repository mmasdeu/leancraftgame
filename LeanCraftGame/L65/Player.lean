/-
# Continuous maps

In analysis, `f` is continuous when `x → a` implies `f x → f a`, written
with `ε` and `δ`. The topological definition replaces distances by open sets:

> `f : X → Y` is **continuous** when the inverse image `f⁻¹(V)` of every open
> set `V` of `Y` is open in `X`.

For maps `ℝ → ℝ` the two agree, and that theorem is why the open-set
definition took over: it mentions no distance, so it makes sense in every
space of the gallery.

Inverse images, not images. Inverse images commute with unions,
intersections and complements; direct images do not. And a map that sends
open sets to open sets (an **open map**) need not be continuous, nor
conversely.

A map between finite spaces is a function `Fin m → Fin n`. You can write one
by listing its values: `![1, 1, 0] : Fin 3 → Fin 2` sends `0 ↦ 1`, `1 ↦ 1`,
`2 ↦ 0`. The image `img f A` is written for you.

Continuity depends on the topologies, not only on the map: the identity of
`{0, 1}` is continuous from the discrete topology to Sierpiński space, but
not back.

## Your task

1. Define the inverse image `pre f V` (the points of `Fin m` that `f` sends
   into `V`).
2. Define `IsContinuous T S f`.
3. Define `IsOpenMapping T S f`: the image of every `T`-open set is `S`-open.
4. Construct `sneaky`, a map from Sierpiński space to the *discrete* space on
   `{0, 1}` that is an open map but not continuous.
-/
import LeanCraftGame.Lib.Topology

namespace L65

-- the points of Fin m sent into V
def pre {m n : Nat} (f : Fin m → Fin n) (V : Finset (Fin n)) : Finset (Fin m) := sorry

-- the image of A (given)
def img {m n : Nat} (f : Fin m → Fin n) (A : Finset (Fin m)) : Finset (Fin n) :=
  Finset.univ.filter (fun y => ∃ x ∈ A, f x = y)

-- the inverse image of every S-open set is T-open
def IsContinuous {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop := sorry

-- the image of every T-open set is S-open
def IsOpenMapping {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop := sorry

-- a map from Sierpiński space to the discrete space on {0, 1}: open, not continuous
def sneaky : Fin 2 → Fin 2 := sorry

end L65
