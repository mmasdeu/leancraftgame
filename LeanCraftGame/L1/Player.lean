/-
# Reading a Lean file

This game follows the book *Mathematics in Lean* (MIL), one world per chapter. You
will never write a proof: a hidden *referee* does the proving. Your job is the part a
proof checker cannot do for you: **reading** Lean and **writing** what you mean.

## A first file

Here is a short file in the style of MIL's first chapter. The numbers on the left are
line numbers, not part of the file.

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

* `import` loads a library. MIL files start with `import Mathlib.Tactic` or a part
  of Mathlib.
* `variable (a b : ℝ)` says: in what follows, `a` and `b` are real numbers. Every
  theorem that mentions them gets them as arguments, without repeating the line.
* `--` starts a **comment**, which Lean ignores.
* `def` gives a name to a value. `am (x y : ℝ) : ℝ` reads "`am` takes two reals `x`
  and `y`, and returns a real". The value comes after `:=`.
* `#check e` asks Lean for the **type** of `e`. The answer appears in the editor, not
  in the file. For a function of two reals it prints `am (x y : ℝ) : ℝ`, which is the
  same as `ℝ → ℝ → ℝ`.
* `#eval e` **computes** `e`. When a number has no type, Lean takes `ℕ`, the natural
  numbers, and division in `ℕ` rounds down.
* `theorem name : statement := proof` states and proves a fact, and names it so that
  it can be used later. After `by` comes the proof, written with *tactics*.
* `example` is a theorem without a name: it is checked, then forgotten.
* `sorry` stands in for a missing proof. Lean accepts the file, with a warning, but
  nothing has been proved.

## Your task

Answer the questions below the lesson by clicking a choice. Your answers are written
into the code (`def q1 : Fin 4 := 2` means you picked choice (2) of question 1), and
**Run tests** checks them. You may also type Lean in the editor to try things out:
`#eval` and `#check` print their answers next to the line.
-/
namespace L1

def q1 : Fin 4 := sorry
def q2 : Fin 4 := sorry
def q3 : Fin 4 := sorry
def q4 : Bool := sorry
def q5 : Fin 3 := sorry
def q6 : Bool := sorry

end L1
