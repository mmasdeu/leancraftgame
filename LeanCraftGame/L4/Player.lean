/-
# Anatomy of a theorem

*Much of the AM-GM project is already in Mathlib, and Noor wants nothing stated twice. So
you read first: what does a Mathlib theorem promise, and what does it ask for?*

To use a theorem, read its signature as `#check` prints it. Four from Mathlib:

```lean
mul_le_mul {α : Type u_1} [Mul α] [Zero α] [Preorder α] {a b c d : α}
    [PosMulMono α] [MulPosMono α]
    (h₁ : a ≤ b) (h₂ : c ≤ d) (c0 : 0 ≤ c) (b0 : 0 ≤ b) : a * c ≤ b * d

add_pow_two {α : Type u} [CommSemiring α] (a b : α) :
    (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2

pow_le_pow_left₀ {M₀ : Type u_2} [MonoidWithZero M₀] [Preorder M₀] {a b : M₀}
    [PosMulMono M₀] [MulPosMono M₀] (ha : 0 ≤ a) (hab : a ≤ b) (n : ℕ) : a ^ n ≤ b ^ n

le_div_iff₀ {G₀ : Type u_3} [GroupWithZero G₀] [PartialOrder G₀] [MulPosReflectLT G₀]
    {a b c : G₀} (hc : 0 < c) : a ≤ b / c ↔ a * c ≤ b
```

## Three kinds of brackets

* `( )` **explicit** arguments. You write them when you use the theorem. In
  `add_pow_two x y`, `x` and `y` fill `a` and `b`.
* `{ }` **implicit** arguments. Lean works them out. In `mul_le_mul h₁ h₂ c0 b0`, Lean
  reads `a b c d` and `α` off the types of `h₁` and `h₂`.
* `[ ]` **instance** arguments. Facts about the type that Lean finds in its library.
  `[CommSemiring α]` says `α` has `+` and `*` with the usual laws, as `ℕ`, `ℤ`, `ℚ`, `ℝ`
  do. Odd names like `PosMulMono` (multiplying by a nonnegative number is monotone) are
  conditions the proof needs. All hold for `ℝ`.

## Hypotheses and conclusion

Explicit arguments named `h…` are **hypotheses**: you supply a proof of each. The type
after the last colon is the **conclusion**, what you get. So `pow_le_pow_left₀` gives
`a ^ n ≤ b ^ n` from `a ≤ b` only when `0 ≤ a`. Without that, it's false: `-2 ≤ 1`, but
`4 > 1`.

An `↔` conclusion, as in `le_div_iff₀`, works in both directions.

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
