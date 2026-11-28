/-
# Reading the hierarchy

*Sam is puzzled. `ring` works in `ℤ` and in `ℝ`, yet a lemma about fields refuses `ℤ`.
Noor: a lemma applies to a type exactly when Lean finds the classes it asks for.*

Mathlib's hierarchy has hundreds of classes. A lemma states its assumptions as classes,
and you need to know whether your type has them.

## Classes extend classes

Mathlib declares, roughly:

```lean
class Ring (R : Type*) extends Semiring R, AddCommGroup R, …
class CommRing (R : Type*) extends Ring R, CommMonoid R
class DivisionRing (K : Type*) extends Ring K, DivInvMonoid K, …
class Field (K : Type*) extends CommRing K, DivisionRing K, …
```

Each `extends` gives an automatic instance. From `Field ℝ`, Lean finds `CommRing ℝ`,
`Ring ℝ`, `AddCommGroup ℝ`, `Monoid ℝ`, … So a lemma for `[Ring R]` applies to ℝ. A class
that is not on such a chain must be found some other way, or not at all.

## Reading a signature

`#check @neg_neg` prints

```lean
@neg_neg : ∀ {G : Type u_1} [inst : InvolutiveNeg G] (a : G), - -a = a
```

* `{G : Type u_1}`: an implicit type, found from `a`.
* `[inst : InvolutiveNeg G]`: an **instance argument**, saying `G` has a negation with
  `- -a = a`. You never pass it. Lean searches for it.
* `(a : G)`: the explicit argument. You write `neg_neg x`.

When the search fails, Lean says so. `#check (2 : ℕ)⁻¹` fails with
`failed to synthesize … Inv ℕ`, because ℕ has no inverse operation. That means the type lacks the structure, not that you made a
typo.

## Spaces

Analysis files open with lines like

```lean
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
```

Read: `E` is a type of vectors you can add, with a norm that comes from a real inner
product `⟪x, y⟫`. `ℝⁿ` (`EuclideanSpace ℝ (Fin n)`, vectors of `n` real numbers) is one.

## Your task

Answer the questions below the lesson. You can test guesses in the editor with `#check`,
or with `example : Field ℚ := inferInstance` (it compiles when Lean finds the instance).
-/
import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Data.Matrix.Mul

namespace L33

def q1 : Fin 4 := sorry
def q2 : Fin 4 := sorry
def q3 : Bool := sorry
def q4 : Fin 3 := sorry
def q5 : Bool := sorry
def q6 : Fin 4 := sorry
def q7 : Bool := sorry

end L33
