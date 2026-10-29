/-
# Your first structure

A **structure** bundles several values (and, as we will see, facts about them)
into one new type.

```lean
structure Point where
  x : Nat
  y : Nat
```

* `structure Point where` starts the definition of a new type `Point`.
* Each following indented line is a **field**: a name, a colon and a type.
* `Point.mk 3 4` builds a point with `x = 3` and `y = 4`.

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
namespace L14

-- two numbers `lo` and `hi`, in this order, with an axiom `lo ≤ hi`
structure Interval where
  lo : Nat
  hi : Nat
  -- your axiom here

-- a number `val` with an axiom saying that it is positive
structure PosNat where
  val : Nat
  -- your axiom here

end L14
