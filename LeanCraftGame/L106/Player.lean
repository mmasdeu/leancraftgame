/-
# Injective and surjective

Two properties of a function `f : ℕ → ℕ`, and a third that combines them.

* `Injective f`: different inputs give different outputs. Said without
  negations: whenever `f a = f b`, then `a = b`.
* `Surjective f`: every number `y` is hit: there is some `x` with `f x = y`.
* `Bijective f`: both at once.

```lean
def NeverZero (f : ℕ → ℕ) : Prop := ∀ x, f x ≠ 0
```

Mind the direction of the arrow in injectivity (`f a = f b → a = b` is not
the same as `a = b → f a = f b`, which is true for every function), and mind
the order of the quantifiers in surjectivity.

The referee will try your definitions on functions such as `fun n => n + 1`,
`fun n => n - 1` (remember that subtraction in `ℕ` stops at 0), `fun n => n % 3`
and `fun n => 2 * n`. Press **Run tests** to see the report.

Hint: for each of the four functions above, decide *by hand* whether it is
injective and whether it is surjective before you press the button.
-/
import Mathlib.Tactic

namespace L106

def Injective (f : ℕ → ℕ) : Prop :=
  sorry

def Surjective (f : ℕ → ℕ) : Prop :=
  sorry

def Bijective (f : ℕ → ℕ) : Prop :=
  sorry

end L106
