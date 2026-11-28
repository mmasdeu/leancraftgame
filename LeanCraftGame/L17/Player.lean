/-
# Images and preimages

*Schröder–Bernstein moves sets back and forth along functions. Before that, Noor wants
the team fluent with the two moves: images and preimages.*

A function `f : α → β` moves sets both ways:

```lean
f '' s      -- the image of s : Set α, a Set β:      {y | ∃ x, x ∈ s ∧ f x = y}
f ⁻¹' t     -- the preimage of t : Set β, a Set α:   {x | f x ∈ t}
Set.range f -- the image of everything:               {y | ∃ x, f x = y}
```

Type `''` as two apostrophes and `⁻¹'` as `\inv'`. The preimage needs no inverse
function: it exists for every `f`. For a sequence `s : ℕ → ℝ` (level 12), `Set.range s`
is the set of its terms.

## Example

Take `f n = 2 * n` on ℕ and `M = {m | m % 3 = 0}`, the multiples of 3:

* `f '' M` is the multiples of 6. So `3 ∉ f '' M`.
* `f ⁻¹' M` is the `n` with `2 n` a multiple of 3: the multiples of 3. So `3 ∈ f ⁻¹' M`.

## Statements about images

The image of a union is the union of the images:

```lean
statement image_union' {α β : Type*} (f : α → β) (s t : Set α) :
    f '' (s ∪ t) = f '' s ∪ f '' t
```

`Type*` means "a type, in any universe". `α` and `β` are implicit; Lean finds them from
`f`. For intersections this fails: `f '' (s ∩ t)` can be smaller than `f '' s ∩ f '' t`
when a point of `s` and a different point of `t` have the same image.

## Your task

1. `squares`: the perfect squares, as the range of `n ↦ n ^ 2`.
2. `evensPre`: the even numbers, as the preimage of `{m | m % 4 = 0}` under `n ↦ 2 * n`.
3. `preimage_inter'`: the preimage of `u ∩ v` under `f : α → β` is the intersection of the
   preimages. Use the binders of `image_union'`: `{α β : Type*} (f : α → β) (u v : Set β)`.
4. A counterexample to `f '' (s ∩ t) = f '' s ∩ f '' t` on ℕ: a function `f₀`, sets `s₀`,
   `t₀` and a point `y₀` in `f₀ '' s₀` and in `f₀ '' t₀`, but not in `f₀ '' (s₀ ∩ t₀)`.
   Use small numbers and sets written as `{a, b}` (level 15).
-/
namespace L17

def squares : Set ℕ := sorry

def evensPre : Set ℕ := sorry

statement preimage_inter' : sorry

def f₀ : ℕ → ℕ := sorry
def s₀ : Set ℕ := sorry
def t₀ : Set ℕ := sorry
def y₀ : ℕ := sorry

end L17
