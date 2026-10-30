/-
# Classes and instances

Many things in Lean can be "measured": a string has a length, a list has a
number of entries, a rectangle has an area. We would like one word, `size`,
that works for all of them, and does the right thing for each. That is what a
**class** is for.

```lean
class Size (α : Type) where
  size : α → ℕ
```

* `class Size (α : Type) where` starts a new class. It is declared like a
  structure (the field `size` is a function giving a number for every `α`),
  and `α` is the type that is being measured.
* On its own the class says nothing about any particular type. For that you
  write an **instance**: the recipe for one type.

```lean
instance : Size ℕ where
  size n := n
```

* `instance : Size ℕ where` reads "here is how `ℕ` is a `Size`". Below it you
  give each field, here `size n := n` ("the size of a number is the number").
* From now on `Size.size (7 : ℕ)` is `7`. Lean found the right recipe *by
  itself*: it saw that the argument has type `ℕ` and looked through the
  instances it knows for one of the form `Size ℕ`. This search is called
  **instance resolution**.
* Writing `instance name : Size ℕ where …` gives the instance a name. It is
  optional; the referee needs the names below to find your instances.
* If no instance exists, Lean complains *failed to synthesize Size Foo*. You can
  ask it directly: `example : Size ℕ := inferInstance` works, and the same line
  for a type with no instance is an error.

## A function that uses the class

```lean
def bigger {α : Type} [Size α] (a b : α) : Prop := Size.size b < Size.size a
```

`[Size α]` is an instance argument (you met it in "Generality" as
`[Preorder α]`): `bigger` works for every type that has a `Size`, and Lean
supplies the instance when you use it.

## Your task

Three instances are missing. The sizes mean:

* a `String`: the number of characters (`String.length`);
* a `List ℕ`: the number of entries (not their sum!);
* a `Rect` (a rectangle with width `w` and height `h`): the number of unit
  squares in it.
-/
namespace L127

class Size (α : Type) where
  size : α → ℕ

instance sizeNat : Size ℕ where
  size n := n

-- the worked example
def bigger {α : Type} [Size α] (a b : α) : Prop := Size.size b < Size.size a

structure Rect where
  w : ℕ
  h : ℕ

-- the number of characters
instance sizeString : Size String where
  size s := sorry

-- the number of entries
instance sizeList : Size (List ℕ) where
  size xs := sorry

-- the number of unit squares
instance sizeRect : Size Rect where
  size r := sorry

end L127
