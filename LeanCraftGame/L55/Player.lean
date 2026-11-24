/-
# Instances that depend on instances

If `A` and `B` are groups, so is `A × B`; if `R` is a ring, so is `R[X]`;
if `X` is a topological space, so is `X × X`. Constructions on structures
are instances **with hypotheses**:

```lean
instance addPair {α : Type} [Add α] : Add (Pair α) where
  add p q := ⟨p.fst + q.fst, p.snd + q.snd⟩
```

reads "for every `α` with an addition, `Pair α` has one". Lean chains such
instances automatically: `Pair (Pair ℤ)` gets an addition from `Pair ℤ`,
which gets one from `ℤ`. This is how Mathlib knows that `ℝ × ℝ` is a vector
space, a metric space and a topological space without being told.

Classes can also **extend** each other, as structures do: a `Weighted α` is
a `Size α` with an extra field, and an instance of the first provides one of
the second. Mathlib's hierarchy (`Monoid → Group → CommGroup`, `Ring →
Field`) is built this way.

## Your task

`Pair α` is two values of type `α`. Complete five things (the signatures are
fixed, the tests use them at several types, also nested ones):

* `Add (Pair α)` when `α` has `Add`: coordinatewise;
* `Size (Pair α)` when `α` has `Size`: the sizes of both values, added;
* `Size (List α)` when `α` has `Size`: the sizes of all entries, added;
* `largest`: the biggest size among the entries of a list (0 for the empty list);
* `heavy`: the size of `a` plus its weight.
-/
namespace L55

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

end L55
