/-
# Anatomy of a theorem

*Much of the AM-GM project is already in Mathlib, and Noor wants nothing stated twice. So
you read first: what does a Mathlib theorem promise, and what does it ask for?*

To use a theorem, read its signature as `#check` prints it. Four from Mathlib:

```lean
mul_le_mul {α : Type*} [Mul α] [Zero α] [Preorder α] {a b c d : α}
    [PosMulMono α] [MulPosMono α]
    (h₁ : a ≤ b) (h₂ : c ≤ d) (c0 : 0 ≤ c) (b0 : 0 ≤ b) : a * c ≤ b * d

add_pow_two {α : Type*} [CommSemiring α] (a b : α) :
    (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2

pow_le_pow_left₀ {M₀ : Type*} [MonoidWithZero M₀] [Preorder M₀] {a b : M₀}
    [PosMulMono M₀] [MulPosMono M₀] (ha : 0 ≤ a) (hab : a ≤ b) (n : ℕ) : a ^ n ≤ b ^ n

le_div_iff₀ {G₀ : Type*} [GroupWithZero G₀] [PartialOrder G₀] [MulPosReflectLT G₀]
    {a b c : G₀} (hc : 0 < c) : a ≤ b / c ↔ a * c ≤ b
```

## Three kinds of brackets

* `( )` **explicit** arguments. You write them, in order, after the theorem's name.
* `{ }` **implicit** arguments. Lean works them out from the explicit ones. `{α : Type*}`
  means "`α` is some type", such as `ℝ`.
* `[ ]` **instance** arguments. Facts about the type that Lean finds in its library on
  its own. `[Preorder α]` says `α` has a `≤`. You can skip odd names like `PosMulMono`:
  they all hold for `ℝ`.

## Hypotheses and conclusion

Explicit arguments named `h…` are **hypotheses**: you supply a proof of each. For a
numeric fact, `(by norm_num)` is such a proof, written in place (`norm_num` is a tactic
that checks arithmetic). The type after the last colon is the **conclusion**, what you
get.

Every hypothesis is there for a reason. `le_div_iff₀` needs `hc : 0 < c`: with `c = -1`,
`a = 0` and `b = 1`, its left side `0 ≤ 1 / -1` is false and its right side
`0 * -1 ≤ 1` is true. Its conclusion is an `↔`, which works in both directions.

## Your task

Answer the questions below the lesson.
-/
namespace L4

def q1 : Fin 4 := sorry
def q2 : Fin 4 := sorry
def q3 : Fin 3 := sorry
def q4 : Fin 3 := sorry
def q5 : Bool := sorry
def q6 : Fin 3 := sorry
def q7 : Fin 3 := sorry

end L4
