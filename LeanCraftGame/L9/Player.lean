/-
# Or and not

* `p ∨ q` means "p **or** q": true when at least one of them is true,
  possibly both. Type it `\or` (or write `\/`).
* `¬ p` means "**not** p". Type it `\not` (or `\neg`), or write `Not p`.

```lean
def Odd' (n : Nat) : Prop := ¬ (n % 2 = 0)
```

## Which operator comes first?

From the strongest to the weakest binding: `¬`, then `∧`, then `∨`, then `→`
(next level). So

* `¬ p ∧ q` means `(¬ p) ∧ q`, not `¬ (p ∧ q)`;
* `p ∨ q ∧ r` means `p ∨ (q ∧ r)`.

When in doubt, add parentheses. They never hurt.

## Your task

A cinema gives free tickets to children under 5 and to people aged 65 or
more. Define `FreeTicket`, then `PaysFull` using `FreeTicket`. Then define
`NotTiny`: a number that is neither 0 nor 1.
-/
namespace L9

-- under 5 or at least 65          (FreeTicket 3 is true, FreeTicket 30 is false)
def FreeTicket (age : Nat) : Prop := sorry

-- everybody else pays full price: the opposite of FreeTicket
def PaysFull (age : Nat) : Prop := sorry

-- n is neither 0 nor 1            (NotTiny 5 is true, NotTiny 1 is false)
def NotTiny (n : Nat) : Prop := sorry

end L9
