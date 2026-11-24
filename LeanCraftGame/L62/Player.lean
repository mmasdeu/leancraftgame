/-
# A gallery of spaces

A handful of small spaces will follow us through the rest of the world. Each
one is a test case that some theorem needs, or a counterexample that some
plausible theorem fails on.

* **Discrete**: every subset is open. The finest topology: every map *out of*
  a discrete space is continuous.
* **Indiscrete**: only `∅` and the whole space. The coarsest: every map *into*
  an indiscrete space is continuous.
* **Sierpiński space**: two points `0, 1`, open sets `∅, {1}, {0, 1}`. The
  smallest space that is neither discrete nor indiscrete; think of `1` as
  "observed" and `0` as "not yet observed". It is the hero of this world.
* **Particular point** at `p`: the open sets are `∅` and every set containing
  `p`. Sierpiński space is the particular-point topology at `1` on two points.

A topology `T` is **coarser** than `S` (and `S` **finer** than `T`) when
`T ⊆ S`: every `T`-open set is `S`-open.

What about the **cofinite** topology, whose open sets are `∅` and the sets with
finite complement? On a finite set every complement is finite, so it is the
discrete topology: it only becomes interesting on an infinite set such as `ℕ`,
where it is the standard example of a space that is T1 but not Hausdorff.

Useful pieces: `Finset.univ` (the whole space), `Finset.univ.powerset` (all
subsets), `F.filter (fun U => p ∈ U)` (the members of `F` that contain `p`),
`insert ∅ F` (add `∅` to `F`).

## Your task

Construct the four topologies. The referee checks the axioms itself, and then
checks that you built the right family (not just *a* topology).
-/
import LeanCraftGame.Lib.Topology

namespace L62

-- every subset of {0, …, n-1} is open
def myDiscrete (n : Nat) : Family n := sorry

-- only ∅ and the whole space are open
def myIndiscrete (n : Nat) : Family n := sorry

-- two points, and {1} is open but {0} is not
def mySierpinski : Family 2 := sorry

-- ∅, and every set that contains p
def myParticular (n : Nat) (p : Fin n) : Family n := sorry

end L62
