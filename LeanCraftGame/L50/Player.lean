/-
# Order relations

A **partial order** on `α` is a relation `≤` that is reflexive,
antisymmetric and transitive. Some examples, each a test of your axioms:

* `≤` on `ℕ` (a total order);
* divisibility on `ℕ`, in which `0` is the largest element and `1` the
  smallest, and `2`, `3` are incomparable;
* inclusion of sets;
* *not* `<` (not reflexive), and *not* "`a % 3 ≤ b % 3`" (a preorder: `0`
  and `3` are below each other without being equal).

In the Topology world, a finite topology is the same thing as a preorder on
its points (`x ≤ y` when every open set containing `x` contains `y`), and
it is T0 exactly when that preorder is a partial order. Sierpiński space is
the two-element order `0 < 1`.

## Your task

Write the three axioms of a partial order `le` on `α`:

* **reflexive**: everything is related to itself;
* **antisymmetric**: if `a` is below `b` and `b` is below `a`, they are equal;
* **transitive**: if `a` is below `b` and `b` is below `c`, then `a` is below `c`.

Keep `le` as the first field and the axioms in the order listed. The referee
tests your structure on relations that are partial orders (`≤` and `≥` on
numbers, divisibility, equality...) and on relations that are not. Careful:
each of your axioms must be true for the first kind and false for the second.
-/
namespace L50

structure PartialOrder' (α : Type) where
  le : α → α → Prop
  refl : sorry
  antisymm : sorry
  trans : sorry

end L50
