/-
# Making choices

## Several inputs

Put several inputs in parentheses. Inputs of the same type can share one pair:

```lean
def add3 (a b c : Nat) : Nat := a + b + c
```

You call it by listing the inputs in order: `add3 1 2 3` is `6`.

## `if … then … else …`

```lean
def biggest (a b : Nat) : Nat :=
  if a ≤ b then b else a
```

If the condition holds, the result is the `then` part; otherwise it is the
`else` part. Both parts are required and must have the same type.

## Conditions

`a = b` equal · `a ≠ b` different · `a < b` less · `a ≤ b` less or equal ·
`a > b` greater · `a ≥ b` greater or equal.

`≤`, `≥` and `≠` are not on your keyboard. In the editor, type `\le`,
`\ge`, `\ne` and then a space. You can also write `<=` and `>=`.
Typing `∀` and friends: click **Symbols** at the top right of the page. It lists every symbol with the keys to type it, and has typing practice.

Note that `=` is not an instruction to store a value, as in many programming
languages: it is a statement, "is equal to".

## Your task

`biggest` is already written, so you can read it. Define the other three
functions in the same style.
-/
namespace L6

-- the larger of two numbers (already done)
def biggest (a b : Nat) : Nat :=
  if a ≤ b then b else a

-- the smaller of two numbers           (smallest 3 8 is 3)
def smallest (a b : Nat) : Nat := sorry

-- the distance between two numbers, whichever is larger   (gap 10 4 is 6, gap 4 10 is 6)
def gap (a b : Nat) : Nat := sorry

-- 0 for the input 0, and 1 for any other input   (zeroOrOne 0 is 0, zeroOrOne 9 is 1)
def zeroOrOne (n : Nat) : Nat := sorry

end L6
