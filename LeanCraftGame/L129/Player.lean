/-
# Instances that depend on instances

Sizes of strings, numbers and rectangles are fine, but what is the size of a
*list* of strings, or of a *pair* of rectangles? The answer depends on what the
entries are, so an instance for lists cannot be written once and for all: it
must say "**if** `α` has a `Size`, **then** so does `List α`".

```lean
instance {α : Type} [Size α] : Size (List α) where
  size xs := (xs.map Size.size).sum
```

* `{α : Type}` says "for every type `α`" (curly braces: Lean finds `α` itself).
* `[Size α]` is the **condition**, an instance argument exactly as in a
  function. Inside the instance it gives you `Size.size : α → ℕ`, which is how
  the code above measures each entry.
* `xs.map Size.size` is the list of the sizes of the entries, `.sum` adds them.

Lean uses such instances like pieces of a puzzle. To find `Size (List String)`
it matches the instance above, which asks for `Size String`, which is another
instance. For `Size (List (List String))` it uses the list instance *twice*.
If a piece is missing, Lean says *failed to synthesize* and names it.

## Why `[Size α]` must be written

The same holds for functions. This does **not** compile:

```lean
def total {α : Type} (xs : List α) : ℕ := (xs.map Size.size).sum
```

Lean cannot know that `α` can be measured: `α` might be any type at all.
Writing `[Size α]` in the signature is the promise "whoever calls `total` will
pass a type that has a `Size`". The instance itself is passed along silently.

## A class built on another

```lean
class Weighted (α : Type) extends Size α where
  weight : α → ℕ
```

`extends Size α` says that every `Weighted` type is in particular a `Size`
type: a `Weighted α` contains the field `size` and also the new field `weight`.
So in a function with `[Weighted α]` you may use `Size.size` as well:
Lean gets the `Size α` out of the `Weighted α`.

## Your task

`Pair α` is two values of type `α`. Complete five things (the signatures are
fixed, the tests use them at several types, also nested ones):

* `Add (Pair α)` when `α` has `Add`: coordinatewise;
* `Size (Pair α)` when `α` has `Size`: the sizes of both values, added;
* `Size (List α)` when `α` has `Size`: the sizes of all entries, added;
* `largest`: the biggest size among the entries of a list (0 for the empty list);
* `heavy`: the size of `a` plus its weight.
-/
namespace L129

class Size (α : Type) where
  size : α → ℕ

instance sizeNat : Size ℕ where
  size n := n

instance sizeString : Size String where
  size s := s.length

class Weighted (α : Type) extends Size α where
  weight : α → ℕ

instance weightedNat : Weighted ℕ where
  size n := n
  weight n := 2 * n

instance weightedString : Weighted String where
  size s := s.length
  weight _ := 10

structure Pair (α : Type) where
  fst : α
  snd : α
  deriving DecidableEq

-- if `α` can be added, so can `Pair α`
instance addPair {α : Type} [Add α] : Add (Pair α) where
  add p q := sorry

-- the size of a pair: the sizes of both values, added
instance sizePair {α : Type} [Size α] : Size (Pair α) where
  size p := sorry

-- the size of a list: the sizes of all its entries, added
instance sizeList {α : Type} [Size α] : Size (List α) where
  size xs := sorry

-- the biggest size among the entries (0 for the empty list)
def largest {α : Type} [Size α] (xs : List α) : ℕ := sorry

-- the size of `a` plus its weight
def heavy {α : Type} [Weighted α] (a : α) : ℕ := sorry

end L129
