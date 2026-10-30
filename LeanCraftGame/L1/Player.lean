/-
# Naming things

Welcome! In this game you write **definitions** in Lean, a language for
mathematics. You never write proofs: a hidden *referee* tests your definitions
and reports what it finds. The first levels teach the syntax step by step.

## What is a definition?

A definition gives a name to a value:

```lean
def answer : Nat := 42
```

Read it piece by piece:

* `def` says "I am defining something".
* `answer` is the name. You choose it.
* After the colon `:` comes the **type**, the kind of thing being defined.
  `Nat` means *natural numbers*: 0, 1, 2, 3, …
* `:=` means "is defined to be".
* `42` is the value.

One more type: `String` is text in double quotes, like `"hello"`.

## Using names

A definition can use the names defined before it. If `answer` is 42, then
`answer + 1` is 43. That is what names are for.

## `sorry` and comments

* `sorry` is a placeholder meaning "to be filled in". Replace every `sorry`
  with a value. The tests only run once no `sorry` is left.
* A line starting with `--` is a *comment*: Lean ignores it.

## How to play

Edit the code on the left, then press **Run tests** (or `Ctrl`+`Enter`). The
report on the right shows ✅ for a passed test and ❌ for a failed one.
If you are stuck, a **Hint** appears under a failed test after a failed run.

## Your task

Give the three definitions below their right values.
-/
namespace L1

-- The answer to life, the universe and everything.
def answer : Nat := sorry

-- The name of this programming language, as text.
def language : String := sorry

-- One more than the answer. Use `answer` in the definition.
def successor : Nat := sorry

end L1
