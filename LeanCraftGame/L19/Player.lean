/-
# Spot the bug: sets

*Sam pushed three things about sets. Each compiles, and each is wrong. Noor asks you to
refute them with counterexamples, then repair the first.*

## 1. The multiples of `k`

```lean
def multiplesOf (k : ℕ) : Set ℕ := {n | k % n = 0}
```

This is meant as the `multiples` of level 15. (`k % n` is the remainder of `k` divided by
`n`.) Give `k₁` and a multiple `n₁` of `k₁` that is **not** in `multiplesOf k₁`.

## 2. Preimage of the image

Sam's lemma, for every `f : ℕ → ℕ` and `s : Set ℕ`:

```lean
f ⁻¹' (f '' s) = s
```

`s ⊆ f ⁻¹' (f '' s)` always holds. Give `f₁`, `s₁` and a point `x₁` in
`f₁ ⁻¹' (f₁ '' s₁)` but not in `s₁`. (For which `f` is the lemma true? Level 17 has the
word.)

## 3. Swapping `⋃` and `⋂`

For a family `A i j` with two indices, Sam claims

```lean
⋃ i, ⋂ j, A i j = ⋂ j, ⋃ i, A i j
```

The left side is `∃ i, ∀ j, x ∈ A i j`, the right side `∀ j, ∃ i, x ∈ A i j`: quantifier
order again (level 10). Give `A : Bool → Bool → Set ℕ` and a point `x₂` on the right but
not on the left. You may use `if i = j then … else …`.

## 4. Repair

Write `multiplesOfFixed k`, the multiples of `k`, correctly.
-/
namespace L19

def k₁ : ℕ := sorry
def n₁ : ℕ := sorry

def f₁ : ℕ → ℕ := sorry
def s₁ : Set ℕ := sorry
def x₁ : ℕ := sorry

def A : Bool → Bool → Set ℕ := sorry
def x₂ : ℕ := sorry

def multiplesOfFixed (k : ℕ) : Set ℕ := sorry

end L19
