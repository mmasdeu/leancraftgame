/-
# Reading a Lean file

*Your first morning at the Annex. Noor hands you a short file: "The Prover proves whatever
we write down, so we must write the right thing. That starts with reading." It defines
`am`, the arithmetic mean, which the team needs for AM-GM.*

You won't write proofs here: a hidden *referee* does that. Your job is to read Lean and to
write what you mean.

## A first file

The numbers on the left are line numbers, not part of the file.

```lean
 1  import Mathlib.Tactic
 2
 3  variable (a b : ℝ)
 4
 5  -- The arithmetic mean of two real numbers.
 6  def am (x y : ℝ) : ℝ := (x + y) / 2
 7
 8  #check am
 9  #eval (7 + 2) / 2
10
11  theorem am_comm : am a b = am b a := by
12    unfold am; ring
13
14  example : am 2 4 = 3 := by
15    norm_num [am]
16
17  theorem am_le_max : am a b ≤ max a b := by
18    sorry
```

* `import` loads a library, here part of Mathlib, Lean's library of mathematics. Every
  file starts with its imports.
* `variable (a b : ℝ)` says that below, `a` and `b` are reals. Every theorem that mentions
  them takes them as arguments.
* `--` starts a **comment**. Lean ignores it.
* `def` makes a definition. `am (x y : ℝ) : ℝ` reads "`am` takes two reals `x` and `y`
  and returns a real". The value comes after `:=`.
* `ℝ` is the reals and `ℕ` the natural numbers. Type them as `\R` and `\N`, and `≤` as
  `\le`. `max a b` is the larger of `a` and `b`.
* `#check e` shows the type of `e`, not its value. A function taking two reals to a real
  has type `ℝ → ℝ → ℝ`.
* `#eval e` computes `e`. A number with no type is taken in `ℕ`, where division rounds
  down.
* `theorem name : statement := proof` states, proves and names a fact for later use. The
  proof comes after `by`, written with *tactics*: commands that build the proof. You
  won't write any.
* `example` is a theorem with no name. Lean checks it, then forgets it.
* `sorry` stands in for a missing proof. Lean accepts the file with a warning, but nothing
  is proved.

## Your task

Answer the questions below the lesson. Clicking a choice writes it into the code:
`def q1 : Fin 4 := 2` means choice (2) of question 1, and a true/false question takes
`true` or `false` (lowercase). **Run tests** checks your answers. You can also type
`#eval` or `#check` in the editor to try things.
-/
namespace L1

def q1 : Fin 4 := sorry
def q2 : Fin 4 := sorry
def q3 : Fin 4 := sorry
def q4 : Bool := sorry
def q5 : Fin 3 := sorry
def q6 : Bool := sorry

end L1
