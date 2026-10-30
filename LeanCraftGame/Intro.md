# Welcome to Lean Craft Game, {name}!

In this game you learn to write **definitions** in Lean, a language for mathematics.
You do not need to know anything about Lean, or to have read a line of code before.
This page explains what you are about to do. It takes a few minutes to read, and you
can come back to it at any time with the **Welcome** tab.

## What is Lean?

Lean is a programming language, and also a tool for doing mathematics on a computer.
You write mathematics in a precise language, and Lean *checks* it, like a very strict
proofreader that never gets tired. Mathematicians use it to state definitions and
theorems, and to make sure that proofs are correct.

A piece of Lean looks like this:

```lean
-- A definition: it gives a name to something.
def double (n : Nat) : Nat := 2 * n

-- A theorem: a claim, together with a proof of it.
theorem double_four : double 4 = 8 := by decide
```

Do not worry about the details: every line you will need is explained when it first
appears. What matters now is that there are two kinds of things in Lean.

* A **definition** says what something *means*: `double` is the function that
  multiplies by 2.
* A **theorem** says that something is *true*, and proves it.

## Definitions, not proofs

Writing proofs is hard, and computers have become good at it. What stays hard, and
matters just as much, is **saying what you mean**. Lean will happily accept a
definition that does not mean what you intended:

```lean
def IsEven (n : Nat) : Prop := n % 2 = 1
```

This is valid Lean. But it says that `n` leaves remainder 1 when divided by 2, so it
defines the *odd* numbers, and not the even ones. Lean does not complain. It checks
that your code is well formed, not that it means what its name says. Everything built
on a wrong definition is then wrong too, and nothing warns you.

This is the skill the game trains. You never write a proof. Instead:

* You write a definition.
* A hidden *referee*, an automated prover, tests it. It asks questions such as
  "is 10 even?" and "is 7 even?", and tries to prove or refute each answer from your
  definition.
* When your definition gets a question wrong, the referee shows you which one.

And the other way round: every world ends with a level where you **read** a
colleague's definition, which compiles but is wrong, and *you* find the input that
proves it.

A ❌ always comes with evidence: it means the referee found a real Lean proof of the
opposite of what you meant. The game never tells you that you are wrong without a
counterexample.

## How a level works

1. Read the **lesson** on the left. It explains the new syntax, with an example.
2. **Predict.** In many levels, before your first run, the report asks you a few
   questions: should *this* statement be true or false? Answer from the lesson, then
   lock in your answers. They are marked right or wrong straight away, and they cannot
   be changed. Predicting first is the habit the game is about: knowing what a
   definition *should* say before you see what yours does.
3. Complete the code in the **editor**. Some definitions are already written, to be
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
7. **Hints unlock as you go.** After two failed runs (one in the Basics world), a failing
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

Every world ends with a **Spot the bug** level: a colleague's definitions compile
but are wrong, and you prove it with a counterexample.

* **Basics:** values, functions, choices and recursion.
* **Statements:** true or false, and the connectives *and*, *or*, *not*.
* **Numbers:** integers, casts, and what happens when you divide by zero.
* **Quantifiers:** *for all*, *there exists*, *if … then …*, and why their order
  matters.
* **Predicate:** your first real definition, of a sequence going to infinity. Then
  you swap roles with the referee: you write the tests, and it tries to slip wrong
  definitions past them.
* **Library:** sets, the definitions that Mathlib already has, and generality.
* **Analysis:** the limit of a sequence of real numbers.
* **Structure:** bundling data and axioms; finding the mistake in a colleague's
  definition of a group.
* **Faithfulness:** an AI claims to have proved Goldbach's conjecture in one line.
  What did it really prove?

## Good to know

* Your code and progress are saved in your browser, so you can close the page and
  come back. Nothing is sent anywhere, and the **Report a problem** button at the top
  only opens a prefilled page on GitHub, which you send yourself.
* Some tests take several seconds, and the hardest up to a minute, because the referee
  really is searching for proofs. A spinner shows which tests are running, and
  **Stop** cancels the run.
* The levels are meant to be done in order, but you can open any of them from the
  menu at the top.
