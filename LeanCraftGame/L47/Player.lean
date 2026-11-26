/-
# Spot the bug: topology

A colleague is writing a topology library. Four of their claims are wrong, and your job is
to refute them with small spaces, where the referee checks everything. The spaces are
those of the library: Sierpiński space `sierpinski` (`{1}` open, `{0}` not) and the
discrete space `discrete 2` (every set open), on the two points `Fin 2 = {0, 1}`.

## Claim 1: continuity with images

```lean
def ColleagueCont (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop :=
  ∀ U ∈ T, img f U ∈ S        -- the image of every open set is open
```

The real definition pulls open sets back: `∀ V ∈ S, pre f V ∈ T`. The two disagree in
both directions. Give a map `f₁` from `discrete 2` to `sierpinski` that is continuous but
rejected by the colleague, and a map `f₂` from `sierpinski` to `discrete 2` that the
colleague accepts but is not continuous.

## Claim 2: "a continuous bijection is a homeomorphism"

True for compact Hausdorff spaces, false in general. Give a bijection `g` from
`discrete 2` to `sierpinski` that is continuous, but whose inverse is not: some open set
of `discrete 2` has an image that is not open.

## Claim 3: "limits are unique"

True in Hausdorff spaces only. In Sierpiński space, the constant sequence at a point `p`
converges to `x` when every open set containing `x` also contains `p`. Give `p` and two
different points `x` and `y` such that the constant sequence `p` converges to both.

## Claim 4: a reading

The colleague writes continuity at a point with `Tendsto`, and the arguments in the wrong
order:

```lean
def ColleagueContAt (f : ℝ → ℝ) (x : ℝ) : Prop := Tendsto f (𝓝 (f x)) (𝓝 x)
```

Answer the question below the lesson about it.
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
