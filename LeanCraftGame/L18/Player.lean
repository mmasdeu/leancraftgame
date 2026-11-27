/-
# Reading a construction: Schröder–Bernstein

*The Prover settled Schröder–Bernstein in seconds: injections `f : α → β` and
`g : β → α` give a bijection between `α` and `β`. Before the Annex files it, Noor wants
someone to read the bijection the proof builds and try it on numbers. No proof to write.*

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

It uses images (level 16), an indexed union (level 15) and `invFun` (level 17).

## How to read it

* `sbAux` is defined **by recursion on n**, with one line for `0` and one for `n + 1`.
  This is *pattern matching*; you'll write some in level 22.
* `sbAux 0` is `univ \ g '' univ`: the points of `α` **not** in the range of `g`. Each
  step then applies `f`, then `g`.
* `sbSet` is the union of all the `sbAux n`.
* On `sbSet`, `sbFun` is `f`. Off `sbSet`, `x` is in the range of `g` (it isn't in
  `sbAux 0`), so `invFun g x` is a `y` with `g y = x`: there `sbFun` undoes `g`.
  `invFun g : α → β` needs `[Nonempty β]` (level 17).

## An example

Take `α = β = ℕ` and `f n = g n = 2 * n`. `g '' univ` is the even numbers, so `sbAux 0`
is the odd numbers. `sbAux 1` is the odd numbers times 4, `sbAux 2` the odd numbers times
16, and so on.

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
