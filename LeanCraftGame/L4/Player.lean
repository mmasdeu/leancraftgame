/-
# Anatomy of a theorem

*Much of the AM-GM project is already in Mathlib, and Noor wants nothing stated twice.
So before writing, you read: what does a Mathlib theorem promise, and what does it ask
for in return? The Prover uses these theorems constantly, and it never applies one
without every hypothesis.*

To use a theorem you must read its signature, as `#check` prints it. Here are four,
copied from Mathlib:

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

* `( )` **explicit** arguments: you write them when you apply the theorem. In
  `add_pow_two x y`, `x` and `y` fill `a` and `b`.
* `{ }` **implicit** arguments: Lean works them out from the other arguments. In
  `mul_le_mul h₁ h₂ c0 b0`, the numbers `a b c d` are read off the types of `h₁` and
  `h₂`, and the type `α` too.
* `[ ]` **instance** arguments: facts about the type that Lean finds in its library on
  its own. `[CommSemiring α]` says "`α` has `+` and `*` satisfying the usual laws of a
  commutative semiring", which holds for `ℕ`, `ℤ`, `ℚ`, `ℝ`. The odd names
  (`PosMulMono`: multiplying by a nonnegative number is monotone) are the precise
  conditions the proof needs; for `ℝ` they all hold.

## Hypotheses and conclusion

The explicit arguments named `h…` are **hypotheses**: to use the theorem you must supply a
proof of each. The type after the **last** colon is the **conclusion**: what you get. A
theorem is only as strong as its hypotheses allow: `pow_le_pow_left₀` gives `a ^ n ≤ b ^ n`
from `a ≤ b` *only when* `0 ≤ a`. Forgetting a hypothesis is how false statements are
born (`-2 ≤ 1`, but `4 > 1`).

An `↔` conclusion, as in `le_div_iff₀`, can be used in both directions.

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
