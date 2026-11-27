/-
# Groups in Mathlib

*A new project: the library moves from home-made classes to Mathlib's groups and rings.
Noor starts with vocabulary: state two classic theorems, and compute in two small groups.*

The names to know:

* `[Group G]`: `G` is a group, written with `*`, `1`, `x⁻¹`. `[AddGroup A]` is the
  additive version (`+`, `0`, `-x`).
* `H : Subgroup G`: a subgroup (a carrier and its axioms, as in level 35). As a type, `↥H`,
  its elements are the elements of `G` in `H`.
* `orderOf x`: the least `n > 0` with `x ^ n = 1`, or `0` if there is none. `addOrderOf a`
  is the additive version, with `n • a = 0`.
* `Nat.card G`: the number of elements of `G` (`0` if `G` is infinite). With `[Fintype G]`
  there is also `Fintype.card G`.
* `ZMod n`: the integers modulo `n`. It's a commutative ring, so as a group it's the
  additive group ℤ/nℤ. The order of `4` in `ZMod 12` is the least `n > 0` with
  `n • 4 = 0`, which is `3`.
* `Equiv.Perm α`: the permutations of `α`, a group under composition. `Equiv.swap a b`
  exchanges `a` and `b`. `σ * τ` means first `τ`, then `σ`, like `f ⋄ g` in level 32.
  `Equiv.Perm (Fin 3)` is S₃, the non-commutative group from level 29.
* `MonoidHom.ker f : Subgroup G` and the quotient `G ⧸ H`.

## Stating Lagrange

Lagrange's theorem: the order of a subgroup divides the order of the group.

```lean
statement lagrange {G : Type*} [Group G] (H : Subgroup G) : Nat.card H ∣ Nat.card G
```

Read: for every type `G` with a group structure, and every subgroup `H` of `G`. Note the
instance binder `[Group G]` and the coercion in `Nat.card H` (the size of `↥H`).

## Your task

1. Write `lagrange` as above. It's your model.
2. Write `cauchy`, Cauchy's theorem: for a finite group `G` (`[Group G] [Fintype G]`) and a
   natural number `p`, if `p` is prime (`p.Prime`) and `p` divides `Fintype.card G`, then
   some `x : G` has `orderOf x = p`. Binders in this order: `G`, the two instances, `p`,
   then the two hypotheses.
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
