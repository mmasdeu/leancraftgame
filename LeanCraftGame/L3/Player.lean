/-
# How Lean parses

MIL's first calculations (§2.1) are chains of rewrites such as
`a * b * c = b * (a * c)`. To read them you must know where Lean puts the brackets that
nobody writes. Lean follows the usual conventions, with a few surprises.

## Precedence: which operation binds tighter

From tightest to loosest:

1. **function application**: `f x`. So `f x + 1` is `(f x) + 1`, and `f x ^ 2` is
   `(f x) ^ 2`. To apply `f` to `x + 1`, write `f (x + 1)`.
2. `^` (power).
3. `-x` (negation): **weaker than `^`**, so `-x ^ 2` is `-(x ^ 2)`, as on paper.
4. `*` and `/`.
5. `+` and `-`.
6. `=`, `≤`, `<`, then `∧`, `∨`, `→` (next world).

## Associativity: brackets in a row

* `+`, `-`, `*` and `/` group **to the left**: `a - b - c` is `(a - b) - c`, and
  `a / b * c` is `(a / b) * c`.
* `^` groups **to the right**: `a ^ b ^ c` is `a ^ (b ^ c)`.

## Subtraction in ℕ

Natural numbers have no negatives, so subtraction in `ℕ` stops at zero: `3 - 5 = 0`.
This *truncated subtraction* is the most common source of false statements about `ℕ`.
Combined with left associativity, it means that `3 - 5 + 4` is `(3 - 5) + 4 = 0 + 4`.

## Your task

Answer the questions below the lesson. Numbers with no type are natural numbers, except
where the question says otherwise. You can check an answer by typing, say,
`#eval 2 ^ 3 ^ 2` in the editor, but try to predict it first.
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
