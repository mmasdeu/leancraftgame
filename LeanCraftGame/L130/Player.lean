/-
# Challenge: classes

An instance is accepted by Lean as soon as its fields have the right *types*.
Whether they do the right *thing* is up to you, and a wrong instance is worse
than a wrong function: every `max`, `min`, `compare` and sort that uses it
silently inherits the mistake.

A competition scores each team with points and penalties:

```lean
structure Score where
  pts : ℕ
  penalty : ℕ
  deriving DecidableEq
```

## Ranking

The **value** of a score is `pts - penalty`, computed in `ℤ` (a team can end up
negative: `Score.mk 3 5` has value `-2`). Scores are **ranked**:

* higher value ranks higher;
* if the values are equal, more points ranks higher;
* if both agree, the scores are the same score.

## Three more standard classes

* `Ord α` has one field, `compare : α → α → Ordering`. An `Ordering` is one of
  `.lt` ("less"), `.eq` ("equal") or `.gt` ("greater"). `compare a b = .gt`
  means "`a` ranks higher than `b`". Here the instance must satisfy: `compare a
  b = .lt` exactly when `compare b a = .gt`, and `compare a a = .eq`.
  `compare` already works for `ℤ` and `ℕ`, and `o₁.then o₂` is `o₁` unless
  `o₁` is `.eq`, in which case it is `o₂` (just right for tie-breaks).
* `Max α` has the field `max : α → α → α`, and then `max a b` is available. It
  must return the higher-ranking of the two. `Min α` and `min` likewise, the
  lower-ranking.
* In a condition you can write `if compare a b = .lt then … else …`.

## Your task

Write `Score.value`, the three instances, and `best`: the highest-ranking score
of a list, with `best [] = Score.mk 0 0`. The tests check the instances on
awkward pairs; two of them are only *wrong in a corner*, so test your own code
in your head on ties and on negative values.
-/
namespace L130

structure Score where
  pts : ℕ
  penalty : ℕ
  deriving DecidableEq

-- points minus penalty, as an integer
def Score.value (s : Score) : ℤ := sorry

-- `compare a b = .gt` when `a` ranks higher than `b`
instance ordScore : Ord Score where
  compare a b := sorry

-- the higher-ranking of the two
instance maxScore : Max Score where
  max a b := sorry

-- the lower-ranking of the two
instance minScore : Min Score where
  min a b := sorry

-- the highest-ranking score of the list (`Score.mk 0 0` for the empty list)
def best : List Score → Score := sorry

end L130
