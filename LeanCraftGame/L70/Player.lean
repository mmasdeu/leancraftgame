/-
# Connectedness

A space is **connected** when it cannot be split into two disjoint nonempty
open sets. Equivalently, its only **clopen** (closed and open) subsets are
`∅` and the whole space: a split `X = U ∪ V` makes `U` clopen, and a clopen
`U` splits `X` into `U` and its complement.

`ℝ` and the intervals are connected (this is the intermediate value
theorem in disguise); `ℚ` is not, nor is `ℝ ∖ {0}`.

Connectedness is not about the number of points. Sierpiński space has two
points and is connected: its only open set containing `0` is the whole
space, so no open set separates `0` from `1`. The discrete space on two
points is not connected.

The continuous image of a connected space is connected. This is why the
intermediate value theorem holds, and why a continuous map from a connected
space to a discrete one is constant.

## Your task

1. Define `IsClopen T U`: `U` is open and its complement is open.
2. Define `IsConnected T`: the only clopen sets are `∅` and the whole space.
3. Construct `split`, a topology on `{0, 1, 2}` that is **not** connected and
   **not** discrete. (The referee checks that it is a topology.)
-/
import LeanCraftGame.Lib.Topology

namespace L70

-- U and its complement are both open
def IsClopen {n : Nat} (T : Family n) (U : Finset (Fin n)) : Prop := sorry

-- the only clopen sets are ∅ and the whole space
def IsConnected {n : Nat} (T : Family n) : Prop := sorry

-- a topology on {0, 1, 2}, neither connected nor discrete
def split : Family 3 := sorry

end L70
