/-
# And

Two statements can be combined. `p ∧ q` means "p **and** q": it is true when
both are true.

```lean
def InRange (lo hi n : Nat) : Prop := lo ≤ n ∧ n ≤ hi
```

`InRange 10 20 15` is true. `InRange 10 20 25` is false.

* Type `∧` as `\and` (or write `/\`).
* You cannot write `lo ≤ n ≤ hi` as in school mathematics. Write the two
  comparisons and join them with `∧`.
* A definition may use the ones written above it, as `EvenInRange` below can
  use `InRange`.

Typing `∀` and friends: click **Symbols** at the top right of the page. It lists every symbol with the keys to type it, and has typing practice.

## Your task

`InRange` is done. Define `IsTeen` (13 to 19 inclusive) and `EvenInRange`.
-/
namespace L8

-- lo ≤ n ≤ hi (already done)
def InRange (lo hi n : Nat) : Prop := lo ≤ n ∧ n ≤ hi

-- n is between 13 and 19, both included      (IsTeen 19 is true, IsTeen 20 is false)
def IsTeen (n : Nat) : Prop := sorry

-- n is even and lies between lo and hi        (EvenInRange 1 10 4 is true, EvenInRange 1 10 5 is false)
def EvenInRange (lo hi n : Nat) : Prop := sorry

end L8
