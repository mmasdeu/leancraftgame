/-
# Sam's groups

*Sam needed groups before the project was allowed Mathlib's, and wrote them over lunch:
associativity, an identity, inverses. The file compiles. Noor asks the auditor's
question: is every model of Sam's axioms really a group?*

Like `StandardTwoSimplex` in level 28, an algebraic structure is a structure whose fields
are the operations *and* the axioms:

```lean
structure Group₁ (α : Type*) where
  mul : α → α → α
  one : α
  inv : α → α
  mul_assoc : ∀ x y z : α, mul (mul x y) z = mul x (mul y z)
  mul_one : ∀ x : α, mul x one = x
  one_mul : ∀ x : α, mul one x = x
  inv_mul_cancel : ∀ x : α, mul (inv x) x = one
```

A model of the structure is data (`mul`, `one`, `inv`) together with proofs of the
axioms. Writing the axioms is the delicate part: too few, and junk satisfies them; too
many, and genuine groups are rejected.

Sam formalised groups with a *left* identity and a *right* inverse:

```lean
mul_assoc : ∀ a b c, mul (mul a b) c = mul a (mul b c)
one_mul   : ∀ a, mul one a = a
mul_inv   : ∀ a, mul a (inv a) = one
```

Textbooks often give one-sided axioms, and with the *same* side they are
enough: a left identity and left inverses imply a group. With mixed sides
they are not. The axioms are satisfied by structures that are not groups,
for instance some operations on a two-element set where `mul a one ≠ a`.

This is the auditor's question about any set of axioms: **does it admit
junk models?** The way to answer it is not to stare at the axioms, but to
look for a small model that satisfies them and fails a property every group
has.
-/
import Mathlib.Tactic

namespace L29

structure Group' (G : Type) where
  mul : G → G → G
  one : G
  inv : G → G
  mul_assoc : ∀ a b c, mul (mul a b) c = mul a (mul b c)
  one_mul   : ∀ a, mul one a = a
  mul_inv   : ∀ a, mul a (inv a) = one

/-
## Part A: Break it

Find a *junk model*: an operation on `Bool` (the type with the two values `true`
and `false`) that satisfies every axiom of
`Group'` but is NOT a group. Only give the data; the referee checks the
axioms for you.

Hint: is `mul a one = a` a consequence of the axioms above?
-/

def junkMul : Bool → Bool → Bool := sorry
def junkOne : Bool := sorry
def junkInv : Bool → Bool := sorry

/-
## Part B: Fix it

Write a correct definition. Keep `mul`, `one`, `inv` as the first three
fields, in this order; the axioms are up to you.

The referee checks your structure against a zoo of models: real groups
(which must satisfy all your axioms) and junk models (each of which must
violate at least one). Some of the groups are not commutative.
-/

structure Group₂ (G : Type) where
  mul : G → G → G
  one : G
  inv : G → G
  mul_assoc : ∀ a b c, mul (mul a b) c = mul a (mul b c)
  one_mul   : ∀ a, mul one a = a
  mul_inv   : ∀ a, mul a (inv a) = one

end L29
