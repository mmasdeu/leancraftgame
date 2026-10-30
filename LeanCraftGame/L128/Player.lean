/-
# Standard instances

In "Classes and instances" you wrote instances of a class that we invented.
Lean and Mathlib come with many classes of their own, and each one is the
reason a certain piece of notation works:

* `Add α` makes `a + b` mean something for `a b : α`; its one field is `add`.
* `Neg α` does the same for `-a` (field `neg`), `Sub α` for `a - b` (`sub`).
* `Zero α` explains the numeral `0 : α` (field `zero`).
* `HAdd α β γ` is the *general* `+`: it adds an `α` to a `β` and returns a
  `γ`. `Add α` is the special case where all three types are the same.

Without an instance, `p + q` is an error: *failed to synthesize HAdd Point
Point ?γ*. With one, Lean rewrites `p + q` to your function, and everything
you know about `+` (reading it, writing it) works for your own type.

```lean
structure Point where
  x : ℤ
  y : ℤ
  deriving DecidableEq

instance : Add Point where
  add p q := ⟨p.x + q.x, p.y + q.y⟩

instance : Zero Point where
  zero := ⟨0, 0⟩
```

* `deriving DecidableEq` lets Lean decide whether two points are equal (the
  referee needs it to run its tests).
* `⟨a, b⟩` is short for `Point.mk a b`.
* After this, `Point.mk 1 2 + Point.mk 3 4` is `Point.mk 4 6`, and
  `(0 : Point)` is the origin.

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
namespace L128

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

end L128
