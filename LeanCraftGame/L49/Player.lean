/-
# Your first structure

In the Structure Syntax world a structure bundled *data*: a point is two
numbers, a rectangle a width and a height. Mathematicians use structures for
more: they bundle data with the **facts** that must hold about it. A group is
some data (an operation, an identity, inverses) together with laws. That is
what this world is about, and what you will check, write and audit here.

You already know how to declare fields and to build values (`Point.mk 3 4`,
`⟨3, 4⟩`, `{ x := 3, y := 4 }`). Nothing of that changes.

## Fields that are statements

The type of a field can also be a *statement*. Such a field is an **axiom**:
whoever builds the structure must supply a reason why the statement is true.

```lean
structure Even' where
  val : Nat
  even : val % 2 = 0
```

`Even'.mk 4 _` can be built (4 is even), but nobody can build `Even'.mk 3 _`.

The referee tests a structure with *models*: it feeds it data that **should**
be accepted (✅ if all axioms are true) and junk data that **should** be
rejected (✅ if some axiom fails).

## Your task

Define `Interval` with two numbers `lo` and `hi` and an axiom saying that
`lo ≤ hi`. Then define `PosNat`, a number `val` that is positive.
Keep the fields in the order they are listed.
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
