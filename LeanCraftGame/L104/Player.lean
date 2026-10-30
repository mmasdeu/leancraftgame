/-
# Challenge: patterns in sequences

Four properties of a sequence `u : ℕ → ℕ` that mathematicians use all the
time. Each one needs **nested** quantifiers, and the order and the bounds are
the whole point.

* `Periodic u`: the sequence repeats itself exactly, after some fixed
  number of steps `p`. (`n % 3` is periodic, with period 3.) Careful: what
  would `p = 0` say?
* `EventuallyConstant u`: from some index on, the sequence stays at one
  single value. That value is not given in advance: it may depend on `u`.
* `HasMaximum u`: some term of the sequence is at least as large as every
  term (not "every term is below some larger term").
* `EventuallyPeriodic u`: the sequence repeats itself from some index on,
  after a preliminary stretch that may be irregular.
  (`if n < 5 then 7 else 0` is not periodic, but is eventually periodic.)

The tests are hidden: ask yourself which sequence would fool a definition with
the wrong order of quantifiers, a missing bound, or a fixed constant.
-/
namespace L104

-- there is a period p > 0 with u (n + p) = u n for every n
def Periodic (u : ℕ → ℕ) : Prop := sorry

-- from some index on, u is equal to one fixed value
def EventuallyConstant (u : ℕ → ℕ) : Prop := sorry

-- some term is at least as large as all the terms
def HasMaximum (u : ℕ → ℕ) : Prop := sorry

-- from some index on, u repeats itself with some period p > 0
def EventuallyPeriodic (u : ℕ → ℕ) : Prop := sorry

end L104
