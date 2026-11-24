/-
# Compactness

A space is **compact** when every open cover has a finite subcover: if the
open sets `Uᵢ` together contain every point, then finitely many of them
already do. Compactness is the topological form of "finite": continuous
real functions on a compact space are bounded and attain their bounds, and
`[0, 1]` is compact while `(0, 1)` and `ℝ` are not.

Every finite space is compact (a cover has finitely many distinct members),
so the gallery of finite spaces cannot show the difference. This level
leaves the finite world: the space is `ℕ`, a subset is a `Set ℕ` (written
`{x | P x}`), and a cover is a sequence of subsets `U : ℕ → Set ℕ`. For a
sequence of sets, "finitely many of them" can be taken to be `U 0, …, U N`.

Two topologies on `ℕ` behave in opposite ways.

* **Discrete** (every set open): not compact. The cover by singletons `{n}`
  has no finite subcover, since finitely many singletons miss a point.
* **Cofinite** (the open sets are `∅` and the sets with finite complement):
  compact. Take any nonempty member of a cover: it misses only finitely many
  points, and one more member for each of those finishes the job.

## Your task

1. Define `Covers U`: every natural number lies in some `U i`.
2. Define `HasFiniteSubcover U`: for some `N`, the sets `U 0, …, U N` already
   cover `ℕ`.
3. Construct `noSubcover`, a cover of `ℕ` with no finite subcover (so the
   discrete `ℕ` is not compact).
4. The sets `V i = {x | x < i ∨ 4 ≤ x}` are cofinite and cover `ℕ`. Give `N0`
   such that `V 0, …, V N0` cover `ℕ`.
-/
namespace L69

-- every natural number lies in some U i
def Covers (U : ℕ → Set ℕ) : Prop := sorry

-- for some N, the sets U 0, …, U N cover ℕ
def HasFiniteSubcover (U : ℕ → Set ℕ) : Prop := sorry

-- a cover of ℕ without a finite subcover
def noSubcover : ℕ → Set ℕ := sorry

-- V 0, …, V N0 cover ℕ, where V i = {x | x < i ∨ 4 ≤ x}
def N0 : ℕ := sorry

end L69
