/-
# Separation

How well do open sets tell points apart? For two distinct points `x ≠ y`:

* **T0** (Kolmogorov): some open set contains one of them and not the other.
* **T1** (Fréchet): there is an open set containing `x` and not `y` (for
  every ordered pair, so also one containing `y` and not `x`). Equivalently,
  points are closed.
* **T2** (Hausdorff): there are *disjoint* open sets `U ∋ x` and `V ∋ y`.

T2 ⇒ T1 ⇒ T0, and neither arrow reverses. Sierpiński space is the standard
example of a T0 space that is not T1: `{1}` separates `1` from `0`, but no
open set contains `0` without `1`. On an infinite set, the cofinite topology
is T1 but not Hausdorff (two nonempty open sets always meet).

Hausdorff is what makes limits unique (next level), and it is what analysts
silently assume. It is also rare among finite spaces: a finite T1 space is
discrete, since every set is a finite union of points, hence closed.

The gallery is at hand: `Top.sierpinski`, `Top.discrete n`,
`Top.indiscrete n`, `Top.chain3`, `Top.particularPoint n p` and
`Top.excludedPoint n p` (open sets: the whole space and the sets missing `p`).

## Your task

1. Define `IsT0`, `IsT1` and `IsT2` for a finite space `T`.
2. Construct `kolmo`, a topology on `{0, 1, 2}` that is T0 and not T1, and is
   not the chain `∅ ⊂ {0} ⊂ {0, 1} ⊂ {0, 1, 2}`.
3. Classify (`q1 : Bool`): is there a T1 topology on `{0, 1, 2}` other than
   the discrete one? The referee checks your answer against all 256
   families on three points.
-/
import LeanCraftGame.Lib.Topology

namespace L71

-- some open set contains one of x, y and not the other
def IsT0 {n : Nat} (T : Family n) : Prop := sorry

-- for x ≠ y, some open set contains x and not y
def IsT1 {n : Nat} (T : Family n) : Prop := sorry

-- for x ≠ y, disjoint open sets around x and around y
def IsT2 {n : Nat} (T : Family n) : Prop := sorry

-- a T0, non-T1 topology on {0, 1, 2}, other than the chain
def kolmo : Family 3 := sorry

-- is there a T1 topology on {0, 1, 2} other than the discrete one?
def q1 : Bool := sorry

end L71
