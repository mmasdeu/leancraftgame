/-
# How Lean parses

*A new project: Noor wants AM-GM and its friends stated for the library. First, learn
where Lean puts the brackets nobody writes. The Prover reads every formula exactly that
way.*

## Precedence

From tightest to loosest:

1. Function application, `f x`. So `f x * y` is `(f x) * y`. Write `f (x + 1)` to apply
   `f` to `x + 1`. With level 2's `square` and `am`, `square am a b` is an error. You
   want `square (am a b)`.
2. `^` (power).
3. `-x` (negation). It is weaker than `^`, so `-a ^ 4` is `-(a ^ 4)`, as on paper.
4. `*` and `/`.
5. `+` and `-`.
6. `=`, `≤`, `<`, then `∧`, `∨`, `→` (next world).

## Associativity

* `+`, `-`, `*` and `/` group to the left: `a + b - c` is `(a + b) - c`, and `a / b / c`
  is `(a / b) / c`.
* `^` groups to the right: `a ^ b ^ c` is `a ^ (b ^ c)`.

## Subtraction in ℕ

`ℕ` has no negatives, so subtraction stops at zero: `2 - 7 = 0`. This **truncated
subtraction** causes more false statements about `ℕ` than anything else. The integers
`ℤ` (type `\Z`) do have negatives: there, `2 - 7 = -5`.

## Your task

Answer the questions below. Numbers are natural numbers unless the question says
otherwise. Work each one out first, then check it with `#eval` if you like.
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
