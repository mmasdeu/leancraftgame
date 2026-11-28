# Welcome to Lean Craft Game

This game teaches you to read and write Lean, the language mathematicians use to put
mathematics on a computer. You don't need to know any Lean, or any programming. This page
takes a few minutes to read, and the **Welcome** tab brings you back to it.

## Your new job

*You've just joined the Annex, a small team that keeps a library of mathematics in Lean.
Next door runs the Prover, an AI that proves or disproves whatever you hand it, in
seconds. It takes every statement literally. So the Annex doesn't need you to prove
things. It needs you to say exactly what you mean.*

* **Noor** runs the Annex and gives you your assignments, one project per world.
* **Sam** is your colleague. Sam's code always compiles and is often wrong. You'll hunt
  Sam's bugs at the end of most worlds.
* **The Prover** never lies about what it proved. It often proves something other than
  what was meant, though, and you'll check its claims.
* **The referee** tests everything you write.

What you build keeps coming back. The mean you define on day one turns up in the AM-GM
inequality, the sequences of the Logic world come back as filters in Topology, and your
hand-built Gaussian integers later become one of Mathlib's rings.

## What is Lean?

Lean is a programming language and a tool for doing mathematics. You write mathematics
precisely, and Lean checks it, like a proofreader that never gets tired. Its library,
Mathlib, covers most of undergraduate mathematics and a lot more.

Here's some Lean:

```lean
-- A definition gives a name to something.
def am (a b : ℝ) : ℝ := (a + b) / 2

-- A theorem is a claim with a proof.
theorem two_mul_le_add_sq (a b : ℝ) : 2 * a * b ≤ a ^ 2 + b ^ 2 := by
  nlinarith [sq_nonneg (a - b)]
```

You don't need to understand it yet. Each piece is explained when you first need it.

## Statements, not proofs

Computers are now good at proofs. The hard part left is saying what you mean, and reading
what others wrote. Lean will accept a statement that doesn't say what you intended:

```lean
theorem sq_le_sq' (a b : ℝ) (h : a ≤ b) : a ^ 2 ≤ b ^ 2 := …
```

This is valid Lean, and it's false: `-2 ≤ 1`, but `4 > 1`. It's missing the hypothesis
`0 ≤ a`. Lean checks that a statement makes sense, not that it matches its name.

So you never write a proof here. Instead you:

* write a statement or a definition,
* read some Lean and say what it means, or
* give an example, or a counterexample to someone's claim.

The referee does the proving. It tries to prove or disprove dozens of facts about your
work. A ❌ always means it found a real proof that you're wrong, and it shows you the
counterexample. A ❓ means it couldn't decide, and never counts against you.

## How a level works

1. Read the lesson on the left.
2. **Predict.** Many levels first ask whether a few statements should be true or false.
   Answer, then lock in your answers. You can't change them later. Knowing what a
   definition should say before you test it is the habit this game trains.
3. Fill in the editor. Replace each `sorry` (Lean's placeholder for "not written yet")
   with your definition. In a reading level, click your answers under the lesson
   instead, and they're written into the code for you.
4. Press **Run tests**. Results appear on the right: ✅ passed, ❌ failed, ❓ undecided.
   Answers to reading questions are checked instantly.
   A test tagged **false:** checks that its statement is false, so a ✅ there means your
   definition makes it false, as it should.
5. Most tests are hidden (🔒) until they fail. Don't wait for them. Ask yourself which
   inputs could break your definition.
6. A run stops at the first ❌. The ▶ next to a test runs just that test.
7. Hints unlock as you fail: after two runs with a ❌ (one in the first world), a failing
   test offers a first hint, usually a question. Each further failure unlocks the next
   step, and the last one gives the answer.
8. When every test passes on the same code, the level is cleared and every test is
   shown. A ❓ never counts against you, but the level only clears once every test is ✅,
   so try a simpler way to write your answer. If you edit your code, old results turn grey.

Run the tests as often as you like. Mistakes cost nothing. A cleared level earns up to
three stars: one for clearing it, one for not opening a hint, and one for getting every
prediction right (or, without predictions, for never failing a run).

## Five things about reading Lean

* **Spelling counts.** `Nat` is a type. `nat` is nothing.
* **To apply a function,** write its name, a space and its input: `double 4`, not
  `double(4)`. Brackets only group: `double (2 + 3)`.
* **Comments** start with `--`. Lean ignores them.
* **Errors** are marked in the editor and listed below it. Click one to jump there. Fix
  the first one first, since the others often follow from it.
* **`=` is a statement,** not an assignment. `n % 2 = 0` says that `n` is even. It can
  be true or false.

## Typing symbols

To type `∀`, `∃`, `→`, `∧` or `≤`, write a backslash and a name: `\forall` gives `∀`,
`\to` gives `→`. If the symbol doesn't appear right away, press space. The
**∀ Symbols** button at the top right lists them all and has a short typing drill.

## The road ahead

Each world is one project of the Annex. Some objects keep coming back: the AM-GM
inequality, convergent sequences, primes, the Gaussian integers, `ℤ/nℤ`, linear maps on
`ℝ²`, and Sierpiński space. A tag above each lesson says what kind of exercise it is:
Write, Read, Construct (build an example), Refute (find a counterexample), Repair (fix
Sam's code) or Audit (check whether a statement says what it claims).

1. **Getting Started:** your first day. Read a Lean file, write your first definitions.
2. **Basics:** put AM-GM in the library. How Lean parses, reading a theorem, stating
   theorems, making them general.
3. **Logic:** bounds, monotone functions, convergence; `∀ ∃ ¬ ∧ ∨ ↔` and the order of
   quantifiers. In one level you write the tests yourself.
4. **Sets and Functions:** sets, images, injective and surjective maps, and the
   Schröder–Bernstein construction.
5. **Number Theory:** primes, irrational roots, recursion, and the Prover's first
   announcement.
6. **Discrete Mathematics:** counting with `Finset`, sums, trees.
7. **Structures:** points, Sam's home-made groups, the Gaussian integers.
8. **Hierarchies:** classes and instances, morphisms, subgroups and friends.
9. **Groups and Rings:** Mathlib's groups, `ZMod n`, permutations, ideals, polynomials.
10. **Linear Algebra:** linear maps, subspaces, eigenvectors, matrices.
11. **Topology:** filters, metric and topological spaces, compactness.
12. **Differential Calculus:** derivatives in one and several variables.
13. **Integration:** integrals and measures.

At the end, the Prover announces a one-line proof of Goldbach's conjecture. Your last job
is to find out what it really proved.

## Good to know

* Your code and progress are saved in your browser. The **Report a problem** button only
  opens a prefilled GitHub page, which you choose whether to send.
* The game counts, anonymously, how often each level is run and cleared, so we can see
  which levels are too hard. Only the level number is sent (through GoatCounter: no
  cookies, nothing personal, never your code). Untick the box at the bottom of this page
  to turn it off.
* Some tests take a few seconds, the hardest up to a minute, because the referee really
  is searching for proofs. **Stop** cancels a run.
* The levels are meant to be played in order, but you can open any of them from the menu.
