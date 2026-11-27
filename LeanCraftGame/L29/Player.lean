/-
# Sam's groups

*Before the project could use Mathlib's groups, Sam wrote some over lunch: associativity,
an identity, inverses. The file compiles. Noor asks whether every model of Sam's axioms is
really a group.*

Like `StandardTwoSimplex` in level 28, an algebraic structure is a structure whose fields
are the operations and the axioms:

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

A model is the data (`mul`, `one`, `inv`) plus proofs of the axioms. Getting the axioms
right is the hard part. Too few, and junk satisfies them. Too many, and real groups fail.

Sam used a *left* identity and a *right* inverse:

```lean
mul_assoc : ∀ a b c, mul (mul a b) c = mul a (mul b c)
one_mul   : ∀ a, mul one a = a
mul_inv   : ∀ a, mul a (inv a) = one
```

One-sided axioms are fine when both are on the same side: a left identity and left
inverses give a group. With mixed sides they aren't enough. Some operations on a
two-element set satisfy them even though `mul a one ≠ a`.

So for any set of axioms, ask: does it allow **junk models**? Don't stare at the axioms.
Look for a small model that satisfies them and breaks a property every group has.
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

Find a junk model: an operation on `Bool` (the type with the two values `true` and
`false`) that satisfies every axiom of `Group'` but is not a group. Give only the data.
The referee checks the axioms for you.

Hint: do the axioms above imply `mul a one = a`?
-/

def junkMul : Bool → Bool → Bool := sorry
def junkOne : Bool := sorry
def junkInv : Bool → Bool := sorry

/-
## Part B: Fix it

Write a correct definition. Keep `mul`, `one`, `inv` as the first three fields, in this
order. The axioms are up to you.

The referee tries your structure on many models. Real groups must satisfy all your axioms.
Each junk model must break at least one. Some of the groups are not commutative.
-/

structure Group₂ (G : Type) where
  mul : G → G → G
  one : G
  inv : G → G
  mul_assoc : ∀ a b c, mul (mul a b) c = mul a (mul b c)
  one_mul   : ∀ a, mul one a = a
  mul_inv   : ∀ a, mul a (inv a) = one

end L29
