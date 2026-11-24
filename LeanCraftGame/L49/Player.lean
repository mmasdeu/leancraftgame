/-
# Axioms in a structure

A field of a structure can be a **proof**: a structure can carry, beside its
data, the axioms the data must satisfy.

```lean
structure Interval where
  lo : ℕ
  hi : ℕ
  le : lo ≤ hi
```

A value of `Interval` is then a pair of numbers *together with* a proof
that the first is at most the second; `⟨5, 2, _⟩` cannot be built, because
no proof of `5 ≤ 2` exists. This is how Mathlib defines `ℚ` (numerator,
positive denominator, coprimality), the units of a monoid, and every
algebraic structure: the axioms are fields.

You never write the proofs: the referee checks, for each example, whether
the axioms hold (*a model*) or some axiom fails (*ruled out*). Your job is
to choose axioms that accept exactly the intended objects: an axiom too
weak lets junk in, an axiom too strong excludes the examples that matter
(such as the one-point interval `[5, 5]`).

## Your task

Add the axiom to `Interval` (`lo ≤ hi`) and to `PosNat` (`val` is positive).
Keep the data fields in the order they are listed.
-/
namespace L49

-- two numbers `lo` and `hi`, in this order, with an axiom `lo ≤ hi`
structure Interval where
  lo : Nat
  hi : Nat
  -- your axiom here

-- a number `val` with an axiom saying that it is positive
structure PosNat where
  val : Nat
  -- your axiom here

end L49
