/-
# Spot the bug: structures

Back to reading a colleague's code, as in the earlier "Spot the bug" levels:
the code compiles, it looks reasonable, and you must prove it wrong with
**counterexamples**. This time the code is full of structures. Good places to
look:

* **`⟨ , , ⟩` and the order of fields.** Is every value in the field it was
  meant for? Compare with the declaration of the structure.
* **`{ v with ... }`.** Does it update the field that its name says, and does
  it use the right field on the right-hand side? Every field it does *not*
  mention is copied unchanged: is that really what should happen?
* **Combining fields.** A comparison that checks the fields one by one may
  not be the comparison that was specified.

A colleague handles software version numbers `major.minor.patch`, such as
`1.4.7`. The first four functions below must do what their comments say; each
one is wrong.

```lean
structure Version where
  major : ℕ
  minor : ℕ
  patch : ℕ

-- next patch release: bumpPatch 1.4.7 is 1.4.8
def Version.bumpPatch (v : Version) : Version :=
  { v with patch := v.minor + 1 }

-- next minor release: the patch number starts again. bumpMinor 1.4.7 is 1.5.0
def Version.bumpMinor (v : Version) : Version :=
  { v with minor := v.minor + 1 }

-- put in a new patch number: setPatch 1.4.7 9 is 1.4.9
def Version.setPatch (v : Version) (p : ℕ) : Version :=
  ⟨v.major, p, v.patch⟩

-- the more recent of two versions: compare the major numbers first, if they
-- are equal the minor numbers, if those are equal the patch numbers.
-- newer 1.5.0 2.0.0 is 2.0.0
def Version.newer (a b : Version) : Version :=
  if a.major ≤ b.major ∧ a.minor ≤ b.minor ∧ a.patch ≤ b.patch then b else a
```

## Your task

For each function, give input values on which it gives the wrong answer. The
referee compares the colleague's answer with the right one on your inputs.
-/
namespace L126

-- The colleague's code, to read (changing it here changes nothing: the
-- referee uses its own copy).
structure Version where
  major : ℕ
  minor : ℕ
  patch : ℕ

def Version.bumpPatch (v : Version) : Version :=
  { v with patch := v.minor + 1 }

def Version.bumpMinor (v : Version) : Version :=
  { v with minor := v.minor + 1 }

def Version.setPatch (v : Version) (p : ℕ) : Version :=
  ⟨v.major, p, v.patch⟩

def Version.newer (a b : Version) : Version :=
  if a.major ≤ b.major ∧ a.minor ≤ b.minor ∧ a.patch ≤ b.patch then b else a

-- A version on which `bumpPatch` is wrong.
def vPatch : Version := sorry

-- A version on which `bumpMinor` is wrong.
def vMinor : Version := sorry

-- A version `vSet` and a patch number `pSet` on which `setPatch` is wrong.
def vSet : Version := sorry
def pSet : ℕ := sorry

-- Two versions on which `newer` is wrong.
def vA : Version := sorry
def vB : Version := sorry

end L126
