/-
# Standard instances

Mathlib's notation is itself a family of type classes: `a + b` is
`Add.add a b`, `0` is `Zero.zero`, `-a` is `Neg.neg a`, `a - b` is
`Sub.sub a b`. Give a type these instances and the usual notation works
for it; more importantly, every theorem stated with that notation applies.

`ℤ²` with componentwise addition is the free abelian group of rank 2, the
lattice of a torus, the group of translations of the square grid. Its
elements are written here as a structure `Vec`.

The heterogeneous `HAdd α β γ` allows `a + b` with `a : α`, `b : β`: here,
adding an integer to both coordinates. Mathlib uses heterogeneous
operations for scalar multiplication `c • v` and for the action of a group
on a set. Use them sparingly: `v + 3` reading as "shift both coordinates by
3" is a convention you now have to remember.

## Your task

A `Vec` is an arrow in the plane. Give it the standard notation:

* `Add`: add coordinate by coordinate;
* `Zero`: the arrow `⟨0, 0⟩`;
* `Neg`: reverse the arrow, `-v = ⟨-v.x, -v.y⟩`;
* `Sub`: `u - v` is `u` followed by the reverse of `v` (mind the order);
* `HAdd Vec ℤ Vec`: `v + n` *moves* the arrow by `n` in both directions, that
  is, it adds `n` to each coordinate. (The three arguments of `HAdd` are the
  types of the left side, the right side and the result.)

Instances can use each other: inside `Sub` you may write `u + -v`.
-/
namespace L54

structure Vec where
  x : ℤ
  y : ℤ
  deriving DecidableEq

instance addVec : Add Vec where
  add u v := sorry

instance zeroVec : Zero Vec where
  zero := sorry

instance negVec : Neg Vec where
  neg v := sorry

instance subVec : Sub Vec where
  sub u v := sorry

instance shiftVec : HAdd Vec ℤ Vec where
  hAdd v n := sorry

end L54
