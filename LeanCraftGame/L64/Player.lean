/-
# Bases

Nobody lists all the open sets of `ℝ`. One says instead: the open sets are
the unions of open intervals. The intervals form a **basis**, and the
topology is the one **generated** by it. Even the intervals with *rational*
endpoints suffice, and there are only countably many of them.

A family `B` is a basis (of the topology it generates) when

1. it covers the space: every point lies in some member of `B`;
2. it is *locally* closed under intersections: if `x ∈ U ∩ V` with
   `U, V ∈ B`, there is `W ∈ B` with `x ∈ W ⊆ U ∩ V`.

Condition 2 is weaker than closure under intersections: two open intervals
can meet in an interval, and two open discs meet in a lens, which is not a
disc, but contains a disc around each of its points. A basis need not be a
topology (the intervals do not contain `∅` or `ℝ`).

The topology **generated** by `B` consists of the sets `A` such that every
point of `A` has a member of `B` around it inside `A`: for every `x ∈ A`
there is `U ∈ B` with `x ∈ U ⊆ A`. Equivalently: the unions of members of `B`.

## Your task

1. Define `IsBasis B` (the two conditions).
2. Define `generated B`, a `Family n`: the subsets `A` of the space such that
   every point of `A` has a member of `B` around it inside `A`.
   (`Finset.univ.powerset.filter (fun A => …)` lists the subsets with a
   property.)
3. Construct `subbasic`, a family on `{0, 1, 2}` that covers the space but is
   **not** a basis.
-/
import LeanCraftGame.Lib.Topology

namespace L64

-- covers the space, and locally closed under intersections
def IsBasis {n : Nat} (B : Family n) : Prop := sorry

-- the sets A such that every point of A has a member of B around it inside A
def generated {n : Nat} (B : Family n) : Family n := sorry

-- covers {0, 1, 2}, but is not a basis
def subbasic : Family 3 := sorry

end L64
