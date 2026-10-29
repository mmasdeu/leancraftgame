/-
# For all

A *sequence* of natural numbers is a function `u : Nat → Nat`: for every
position `n`, it gives a value `u n`. Think of the list `u 0, u 1, u 2, …`

* `Nat → Nat` is the type of functions from `Nat` to `Nat`.
  Type the arrow `→` as `\to`, or write `->`.
* `fun n => n + 1` is a function written without a name: the input `n`
  goes to `n + 1`. The referee uses such functions to test your definitions:
  `(fun n => n % 3) 7` is `1`.

## The quantifier `∀`

`∀ n, P n` means "for **every** natural number `n`, the statement `P n` holds".
Type `∀` as `\forall`, or write `forall`.

```lean
def AllBig (u : Nat → Nat) : Prop := ∀ n, 10 ≤ u n
```

This says that *every* term of the sequence `u` is at least 10. The `n` after
`∀` is a name you choose for the position. The comma separates the quantifier
from the statement.

Typing `∀` and friends: click **Symbols** at the top right of the page. It lists every symbol with the keys to type it, and has typing practice.

## Your task

`AllBig` is done. Define `AlwaysBelow u B` (every term is at most `B`) and
`AllEven u` (every term is even).
-/
namespace L10

-- every term is at least 10 (already done)
def AllBig (u : Nat → Nat) : Prop := ∀ n, 10 ≤ u n

-- every term is at most B
def AlwaysBelow (u : Nat → Nat) (B : Nat) : Prop := sorry

-- every term is even
def AllEven (u : Nat → Nat) : Prop := sorry

end L10
