/-
# How Lean parses

*A new project: Noor wants AM-GM and its friends stated for the library, from
`2 * a * b ≤ a ^ 2 + b ^ 2` to facts about `min` and `max`. First, learn where Lean puts
the brackets nobody writes. The Prover reads every formula exactly that way.*

## Precedence

From tightest to loosest:

1. Function application, `f x`. So `f x + 1` is `(f x) + 1`, and `f x ^ 2` is
   `(f x) ^ 2`. Write `f (x + 1)` to apply `f` to `x + 1`. With level 2's `square` and
   `am`, `square am a b` is an error. You want `square (am a b)`.
2. `^` (power).
3. `-x` (negation). It is weaker than `^`, so `-x ^ 2` is `-(x ^ 2)`, as on paper.
4. `*` and `/`.
5. `+` and `-`.
6. `=`, `≤`, `<`, then `∧`, `∨`, `→` (next world).

## Associativity

* `+`, `-`, `*` and `/` group to the left: `a - b - c` is `(a - b) - c`, and `a / b * c`
  is `(a / b) * c`.
* `^` groups to the right: `a ^ b ^ c` is `a ^ (b ^ c)`.

## Subtraction in ℕ

`ℕ` has no negatives, so subtraction stops at zero: `3 - 5 = 0`. This **truncated
subtraction** causes more false statements about `ℕ` than anything else. With left
grouping, `3 - 5 + 4` is `(3 - 5) + 4 = 0 + 4`.

## Your task

Answer the questions below. Numbers with no type are natural numbers unless the question
says otherwise. Predict first, then check with, say, `#eval 2 ^ 3 ^ 2`.
-/
namespace L3

def q1 : Fin 2 := sorry
def q2 : Fin 2 := sorry
def q3 : Fin 2 := sorry
def q4 : Fin 4 := sorry
def q5 : Fin 2 := sorry
def q6 : Fin 2 := sorry
def q7 : Fin 2 := sorry
def q8 : Fin 2 := sorry

end L3
