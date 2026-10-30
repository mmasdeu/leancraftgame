/-
# Challenge: counting

Time to turn word problems into cases and recursion. Nothing new to learn,
but you must decide the base cases yourself, and the tests are hidden.

* **Several inputs.** A function may match on two inputs at once:

```lean
def both : Nat → Nat → Nat
  | 0, _ => 1
  | n + 1, k => both n k + k
```

  (`match n, k with` followed by the same `|` lines works too.) Lines are
  tried from the top, so put the special cases first.
* A recursive call may be on **any** smaller input, and a function may call
  itself several times. `if … then … else …` can be used inside a case.

## Your task

* `stairs n`: in how many ways can you climb `n` steps, taking 1 or 2 steps
  at a time? (`stairs 3` is 3: 1+1+1, 1+2, 2+1.)
* `choose n k`: in how many ways can you pick `k` of `n` different objects?
  The first object is either in your pick (then pick `k - 1` of the other
  `n - 1`) or it is not (pick `k` of the other `n - 1`). `choose 4 2` is 6.
* `countEven n`: how many even numbers are there among 0, 1, …, n?

Think about the smallest inputs first: what does the story say about 0 steps,
about picking 0 objects, about picking more objects than there are?
-/
namespace L101

-- the number of ways to climb n steps, 1 or 2 at a time   (stairs 3 is 3)
def stairs (n : Nat) : Nat := sorry

-- the number of ways to choose k objects out of n          (choose 4 2 is 6)
def choose (n k : Nat) : Nat := sorry

-- how many even numbers lie among 0, 1, …, n               (countEven 4 is 3)
def countEven (n : Nat) : Nat := sorry

end L101
