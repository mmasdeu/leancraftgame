/-
# Making choices

Many functions are defined by cases. In Lean:

```lean
def sign (n : Nat) : Nat := if n = 0 then 0 else 1
```

The condition can be any decidable statement about numbers: `n = 0`,
`a ≤ b`, `n % 2 = 0` (`%` is the remainder: `17 % 5 = 2`). Conditions can
be nested: `if … then … else if … then … else …`.

A definition by cases is only as good as its cases. Two questions to ask
every time:

* **Does every input fall into the intended case?** Look at the boundary:
  `0`, `1`, equal inputs.
* **Is each branch well defined there?** Remember that `a - b = 0` when
  `b > a`: the distance `|a - b|` needs a case split on ℕ.

The **Collatz map** sends an even `n` to `n/2` and an odd `n` to `3n + 1`.
Iterating it from any start seems to reach `1` (`6 → 3 → 10 → 5 → 16 → 8 →
4 → 2 → 1`). Nobody knows whether this always happens: we will meet this
open problem again at the end of the game.

## Your task

Define `collatz`, `gap` and `rootCount`. For `rootCount`, recall the
discriminant `b² - 4c`, and do not subtract on ℕ: compare instead.
-/

namespace L3

-- the Collatz map: halve an even number, send an odd number n to 3n + 1
def collatz (n : Nat) : Nat := sorry

-- the distance |a - b| between two natural numbers
def gap (a b : Nat) : Nat := sorry

-- the number of real roots of x² + b·x + c (0, 1 or 2), counted without multiplicity
def rootCount (b c : Nat) : Nat := sorry

end L3
