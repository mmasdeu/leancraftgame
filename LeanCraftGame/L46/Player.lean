/-
# Separation and compactness

*In level 12 you stated `convergesTo_unique`: a sequence of reals has at most one limit.
Does that survive in the gallery? Noor asks for the properties that decide it, and for
compactness, which replaces "closed and bounded".*

## Separation

How well do open sets tell points apart? Mathlib has a class for each answer:

```lean
class T0Space (X : Type u) [TopologicalSpace X] : Prop   -- some open set contains one point and not the other
class T1Space (X : Type u) [TopologicalSpace X] : Prop   -- for x ≠ y, an open set contains x and not y
class T2Space (X : Type u) [TopologicalSpace X] : Prop   -- for x ≠ y, disjoint open sets around x and around y
```

`T2Space` is the **Hausdorff** property, which makes limits unique. Each property implies
the one before. Sierpiński space (`{1}` open, `{0}` not) is T0 but not T1: the only open
set containing `0` is the whole space, which also contains `1`.

On a finite space, T1 is very strong. For Question 1, think of the complement `{x}ᶜ` of a
point, and of the finitely many open sets that avoid `x`.

## Compactness

Mathlib defines `IsCompact s` with filters. `isCompact_iff_finite_subcover` shows it's the
usual definition: every cover of `s` by open sets has a finite subcover. In discrete `ℕ`
every set is open, so `ℕ` is compact only if *every* cover has a finite subcover. A cover
is a family `U : ℕ → Set ℕ` with `∀ x, ∃ i, x ∈ U i`. It has a finite subcover if
`U 0, …, U N` already cover `ℕ` for some `N`.

## Your task

1. Define T1 and T2 for finite spaces, as in the Topology library (`Family n`, open sets
   `U ∈ T`; `x ∈ U`, `U ∩ V = ∅`).
2. Give a cover of `ℕ` with no finite subcover, so `ℕ` is not compact.
3. Answer the questions below the lesson.
-/
import LeanCraftGame.Lib.Topology

namespace L46

-- for x ≠ y, some open set contains x and not y
def IsT1 {n : Nat} (T : Family n) : Prop := sorry

-- for x ≠ y, disjoint open sets U ∋ x and V ∋ y
def IsT2 {n : Nat} (T : Family n) : Prop := sorry

-- a cover of ℕ with no finite subcover
def noSubcover : ℕ → Set ℕ := sorry

def q1 : Bool := sorry
def q2 : Fin 3 := sorry

end L46
