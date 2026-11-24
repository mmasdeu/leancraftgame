/-
# Spot the bug: classes

Three instances from a colleague. Each type checks; each breaks a law that
every user of the class silently relies on.

* An `Add` on marks that **averages**: `a + b = (a + b)/2`. Is it
  associative? Is there a zero? A theorem about sums would be false for it,
  and nothing in the type tells you.
* A `Size` on lists that looks only at the first element.
* A `Max` on versions that compares only the minor number. `max` must
  agree with the order: `max a b` is the larger one.

This is the price of automatic instance search: the instance you wrote is
used *everywhere*, by every lemma that applies to the class. Mathlib's
classes therefore carry their axioms as fields (an `AddCommGroup` must prove
associativity), and a wrong instance cannot be built. These classes carry
none; your counterexamples show what goes wrong.

## Your task

For each instance, give inputs on which it breaks its law.
-/
namespace L57

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

end L57
