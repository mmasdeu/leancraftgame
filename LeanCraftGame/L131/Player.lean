/-
# Spot the bug: classes

Lean checks that an instance has the right *types*. It does not check that it
behaves: `a + b` may be any function you like, and Lean will happily rewrite
`a + b + c` as `(a + b) + c` whatever your `+` does. A colleague wrote the
instances below. Each compiles and each is wrong.

```lean
-- a mark is a number; adding two marks gives their average (rounded down)
structure Mark where
  v : ℕ
  deriving DecidableEq

instance : Add Mark where
  add a b := ⟨(a.v + b.v) / 2⟩

-- the size of a list is the sum of the sizes of its entries
instance {α : Type} [Size α] : Size (List α) where
  size xs := match xs with
    | [] => 0
    | a :: _ => Size.size a

-- `max a b` is the newer of two versions
structure Version where
  major : ℕ
  minor : ℕ

instance : Ord Version where
  compare a b := (compare a.major b.major).then (compare a.minor b.minor)

instance : Max Version where
  max a b := if a.minor ≤ b.minor then b else a
```

(`Size` is the class of "Classes and instances". The colleague's code
follows below in full; the referee uses its own copy.) The colleague's
comments are what each instance is *supposed* to do. In the code of `Mark`, the
colleague also wrote: "since `+` is associative, the order of adding marks
does not matter".

## Translate before you hunt

* `Mark`: is `(a + b) + c` always `a + (b + c)`? Try the marks 0, 0 and 4 by
  hand: first add the first two, then add 4; then add the last two first.
* `Size (List α)`: which entries does the `match` look at?
* `Version`: `compare` and `max` are two *different* instances of two
  different classes. Lean never checks that they agree. Is `max a b` always the
  higher version, according to `compare`?

## Your task

Give an input that shows each bug. The tests run the colleague's code:

* `assocA`, `assocB`, `assocC`: three numbers (the values of three marks) with
  `(a + b) + c ≠ a + (b + c)`;
* `badList`: a list of numbers whose `Size` is not the sum of its entries;
* `version1`, `version2`: two versions, as pairs (major, minor), such that
  `max` returns a version that is *lower* than one of them, according to
  `compare`.
-/
namespace L131

-- The colleague's code, to read (the referee uses its own copy).
class Size (α : Type) where
  size : α → ℕ

instance : Size ℕ where
  size n := n

structure Mark where
  v : ℕ
  deriving DecidableEq

instance : Add Mark where
  add a b := ⟨(a.v + b.v) / 2⟩

instance {α : Type} [Size α] : Size (List α) where
  size xs := match xs with
    | [] => 0
    | a :: _ => Size.size a

structure Version where
  major : ℕ
  minor : ℕ

instance : Ord Version where
  compare a b := (compare a.major b.major).then (compare a.minor b.minor)

instance : Max Version where
  max a b := if a.minor ≤ b.minor then b else a

-- three numbers with (a + b) + c ≠ a + (b + c) for the colleague's `+`
def assocA : ℕ := sorry
def assocB : ℕ := sorry
def assocC : ℕ := sorry

-- a list whose `Size` is not the sum of its entries
def badList : List ℕ := sorry

-- two versions (major, minor): `max` gives one that `compare` says is lower
def version1 : ℕ × ℕ := sorry
def version2 : ℕ × ℕ := sorry

end L131
