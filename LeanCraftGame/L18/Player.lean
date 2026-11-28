/-
# Reading a construction: Schröder–Bernstein

*The Prover settled Schröder–Bernstein in seconds: injections `f : α → β` and
`g : β → α` give a bijection between `α` and `β`. Before the Annex files it, Noor wants
someone to read the bijection the proof builds and try it on numbers. No proof to write.*

```lean
variable {α β : Type*} [Nonempty β]
variable (f : α → β) (g : β → α)

def sbAux : ℕ → Set α
  | 0 => Set.univ \ g '' Set.univ
  | n + 1 => g '' (f '' sbAux n)

def sbSet :=
  ⋃ n, sbAux f g n

def sbFun (x : α) : β :=
  if x ∈ sbSet f g then f x else Function.invFun g x
```

It uses images (level 16), an indexed union (level 15) and `invFun` (level 17).

## How to read it

* The `variable` lines (level 1) make `f` and `g` arguments of every definition that uses
  them. So the full names are `sbAux f g n`, `sbSet f g` and `sbFun f g x`.
* A definition with the lines `| 0 => …` and `| n + 1 => …` is **by recursion on n**:
  the first line gives the value at `0`, the second the value at `n + 1` from the value
  at `n`. This is *pattern matching*; you'll write some in level 22.
* `s \ t` is the difference of sets (level 15). After `sbAux 0`, each step applies `f`,
  then `g`. So `sbAux n` comes from `sbAux 0` by applying `g ∘ f` (first `f`, then `g`)
  `n` times.
* `sbSet` is the union of all the `sbAux n`.
* `if c then a else b` is `a` when `c` holds and `b` otherwise. Off `sbSet`, `x` is not
  in `sbAux 0` (which is part of `sbSet`), so `x` is in the range of `g`, and
  `invFun g x` is a `y` with `g y = x`. Since `g` is injective, there is only one such
  `y`: there `sbFun` undoes `g`.

## An example

Take `α = β = ℕ` and `f n = g n = 2 * n`. `g '' Set.univ` is the even numbers, so
`sbAux 0` is the odd numbers. Each step multiplies by 4, so `sbAux n` is the odd numbers
times `4 ^ n`.

## Your task

Answer the questions. For the last two, give the value of `sbFun f g` at `12` and at `8`,
for this `f` and `g`.
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
