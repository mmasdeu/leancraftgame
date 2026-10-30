/-
# Relations

A **relation** on `ℕ` is a statement about two numbers, `r : ℕ → ℕ → Prop`.
`r a b` reads "`a` is related to `b`". Examples: `(· ≤ ·)`, `(· ∣ ·)`, or
`fun a b => a % 3 = b % 3` ("same remainder mod 3"). (`(· ≤ ·)` is a short way
to write `fun a b => a ≤ b`.)

Mathematicians sort relations by the *laws* they obey: reflexive, symmetric,
transitive, antisymmetric. Each law is a statement about **all** numbers, and
laws of the form "if … then …" are **vacuously true** when the "if" never
happens: the relation that relates nothing is symmetric, transitive and
antisymmetric, without relating anything to anything.

Mathlib has all these notions (`Std.Refl`, `IsSymm`, `IsTrans`, `IsAntisymm`,
`Equivalence`, `PartialOrder`), but they are stated for typeclasses, so here you
write your own versions. The primes `'` keep the names apart from Mathlib's.

Write the laws, then the two classical bundles: an **equivalence relation** is
reflexive, symmetric and transitive; a **partial order** is reflexive,
antisymmetric and transitive. Reuse your own definitions with `∧`.

## Your task

Fill in the six definitions. The referee tests them on relations such as `≤`,
`<`, `∣`, "same remainder mod 3", `≠`, the empty relation and the full one.
-/
namespace L109

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

end L109
