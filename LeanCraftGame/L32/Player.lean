/-
# Relations

A binary relation on `ℕ` is a function `r : ℕ → ℕ → Prop`: `r a b` is the
statement "`a` is related to `b`". Relations are classified by a handful of
properties:

* **reflexive**: `r a a` for every `a`;
* **symmetric**: `r a b → r b a`;
* **transitive**: `r a b → r b c → r a c`;
* **antisymmetric**: `r a b → r b a → a = b`.

An **equivalence relation** (reflexive, symmetric, transitive) is what you
quotient by: congruence mod `n` gives `ℤ/nℤ`. A **partial order**
(reflexive, antisymmetric, transitive) is what you compare with:
divisibility on `ℕ` is one, and `0` is its largest element.

Each property is independent of the others: "`|a - b| ≤ 1`" is reflexive
and symmetric but not transitive; `<` is transitive and antisymmetric
(vacuously!) but not reflexive. The referee tests your definitions on such
examples.

In the Topology world you will meet the same properties on finite sets,
with equivalence classes and the partitions they form.

## Your task

Define the four properties, then equivalence relations and partial orders.
-/
namespace L32

-- every a is related to itself
def Reflexive' (r : ℕ → ℕ → Prop) : Prop := sorry

-- if a is related to b, then b is related to a
def Symmetric' (r : ℕ → ℕ → Prop) : Prop := sorry

-- if a is related to b and b to c, then a is related to c
def Transitive' (r : ℕ → ℕ → Prop) : Prop := sorry

-- if a is related to b and b to a, then a and b are equal
def Antisymmetric' (r : ℕ → ℕ → Prop) : Prop := sorry

-- reflexive, symmetric and transitive
def IsEquivalence' (r : ℕ → ℕ → Prop) : Prop := sorry

-- reflexive, antisymmetric and transitive
def IsPartialOrder' (r : ℕ → ℕ → Prop) : Prop := sorry

end L32
