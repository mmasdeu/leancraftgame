/-
# Order relations

A **partial order** is a way of saying "`a` comes before `b`" that need not
compare everything: `3 ∣ 6`, but neither `2 ∣ 3` nor `3 ∣ 2`.

Here a structure with one *data* field (the relation) and some *axiom* fields
(the laws it must obey). Remember that `le a b` is a statement, so the relation
has type `α → α → Prop`.

```lean
structure Equivalence' (α : Type) where
  rel   : α → α → Prop
  refl  : ∀ a, rel a a
```

You can use `\forall` for `∀`, `\to` for `→`, `\le` for `≤` and `\mid` for `∣`.

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
namespace L113

structure PartialOrder' (α : Type) where
  le : α → α → Prop
  refl : sorry
  antisymm : sorry
  trans : sorry

end L113
