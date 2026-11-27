/-
# Spot the bug: topology

*Sam wrote part of the topology library over a weekend, from memory. It compiles, and four
of its claims are wrong. Before Noor merges it, refute each one on a two-point space.*

The spaces live on `Fin 2 = {0, 1}`: Sierpiński space `sierpinski` (`{1}` open, `{0}`
not) and `discrete 2` (every set open).

## Claim 1: continuity with images

```lean
def SamCont (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop :=
  ∀ U ∈ T, img f U ∈ S        -- the image of every open set is open
```

The real definition pulls open sets back: `∀ V ∈ S, pre f V ∈ T`. The two disagree both
ways. Give a continuous map `f₁` from `discrete 2` to `sierpinski` that Sam's definition
rejects, and a map `f₂` from `sierpinski` to `discrete 2` that it accepts but that isn't
continuous.

## Claim 2: "a continuous bijection is a homeomorphism"

True for compact Hausdorff spaces, false in general. Give a continuous bijection `g` from
`discrete 2` to `sierpinski` that sends some open set to a set that isn't open, so its
inverse isn't continuous.

## Claim 3: "limits are unique"

Sam carried `convergesTo_unique` over to every space, but it needs Hausdorff. In
Sierpiński space, the constant sequence at `p` converges to `x` when every open set
containing `x` also contains `p`. Give `p` and two different points `x` and `y` such that
the constant sequence `p` converges to both.

## Claim 4: a reading

Sam writes continuity at a point with `Tendsto`, arguments in the wrong order:

```lean
def SamContAt (f : ℝ → ℝ) (x : ℝ) : Prop := Tendsto f (𝓝 (f x)) (𝓝 x)
```

Answer the question about it below the lesson.
-/
import LeanCraftGame.Lib.Topology

namespace L47

open Top

def f₁ : Fin 2 → Fin 2 := sorry
def f₂ : Fin 2 → Fin 2 := sorry

def g : Fin 2 → Fin 2 := sorry

def p : Fin 2 := sorry
def x : Fin 2 := sorry
def y : Fin 2 := sorry

def q1 : Bool := sorry

end L47
