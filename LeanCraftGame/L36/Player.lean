/-
# Groups in Mathlib

*A new project: the home-made classes of the last world are retired, and the library
moves to Mathlib's groups and rings. Noor's first assignment is a vocabulary check: state
two classic theorems the Prover will be asked about, and compute in two small groups.*

The names to know:

* `[Group G]`: `G` is a group, written multiplicatively (`*`, `1`, `x⁻¹`);
  `[AddGroup A]` is the additive version (`+`, `0`, `-x`).
* `H : Subgroup G`: a subgroup (a carrier and its axioms, as in level 35). It
  is used as a type, `↥H`, whose elements are the elements of `G` that lie in `H`.
* `orderOf x`: the least `n > 0` with `x ^ n = 1` (and `0` if there is none);
  `addOrderOf a` is the additive version, with `n • a = 0`.
* `Nat.card G`: the number of elements of `G` (`0` if `G` is infinite). With an instance
  `[Fintype G]` there is also `Fintype.card G`.
* `ZMod n`: the integers modulo `n`. It is a commutative **ring**, so as a group it is
  the *additive* group ℤ/nℤ: there, the order of `4` in `ZMod 12` is the least `n > 0`
  with `n • 4 = 0`, which is `3` (since `3 • 4 = 12 = 0`).
* `Equiv.Perm α`: the permutations of `α`, a group under composition. `Equiv.swap a b`
  exchanges `a` and `b`; `σ * τ` is "first `τ`, then `σ`", like `f ⋄ g` in level 32.
  `Equiv.Perm (Fin 3)` is S₃, the non-commutative group in the referee's zoo of level 29.
* `MonoidHom.ker f : Subgroup G` and the quotient `G ⧸ H` complete the vocabulary.

## Stating Lagrange

Lagrange's theorem says that the order of a subgroup divides the order of the group:

```lean
statement lagrange {G : Type*} [Group G] (H : Subgroup G) : Nat.card H ∣ Nat.card G
```

The binders read: for every type `G` with a group structure, and every subgroup `H` of
`G`. Note the instance binder `[Group G]` and the coercion `Nat.card H` (the cardinality
of the type `↥H`).

## Your task

1. Write `lagrange` as above (copy the shape; this is your model).
2. Write `cauchy`, Cauchy's theorem: for a finite group `G` (`[Group G] [Fintype G]`) and
   a natural number `p`, if `p` is prime (`p.Prime`) and `p` divides `Fintype.card G`,
   then some `x : G` has `orderOf x = p`. Give the binders in this order: `G`, the two
   instances, `p`, then the two hypotheses.
3. `ord4`: the order of `4` in the additive group `ZMod 12`.
4. `σ`: a permutation of `Fin 3 = {0, 1, 2}` of order 3, and `τ` one of order 2.
-/
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.GroupTheory.Perm.Cycle.Basic
import Mathlib.Data.ZMod.Basic

namespace L36

statement lagrange : sorry

statement cauchy : sorry

-- the least n > 0 with n • (4 : ZMod 12) = 0
def ord4 : ℕ := sorry

-- a permutation of {0, 1, 2} of order 3
def σ : Equiv.Perm (Fin 3) := sorry

-- a permutation of {0, 1, 2} of order 2
def τ : Equiv.Perm (Fin 3) := sorry

end L36
