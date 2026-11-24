/-
# Homeomorphisms

When are two spaces "the same"? Not when there is a bijection between them:
any two sets with the same number of points are in bijection. Not even when
there is a *continuous* bijection: the identity of `{0, 1}` is a continuous
bijection from the discrete topology to Sierpiński space, and the two are
different spaces (one has four open sets, the other three).

> A **homeomorphism** `f : X → Y` is a bijection such that `f` and its inverse
> `g` are both continuous.

Equivalently, `f` is a bijection and `U ↦ f(U)` is a bijection between the
open sets of `X` and those of `Y`. Every topological notion (closed, dense,
connected, T1, …) is invariant under homeomorphism; that is what "topological
notion" means.

On finite spaces the inverse can be given explicitly: `f` and `g` are inverse
when `g (f x) = x` for every `x` and `f (g y) = y` for every `y`. You may
quantify over all maps `g : Fin n → Fin m` inside a definition: there are
finitely many, and the referee enumerates them.

`IsContinuous` from the previous level is given.

## Your task

1. Define `IsHomeo T S f`: some `g` is a two-sided inverse of `f`, and `f`, `g`
   are both continuous.
2. Construct `mirror`, a homeomorphism from Sierpiński space
   `{∅, {1}, {0, 1}}` to its mirror image `{∅, {0}, {0, 1}}`.
3. Classify: answer each question with `true` or `false`.
-/
import LeanCraftGame.Lib.Topology

namespace L66

def pre {m n : Nat} (f : Fin m → Fin n) (V : Finset (Fin n)) : Finset (Fin m) :=
  Finset.univ.filter (fun x => f x ∈ V)

def IsContinuous {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop :=
  ∀ V ∈ S, pre f V ∈ T

-- f has a two-sided inverse g, and f and g are both continuous
def IsHomeo {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop := sorry

-- a homeomorphism from {∅, {1}, {0, 1}} to {∅, {0}, {0, 1}}
def mirror : Fin 2 → Fin 2 := sorry

-- Is Sierpiński space homeomorphic to the discrete space on two points?
def q1 : Bool := sorry
-- Is the particular-point topology at 0 on 3 points homeomorphic to the one at 2?
def q2 : Bool := sorry
-- Is the chain {∅, {0}, {0, 1}, {0, 1, 2}} homeomorphic to the particular-point topology at 0?
def q3 : Bool := sorry

end L66
