/-
# Gaussian integers

*Noor's second object has arithmetic: the **Gaussian integers** `ℤ[i]`, the numbers
`a + bi` with `a` and `b` integers. `GaussInt` comes back in the next two worlds.*

As a structure, a Gaussian integer is its two integer parts:

```lean
structure GaussInt where
  re : ℤ
  im : ℤ
```

So `⟨3, 4⟩` is `3 + 4i`, and `z.re`, `z.im` are the parts of `z`.

## Operations

They follow the rules of complex numbers, with `i² = -1`:

* `(a + bi) + (c + di) = (a + c) + (b + d)i`
* `(a + bi)(c + di) = (ac - bd) + (ad + bc)i`
* the conjugate of `a + bi` is `a - bi`
* the norm of `a + bi` is `a² + b²`

The trap is multiplication: it isn't coordinate by coordinate. `i · i` must be `-1`, but
multiplying coordinates gives `0 · 0 + (1 · 1)i = i`.

## Sums of two squares

The norm is multiplicative: `N(zw) = N(z) N(w)`. This is Brahmagupta's identity: a product
of two sums of two squares is a sum of two squares. Take `5 = 2² + 1²` and
`13 = 3² + 2²`. Multiplying a Gaussian integer of norm 5 by one of norm 13, or by its
conjugate, writes `65` as a sum of two squares in two different ways.

## Your task

Write the structure (fields `re` then `im`), the four operations, and two Gaussian integers
of norm 5 and 13. The operations live in the namespace `GaussInt`, so you can write
`z.mul w` and `w.conj`.
-/
import Mathlib.Tactic

namespace L30

-- a Gaussian integer a + b·i: the integer fields `re` and `im`, in this order
structure GaussInt where
  -- your fields here

def GaussInt.add (z w : GaussInt) : GaussInt := sorry

-- (a + bi)(c + di) = (ac - bd) + (ad + bc)i
def GaussInt.mul (z w : GaussInt) : GaussInt := sorry

-- the conjugate a - bi
def GaussInt.conj (z : GaussInt) : GaussInt := sorry

-- the norm a² + b²
def GaussInt.norm (z : GaussInt) : ℤ := sorry

-- a Gaussian integer of norm 5, and one of norm 13
def z5 : GaussInt := sorry
def w13 : GaussInt := sorry

end L30
