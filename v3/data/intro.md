# Welcome to Lean Craft Game

This game teaches you to **read and write Lean**, the language in which mathematicians
now formalise mathematics, by following the book
[*Mathematics in Lean*](https://leanprover-community.github.io/mathematics_in_lean/)
(MIL) chapter by chapter. You do not need to know anything about Lean, or to have read a
line of code before. This page explains what you are about to do. It takes a few minutes
to read, and you can come back to it at any time with the **Welcome** tab.

## What is Lean?

Lean is a programming language, and also a tool for doing mathematics on a computer.
You write mathematics in a precise language, and Lean *checks* it, like a very strict
proofreader that never gets tired. Its library, **Mathlib**, contains a large part of
undergraduate mathematics, and much more.

A piece of Lean looks like this:

```lean
-- A definition: it gives a name to something.
def am (a b : ℝ) : ℝ := (a + b) / 2

-- A theorem: a claim, together with a proof of it.
theorem two_mul_le_add_sq (a b : ℝ) : 2 * a * b ≤ a ^ 2 + b ^ 2 := by
  nlinarith [sq_nonneg (a - b)]
```

Every line you will need is explained when it first appears.

## Statements and definitions, not proofs

Writing proofs is hard, and computers have become good at it. What stays hard, and
matters just as much, is **saying what you mean**, and **reading what others wrote**.
Lean will happily accept a statement that does not mean what you intended:

```lean
theorem sq_le_sq' (a b : ℝ) (h : a ≤ b) : a ^ 2 ≤ b ^ 2 := …
```

This is valid Lean, and it is false: `-2 ≤ 1`, but `4 > 1`. A hypothesis `0 ≤ a` is
missing. Lean checks that the statement is well formed, not that it says what its name
promises.

So in this game **you never write a proof**. Where MIL proves something, you do one of
these instead, and a hidden *referee*, an automated prover, does any proving that is
needed:

* you **write** the statement of a theorem, or a definition it depends on;
* you **read** a Lean statement or definition and say what it means;
* you give a **witness**, or a **counterexample** that breaks a colleague's claim.

The referee then tests your work: it tries to prove or refute dozens of facts about it.
A ❌ always comes with evidence: it means the referee found a real Lean proof of the
opposite of what you meant. The game never tells you that you are wrong without a
counterexample. When the referee cannot decide, you get ❓, which is never held against
you.

## How a level works

1. Read the **lesson** on the left. It explains the new syntax, with an example.
2. **Predict.** In many levels, before your first run, the report asks you a few
   questions: should *this* statement be true or false? Answer from the lesson, then
   lock in your answers. They are marked right or wrong straight away, and they cannot
   be changed. Predicting first is the habit the game is about: knowing what a
   definition *should* say before you see what yours does.
3. Complete the code in the **editor**. In a *reading* level, answer the questions under
   the lesson instead: your choices are written into the code for you. Some definitions are already written, to be
   read as examples. Others contain `sorry`, a placeholder meaning "to be filled in":
   replace each one with your own definition.
4. Press **Run tests**. Each test appears in the report on the right as soon as it is
   done: ✅ means that the definition behaves as expected, ❌ that it does not, and
   ❓ that the referee could not decide.
5. **Most tests are hidden** (🔒). A hidden test shows up when it fails, so you see the
   input that broke your definition, but not the whole list in advance. Do not wait
   for the referee: ask yourself which inputs could break your definition.
6. A run **stops at the first ❌**. The ▶ button next to a test runs only that test,
   which is handy once you have fixed a definition.
7. **Hints unlock as you go.** After two failed runs (one in the Getting Started world), a failing
   test offers the first step of its hint: usually a question. Each further failed run
   unlocks the next step, and the last step gives the answer away. A failed run is one
   with a ❌. A ❓ (the referee could not decide) is not held against you: it does not
   count as a failure and shows no hint.
8. When **every test has passed on the same code**, the level is cleared, every test
   is shown, and the next one unlocks. Edit your code, and the earlier results turn
   grey: they are about the old code.

You can run the tests as often as you like. There is no penalty for a wrong answer,
and mistakes are how this game teaches. A cleared level earns up to three stars: one
for clearing it, one for doing it without opening a hint, and one for predicting every
statement right (or, in a level without predictions, for clearing it without a failed
run). The menu at the top shows your best result.

## Reading Lean: five things to know

* **Spelling counts.** `Nat` is a type, `nat` is nothing at all. Capital letters
  matter, and so does every symbol.
* **Applying a function** means writing its name, a space, then its input:
  `double 4`. There are no brackets and no commas, as in `f(x)`. Brackets only
  group things: `double (2 + 3)`.
* **Comments** start with `--`. Lean ignores them, so they are notes for the reader.
* **Errors:** when Lean cannot make sense of your code, the editor marks the line and
  the message appears under it. Click the message to jump to the place. Read the
  *first* error first: later ones are often consequences of it.
* **Equality is a statement, not an instruction.** `n % 2 = 0` does not store
  anything. It says: "the remainder of `n` divided by 2 is 0", which is true or false.

## Typing mathematical symbols

Lean uses symbols that are not on your keyboard, such as `∀`, `∃`, `→`, `∧` and `≤`.
To type one, write a backslash and its name: `\forall` gives `∀`, and `\to` gives `→`.
Some appear as soon as the name is complete; for the others, press the space bar.

The **∀ Symbols** button, at the top right of the page, opens a table of every symbol
with the keys to type it, and a short typing drill. You can try it right now.

## The road ahead

There is one world per chapter of *Mathematics in Lean*, in the same order, and the
lesson of each level says which section it follows. A few objects come back again and
again: the AM-GM inequality, convergent sequences, the primes, the Gaussian integers,
`ℤ/nℤ`, linear maps on `ℝ²`, and Sierpiński space, the two-point topological space.
Each level is tagged with its kind of exercise: *Write* (a definition or a statement),
*Read* (answer questions about Lean code), *Construct* (build an example), *Refute*
(give a counterexample), *Repair* (fix a colleague's code) or *Audit* (check whether a
formal statement says what it claims). Most worlds end with a **Spot the bug** level.

1. **Getting Started:** reading a Lean file; your first definitions.
2. **Basics:** how Lean parses, reading a theorem's signature, stating theorems, generic
   statements about rings, lattices and metric spaces.
3. **Logic:** `∀`, `∃`, `¬`, `∧`, `∨`, `↔`, the order of quantifiers, convergence of
   sequences; and a level where you write the tests and the referee tries to slip wrong
   definitions past them.
4. **Sets and Functions:** set notation, images and preimages, injective and surjective
   functions, the Schröder–Bernstein construction.
5. **Elementary Number Theory:** divisibility and primes, irrational roots, recursion and
   induction, the infinitude of the primes.
6. **Discrete Mathematics:** `Finset`, big operators and counting, inductive types.
7. **Structures:** defining structures, algebraic structures, the Gaussian integers.
8. **Hierarchies:** classes and instances, reading Mathlib's hierarchy, morphisms,
   sub-objects.
9. **Groups and Rings:** groups, subgroups, `ZMod n`, permutations, ideals, polynomials.
10. **Linear Algebra:** vector spaces and linear maps, subspaces, endomorphisms,
    matrices, bases and dimension.
11. **Topology:** filters, metric spaces, topological spaces, separation and compactness.
12. **Differential Calculus:** derivatives, in one variable and in normed spaces.
13. **Integration and Measure Theory:** integrals and measures.

The game ends with a **final audit**: an AI claims to have proved Goldbach's conjecture
in one line. What did it really prove?

## Good to know

* Your code and progress are saved in your browser, so you can close the page and
  come back. Checking code in the browser is paused for now, while we work out how to use the Lean Playground (the Lean community's public server) fairly. You can still read every lesson here. To play, download the app from the Lean Craft Game website: it checks your code on your own computer. The **Report a problem** button at the top only opens a prefilled page on GitHub, which you send yourself.
* To learn which levels are too hard or too easy, the game counts, anonymously, how often
  each level is run and cleared. Only the level number is sent (through GoatCounter: no
  cookies, no personal data, never your code). It is on by default; untick the box at the
  bottom of this page to switch it off.
* Some tests take several seconds, and the hardest up to a minute, because the referee
  really is searching for proofs. A spinner shows which tests are running, and
  **Stop** cancels the run.
* The levels are meant to be done in order, but you can open any of them from the
  menu at the top.
