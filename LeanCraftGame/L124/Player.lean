/-
# Extending and updating

Three more tools for structures. Each is small.

## Updating a value: `with`

Values never change in Lean, but you can build a *copy with one field
different*:

```lean
def p : Point := ⟨3, 4⟩
def q : Point := { p with x := 5 }     -- ⟨5, 4⟩
```

`{ p with x := 5 }` means: "like `p`, except that `x` is `5`". Every field you
do not mention is copied from `p`. The new value may use the old one:
`{ p with x := p.x + 1 }` is `⟨4, 4⟩`. You may update several fields, separated
by commas: `{ p with x := 0, y := 0 }`.

## Default values

A field can come with a default value, written after `:=`:

```lean
structure Window where
  width : ℕ := 80
  height : ℕ := 24
```

Fields with a default may be left out when building a value, and `{}` leaves
out all of them:

```lean
def a : Window := {}                  -- width 80, height 24
def b : Window := { width := 100 }    -- width 100, height 24
```

## Extending a structure

`extends` builds a new structure on top of an old one:

```lean
structure Point3 extends Point where
  z : ℕ
```

A `Point3` has all the fields of a `Point`, plus `z`. The parent comes as the
*first* argument of the constructor: `Point3.mk ⟨1, 2⟩ 3` has `x = 1`,
`y = 2` and `z = 3`. You read the parent's fields directly, `q.x`, or get the
whole parent with `q.toPoint`.
`{ q with z := 0 }` updates a `Point3`, and copies `x` and `y` for you.

## Structures with a parameter

A structure may depend on a type, written in parentheses after its name:

```lean
structure Pair (α : Type) where
  fst : α
  snd : α
```

`Pair ℕ` is a pair of natural numbers, `Pair Prop` a pair of statements, …
A function on `Pair` names the type in curly brackets, which Lean then fills in
by itself from the other inputs:

```lean
def Pair.first {α : Type} (p : Pair α) : α := p.fst
```

## Your task

`Point` is declared. Write `moveRight`; declare `Settings` with default
values, and `Point3` and `Pair`; then write the functions on them.
-/
namespace L124

structure Point where
  x : ℕ
  y : ℕ

-- `n` more to the right: x grows by `n`, y stays.   (moveRight ⟨3, 4⟩ 2 is ⟨5, 4⟩)
-- Build it with `{ p with ... }`.
def moveRight (p : Point) (n : ℕ) : Point := sorry

-- three fields, in this order, all natural numbers, with these defaults:
--   volume 5, brightness 7, muted 0
structure Settings where
  -- your fields here

-- the settings with volume 0 and everything else left at its default
def quiet : Settings := sorry

-- the new field is `z : ℕ`, after the parent `Point`
structure Point3 extends Point where
  -- your field here

-- go up by `h`: z grows by `h`, and x, y stay   (raise (Point3.mk ⟨1, 2⟩ 3) 10 has z = 13)
def raise (q : Point3) (h : ℕ) : Point3 := sorry

-- two fields `fst` and `snd`, both of type `α`
structure Pair (α : Type) where
  -- your fields here

-- exchange the two fields
def Pair.swap {α : Type} (p : Pair α) : Pair α := sorry

-- both fields equal to `a`
def Pair.dup {α : Type} (a : α) : Pair α := sorry

end L124
