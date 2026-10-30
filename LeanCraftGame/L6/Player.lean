/-
# True or false?

So far our functions returned numbers. A mathematician's definitions are
mostly *statements*: "n is even", "u is bounded". In Lean a statement has
type `Prop` (a *proposition*). It is either true or false.

```lean
def IsBig (n : Nat) : Prop := 100 ≤ n
```

`IsBig 150` is a true statement and `IsBig 5` is a false one. A function
returning `Prop` is called a **predicate**.

* There is no `if`, `true` or `false` here. The body is simply the statement.
* `a = b` is the statement "a equals b". `a % 2 = 0` says "the remainder of
  `a` divided by 2 is 0".
* Predicates are usually named with a capital letter, like `IsBig`.

## Off-by-one

Is it `<` or `≤`? `10 < n` is false for `n = 10`, `10 ≤ n` is true.
The tests will check the boundary values.

## Your task

`IsBig` is done. Define `IsEven`, `IsSmall` (below 10) and `GoesInto`
(`GoesInto a b` says that `a` divides `b` exactly).
-/
namespace L7

-- n is at least 100 (already done)
def IsBig (n : Nat) : Prop := 100 ≤ n

-- n is even                        (IsEven 10 is true, IsEven 7 is false)
def IsEven (n : Nat) : Prop := sorry

-- n is smaller than 10             (IsSmall 3 is true, IsSmall 10 is false)
def IsSmall (n : Nat) : Prop := sorry

-- dividing b by a leaves no remainder   (GoesInto 3 12 is true, GoesInto 5 12 is false)
def GoesInto (a b : Nat) : Prop := sorry

end L7
