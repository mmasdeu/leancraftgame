# The story of Lean Craft Game

This file is the story bible: the setting, the cast, the arc of the worlds and the rules for
writing a lesson. Every lesson follows it. The game is self-contained: lessons never refer
to a book or course ("this chapter follows …", section numbers); they refer to earlier
*levels*.

## The setting

You have just joined **the Annex**, a small team that keeps a Lean library of mathematics.
The team works beside **the Prover**, an AI that settles whatever statement it is handed,
in seconds, and always literally. Proofs have become cheap. What is scarce is saying the
right thing: a statement that compiles can still be false, vacuous, or about something
else, and the Prover will happily prove *that*.

* **Noor** runs the Annex and hands out the assignments. Calm, precise, fond of asking
  "and what should happen at zero?".
* **Sam** is a colleague who types faster than they think. Sam's code compiles, and is wrong
  in an instructive way. Sam is never mocked: every bug of Sam's is one the player could make.
* **The Prover** is the AI. It never lies about *what* it proved; it is often proving
  something other than what was meant. Its announcements ("The AI proved …!") are audits.
* **The referee** is the Annex's test bench: it runs the hidden tests on your work. A ❌
  comes with evidence, a ❓ is never held against you.

Use the names, never pronouns, for Noor and Sam (or *they*). Keep the cast in the
background: a lesson is about mathematics and Lean, the story frames it.

## The arc

Each world is one project of the Annex. Objects built early come back later, and a lesson
says so ("the `am` you wrote in level 2", "Sam's sequences from the Logic world").

| World | Project | Recurring objects introduced or reused |
|---|---|---|
| Getting Started | First day: reading a file, the AM-GM quantities | `am`, `square` |
| Basics | Stating AM-GM and its friends for the library | `am`, AM-GM, `abs`, `min`/`max` |
| Logic | Bounds, monotone functions, convergence | `FnUb`, `ConvergesTo`, explicit sequences |
| Sets and Functions | Sets, images, injectivity; the Schröder–Bernstein construction | `FnUb` as a set statement, images of sequences |
| Elementary Number Theory | Primes and divisibility; the Prover's "infinitude of primes" | primes, `√2`, recursion |
| Discrete Mathematics | Counting with `Finset`, sums, trees | divisors, sums of primes |
| Structures | Points, home-made groups, the Gaussian integers | `Point`, `GaussInt` |
| Hierarchies | Classes, morphisms, sub-objects | `GaussInt` and `Point` as instances |
| Groups and Rings | Mathlib's groups, `ZMod n`, ideals, polynomials | `ZMod n`, Gaussian integers again |
| Linear Algebra | Linear maps on `ℝ²`, subspaces, matrices | `Point`-like vectors, rotations |
| Topology | Filters, metric and topological spaces; sequences revisited | `ConvergesTo` becomes `Tendsto`, Sierpiński space |
| Differential Calculus | Derivatives | functions from the Logic world |
| Integration and Measure Theory | Integrals and measures | |
| Final Audit | The Prover announces Goldbach | everything |

## Writing a lesson

1. **Open with a hook**, in italics, two to four sentences: who asks for what, and why it
   matters, tied to the previous level when possible. The first level of a world opens the
   project.
2. **Teach one thing**, with a worked example. Prefer an example built from an object the
   player met earlier (state it in full: never depend on an earlier level's answer).
3. **End with "Your task"**, short and concrete.
4. **Every level has a trap.** Name it in the story if you can ("Sam forgot the zero").
5. Plain, warm, exact. No exclamation marks outside a Prover announcement; no jokes that cost
   precision; no references to outside courses or books.
