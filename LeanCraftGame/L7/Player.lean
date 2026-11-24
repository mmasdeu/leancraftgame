/-
# Statements

`collatz 5` is a number. `collatz 5 = 16` is a **statement**: something
that is true or false. Statements have their own type, `Prop`, and a
*predicate* is a function that returns a statement:

```lean
def IsEven (n : Nat) : Prop := n % 2 = 0
```

`IsEven 10` is the statement `10 % 2 = 0`, which happens to be true;
`IsEven 7` is a statement too, a false one. Writing `IsEven 7` is not an
error: false statements are perfectly good mathematical objects (you need
them to state that something is *not* the case).

The difference between a function and a statement about it matters: `def
f (n : Nat) : Nat := …` computes, `def P (n : Nat) : Prop := …` asserts.
The referee proves or refutes your statements; here it can always decide
them by computing both sides.

## Boundary cases

Definitions are judged at the boundary. With `Divides a b := b % a = 0`,
what is `Divides 0 0`? In Lean, `b % 0 = b`, so `Divides 0 b` says `b = 0`.
This agrees with the mathematical convention: `a ∣ b` means `b = a·k` for
some `k`, and `0 = 0·k`. Every number divides `0`.

## Your task

Define `Divides`, `IsPythagorean` and `IsFixed` (the Collatz map has a
fixed point: which one?).
-/

namespace L7

-- the Collatz map (from the Foundations world)
def collatz (n : Nat) : Nat := if n % 2 = 0 then n / 2 else 3 * n + 1

-- n is even (already done)
def IsEven (n : Nat) : Prop := n % 2 = 0

-- a divides b: b is a multiple of a (write it with %, not with ∣)
def Divides (a b : Nat) : Prop := sorry

-- (a, b, c) is a Pythagorean triple: a² + b² = c²
def IsPythagorean (a b c : Nat) : Prop := sorry

-- n is a fixed point of the Collatz map
def IsFixed (n : Nat) : Prop := sorry

end L7
