/-
# Functions on structures

Functions on a structure read the fields of their inputs and build a new
value with `⟨_, _⟩`:

```lean
def GaussInt.normSq (z : GaussInt) : ℤ := z.re ^ 2 + z.im ^ 2
```

Naming a function `GaussInt.normSq` puts it in the **namespace** of the
type, and unlocks **dot notation**: for `z : GaussInt`, `z.normSq` means
`GaussInt.normSq z`, and `z.mul w` means `GaussInt.mul z w`. This is how
Mathlib names everything: `Nat.Prime`, `Finset.card`, `Function.Injective`.

Multiplication in `ℤ[i]` comes from `i² = -1`:
`(a + bi)(c + di) = (ac - bd) + (ad + bc)i`. The norm is multiplicative,
`N(zw) = N(z) N(w)`, which written out is the
**Brahmagupta–Fibonacci identity**

`(a² + b²)(c² + d²) = (ac - bd)² + (ad + bc)²`.

Remember `65 = 1² + 8² = 4² + 7²` from the Foundations world? It is
`(1² + 2²)(2² + 3²)`, and the two representations come from
`(1 + 2i)(2 + 3i)` and `(1 + 2i)(2 - 3i)`.

Powers are defined by recursion on the exponent, as for numbers.

## Your task

Define `add`, `mul` and `pow` on Gaussian integers.
-/

namespace L45

-- the Gaussian integers (already done)
structure GaussInt where
  re : ℤ
  im : ℤ

def GaussInt.normSq (z : GaussInt) : ℤ := z.re ^ 2 + z.im ^ 2

-- (a + bi) + (c + di)
def GaussInt.add (z w : GaussInt) : GaussInt := sorry

-- (a + bi)(c + di) = (ac - bd) + (ad + bc)i
def GaussInt.mul (z w : GaussInt) : GaussInt := sorry

-- z multiplied by itself n times (z⁰ = 1)
def GaussInt.pow (z : GaussInt) : ℕ → GaussInt
  | 0 => sorry
  | n + 1 => sorry

end L45
