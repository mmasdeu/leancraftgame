/-
# Sam's groups

*Before the project could use Mathlib's groups, Sam wrote some over lunch. The file
compiles. Noor asks whether every model of Sam's axioms is really a group.*

A **group** is a set with an associative product, an element `one` with
`one * a = a * one = a` for every `a`, and an inverse for each `a`, with
`a * a⁻¹ = a⁻¹ * a = one`. Some groups are not commutative. For example, S₃, the six
symmetries of a triangle: a reflection followed by a rotation differs from the rotation
followed by the reflection.

Like `StandardTwoSimplex` in level 28, an algebraic structure has the operations and the
axioms as fields. Here is a monoid (a group without inverses):

```lean
structure Monoid₁ (α : Type*) where
  mul : α → α → α
  one : α
  mul_assoc : ∀ x y z : α, mul (mul x y) z = mul x (mul y z)
  mul_one : ∀ x : α, mul x one = x
  one_mul : ∀ x : α, mul one x = x
```

A model is the data (`mul`, `one`) plus proofs of the axioms. With too few axioms,
junk satisfies them. With too many, real groups fail.

Sam's `Group'` (in the editor) uses a *left* identity and a *right* inverse. A left
identity with left inverses does give a group. Mixed sides don't.

So ask of any axioms: do they allow **junk models**? Look for a small model that satisfies
them and breaks a property every group has.
-/
import Mathlib.Tactic

namespace L28

structure Group' (G : Type) where
  mul : G → G → G
  one : G
  inv : G → G
  mul_assoc : ∀ a b c, mul (mul a b) c = mul a (mul b c)
  one_mul   : ∀ a, mul one a = a
  mul_inv   : ∀ a, mul a (inv a) = one

-- Text between `/-` and `-/` is a block comment, like `--` over several lines.
/-
## Part A: Break it

Find a junk model: an operation on `Bool` (the type with the two values `true` and
`false`) that satisfies every axiom of `Group'` but is not a group. Give only the data.
The referee checks the axioms for you. A function of two arguments is written
`fun a b => …`.

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
Each junk model must break at least one. One of the groups is S₃.
-/

structure Group₂ (G : Type) where
  mul : G → G → G
  one : G
  inv : G → G
  mul_assoc : ∀ a b c, mul (mul a b) c = mul a (mul b c)
  one_mul   : ∀ a, mul one a = a
  mul_inv   : ∀ a, mul a (inv a) = one

end L28
