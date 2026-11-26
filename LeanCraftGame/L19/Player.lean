/-
# Spot the bug: sets

A colleague wrote three things about sets. Each one compiles, and each one is wrong.
Your job is to **prove them wrong** with counterexamples, then repair the first one.

## 1. The multiples of `k`

```lean
def multiplesOf (k : ℕ) : Set ℕ := {n | k % n = 0}
```

meant as "the multiples of `k`". (Recall that `k % n` is the remainder of `k` divided
by `n`.) Give `k₁` and `n₁` with `n₁` a multiple of `k₁` that is **not** in
`multiplesOf k₁`.

## 2. Preimage of the image

The colleague's lemma, for every `f : ℕ → ℕ` and `s : Set ℕ`:

```lean
f ⁻¹' (f '' s) = s
```

The inclusion `s ⊆ f ⁻¹' (f '' s)` always holds. Give `f₁`, `s₁` and a point `x₁` that is
in `f₁ ⁻¹' (f₁ '' s₁)` but not in `s₁`. (For which kind of `f` is the lemma true?)

## 3. Swapping `⋃` and `⋂`

For a family `A i j` of sets with two indices, the colleague claims

```lean
⋃ i, ⋂ j, A i j = ⋂ j, ⋃ i, A i j
```

Read both sides: `x ∈ ⋃ i, ⋂ j, A i j` is `∃ i, ∀ j, x ∈ A i j`, and the right-hand side
is `∀ j, ∃ i, x ∈ A i j`. It is the order of quantifiers again (Logic world). Give a
family `A : Bool → Bool → Set ℕ` (the indices are `true` and `false`) and a point `x₂` on
the right-hand side but not on the left. You may use `if i = j then … else …`.

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
