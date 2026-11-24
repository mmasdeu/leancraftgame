/-
# Limits

The definition that took the nineteenth century to get right:

> `u n → a` when for every `ε > 0` there is an `N` such that
> `|u n - a| < ε` for every `n ≥ N`.

Everything from the previous worlds is in it: three quantifiers in a fixed
order, a restricted `∀ ε > 0` (an implication) and a restricted `∀ n ≥ N`
(the "eventually" of the Quantifier world). The sequences now take real
values, `u : ℕ → ℝ`, and `|x|` is the absolute value (type `|` twice).

Every part is load-bearing:

* without `ε > 0`, taking `ε = 0` (or `ε < 0`) makes every sequence fail;
* with `∃ n` instead of `∀ n ≥ N`, a sequence that merely comes close once
  would converge;
* with `∃ N` before `∀ ε`, only eventually constant sequences would converge.

The definition is a special case of convergence in a topological space
(the Topology world): the sets `{x | |x - a| < ε}` are a basis of
neighbourhoods of `a`.

`ℝ` is not computable, so the referee proves these statements: it chooses
`N` from `ε` like a student would, and closes the inequalities with
`linarith` and friends.

## Your task

Define `ConvergesTo u a`.
-/
namespace L39

-- some bound M is at least every |u n| (already done)
def BoundedSeq (u : ℕ → ℝ) : Prop := ∃ M, ∀ n, |u n| ≤ M

-- u converges to a: for every ε > 0, from some index N on,
-- every term u n is within ε of a
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := sorry

end L39
