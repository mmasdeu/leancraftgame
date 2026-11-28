/-
# Rings, ideals, polynomials

*From groups to rings, and back to divisibility. In ℤ, an ideal is divisibility in
disguise. Sam's notes call `Ideal.span {4, 6}` "the multiples of 4 and of 6", and Noor
circles it in red.*

The vocabulary:

* `[CommRing R]`: a commutative ring, such as ℤ, ℚ, ℝ, `ZMod n` or a polynomial ring.
* `I : Ideal R`: an ideal of `R`, a subset closed under `+` and under multiplication by
  any element of `R`. `Ideal.span {a, b}` is the ideal **generated** by `a`
  and `b`: all `r * a + s * b`. In ℤ, `x ∈ Ideal.span {a} ↔ a ∣ x`, with the `∣` of
  level 20, and every ideal is `Ideal.span {a}` for one number `a`.
* `ZMod n`: the integers modulo `n`, a commutative ring. For prime `p`, `ZMod p` is a field: every nonzero element has an inverse. A numeral in
  `ZMod 7` is a residue mod 7, and `#eval (3 : ZMod 7) * 4` prints `5`.
* `R ≃+* S`: a ring isomorphism, a bijection that preserves `+` and `*`.
* `Polynomial R`, written `R[X]` after `open Polynomial`. `X` is the variable and `C a` the
  constant `a`. Numerals work directly, so `X ^ 2 - 3 * X + C 7` equals
  `X ^ 2 - 3 * X + 7`. `p.eval a` evaluates `p` at `a`, and `p.natDegree` is its degree.

## The Chinese remainder theorem

For integers: if `m` and `n` are coprime, then `ZMod (m * n)` is isomorphic, as a ring, to
`ZMod m × ZMod n`. An isomorphism is data, so the statement says one exists:
`Nonempty (ZMod (m * n) ≃+* ZMod m × ZMod n)`.

## Your task

1. `I`: the ideal of the integers divisible by both 4 and 6, as `Ideal.span {…}`.
2. `p`: the monic polynomial of degree 2 over ℤ whose roots are 2 and 3.
3. `inv3`: the inverse of 3 in `ZMod 7`, written as a number from 0 to 6.
4. `crt`: for all natural numbers `m` and `n`, if `Nat.Coprime m n`, then
   `Nonempty (ZMod (m * n) ≃+* ZMod m × ZMod n)`. Write `m` and `n` as explicit binders,
   then the hypothesis.
-/
import Mathlib.RingTheory.Ideal.Span
import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib.Data.ZMod.QuotientRing

namespace L37

open Polynomial

-- the integers divisible by both 4 and 6
def I : Ideal ℤ := sorry

-- the monic polynomial of degree 2 with roots 2 and 3
def p : ℤ[X] := sorry

-- the inverse of 3 in ZMod 7
def inv3 : ZMod 7 := sorry

statement crt : sorry

end L37
