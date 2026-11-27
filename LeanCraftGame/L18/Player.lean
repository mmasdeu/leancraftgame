/-
# Reading a construction: Schröder–Bernstein

*The Prover settled Schröder–Bernstein in seconds: if there are injections `f : α → β`
and `g : β → α`, then there is a bijection between `α` and `β`. Before the Annex files it,
Noor wants someone to read the bijection the proof builds, and to say what it does on
actual numbers. No proof to write: read, then answer.*

```lean
variable {α β : Type*} [Nonempty β]
variable (f : α → β) (g : β → α)

def sbAux : ℕ → Set α
  | 0 => univ \ g '' univ
  | n + 1 => g '' (f '' sbAux n)

def sbSet :=
  ⋃ n, sbAux f g n

def sbFun (x : α) : β :=
  if x ∈ sbSet f g then f x else invFun g x
```

Everything here is from the last three levels: images (level 16), an indexed union
(level 15), `invFun` (level 17).

## How to read it

* `sbAux` is defined **by recursion on n**, by cases: one line for `0`, one for `n + 1`.
  The `| 0 => …` and `| n + 1 => …` lines are *pattern matching* (you will write such
  definitions yourself in level 22).
* `sbAux 0` is `univ \ g '' univ`: the points of `α` that are **not** in the range of
  `g`. Then each step applies `f` and then `g`.
* `sbSet` collects all the `sbAux n`: an indexed union.
* `sbFun` uses `if … then … else`. On `sbSet` it is `f`. Off `sbSet`, the point `x` is in
  the range of `g` (it is not in `sbAux 0`), so `invFun g x` is a `y` with `g y = x`: there
  `sbFun` undoes `g`. `invFun g : α → β` needs `[Nonempty β]` (level 17).

## An example to compute

Take `α = β = ℕ` and `f n = g n = 2 * n`. Then `g '' univ` is the even numbers, so
`sbAux 0` is the odd numbers. `sbAux 1 = g '' (f '' sbAux 0)` is the odd numbers times 4,
`sbAux 2` the odd numbers times 16, and so on.

## Your task

Answer the questions under the lesson. For the last two, write a number: the value of
`sbFun f g` at `12` and at `8`, for this `f` and `g`.
-/
namespace L18

def q1 : Fin 3 := sorry
def q2 : Fin 3 := sorry
def q3 : Fin 3 := sorry
def q4 : Bool := sorry
def q5 : Bool := sorry
def q6 : Bool := sorry
def q7 : Bool := sorry

-- the value of `sbFun f g 12`, for f n = g n = 2 n
def sbFun12 : ℕ := sorry
-- the value of `sbFun f g 8`, for f n = g n = 2 n
def sbFun8 : ℕ := sorry

end L18
