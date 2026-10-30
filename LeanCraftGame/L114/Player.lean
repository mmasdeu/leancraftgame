/-
# Metric spaces

A **distance** tells how far apart two points are. On a type `α` it is a
function `dist : α → α → ℤ` (we use integers `ℤ`, so that negative numbers are
possible: your axioms have to forbid them).

The usual laws are:

* the distance from a point to itself is `0`, and it is `0` **only** for
  equal points;
* the distance is never negative;
* it is **symmetric**: from `a` to `b` is as far as from `b` to `a`;
* the **triangle inequality**: going from `a` to `c` directly is never longer
  than going through `b`.

## Your task

Write the four axioms of a metric, in the order listed above. The first one is
a single `↔` statement (type it `\iff`); `≤` is `\le`.

The referee tests your structure on genuine distances (`|x - y|`, the
distance that is `0` for equal points and `1` for different ones...) and on
imposters (`x - y`, `(x - y)^2`, ...). Each of your axioms must be true for
the first kind, and the imposters must each fail at least one of them.

Think about what each imposter gets wrong.
-/
namespace L114

structure Metric' (α : Type) where
  dist : α → α → ℤ
  eq_zero : sorry
  nonneg : sorry
  symm : sorry
  triangle : sorry

end L114
