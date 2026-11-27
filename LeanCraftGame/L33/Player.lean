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
`Ring ℝ`, `AddCommGroup ℝ`, `Monoid ℝ`, … So a lemma for `[Ring R]` applies to ℝ. Order
is a separate branch (`LinearOrder`, `IsOrderedRing`). ℂ is a field with no such order.

## Reading a signature

`#check @add_comm` prints

```lean
@add_comm : ∀ {G : Type u_1} [inst : AddCommMagma G] (a b : G), a + b = b + a
```

* `{G : Type u_1}`: an implicit type, found from `a` and `b`.
* `[inst : AddCommMagma G]`: an **instance argument**, saying `G` has a commutative
  addition. You never pass it. Lean searches for it.
* `(a b : G)`: the explicit arguments. You write `add_comm x y`.

When the search fails, Lean says so. `#check (-3 : ℕ)` gives `failed to synthesize Neg ℕ`,
because ℕ has no negation. That means the type lacks the structure, not that you made a
typo.

## Spaces

Analysis files open with lines like

```lean
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
```

Read: `E` is a type of vectors you can add, with a norm that comes from a real inner
product `⟪x, y⟫`. `ℝⁿ` (`EuclideanSpace ℝ (Fin n)`) is one.

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
