/-
# Images and preimages

A function `f : α → β` moves sets around in two directions (MIL §4.2):

```lean
f '' s      -- the image of s : Set α, a Set β:      {y | ∃ x, x ∈ s ∧ f x = y}
f ⁻¹' t     -- the preimage of t : Set β, a Set α:   {x | f x ∈ t}
Set.range f -- the image of everything:               {y | ∃ x, f x = y}
```

Type `''` as two apostrophes, and `⁻¹'` as `\inv'`. Read `f '' s` as "f of s" and
`f ⁻¹' t` as "f inverse of t". The preimage needs no inverse function: it is defined
for every `f`, injective or not.

## A worked example

Take `f n = 2 * n` on ℕ and the multiples of 4, `M = {m | m % 4 = 0}`:

* `f '' M` doubles every multiple of 4: it is the multiples of 8. `4 ∈ f '' M`? No.
* `f ⁻¹' M` is the set of `n` with `2 n` a multiple of 4: the even numbers. `2 ∈ f ⁻¹' M`.

Image and preimage are easy to confuse, and they are rarely the same set.

## Statements about images

MIL proves facts such as `f '' (s ∪ t) = f '' s ∪ f '' t`. As statements, for every
pair of types and every function:

```lean
statement image_union' {α β : Type*} (f : α → β) (s t : Set α) :
    f '' (s ∪ t) = f '' s ∪ f '' t
```

`Type*` means "a type, in any universe". `α` and `β` are implicit: Lean finds them from
`f`. The same is **not** true for intersections: `f '' (s ∩ t)` can be strictly smaller
than `f '' s ∩ f '' t`, when two different points of `s` and `t` have the same image.

## Your task

1. `squares`: the set of perfect squares, as the range of `n ↦ n ^ 2`.
2. `evensPre`: the even numbers, as the preimage of `{m | m % 4 = 0}` under `n ↦ 2 * n`.
3. `preimage_inter'`: state that the preimage of `u ∩ v` under `f : α → β` is the
   intersection of the preimages (for all types `α`, `β`, all `f` and all `u v : Set β`).
4. A counterexample to `f '' (s ∩ t) = f '' s ∩ f '' t` on ℕ: a function `f₀`, two sets
   `s₀`, `t₀` and a point `y₀` that is in `f₀ '' s₀` and in `f₀ '' t₀`, but not in
   `f₀ '' (s₀ ∩ t₀)`. Use small numbers and sets written as `{a, b}`.
-/
namespace L16

def squares : Set ℕ := sorry

def evensPre : Set ℕ := sorry

statement preimage_inter' : sorry

def f₀ : ℕ → ℕ := sorry
def s₀ : Set ℕ := sorry
def t₀ : Set ℕ := sorry
def y₀ : ℕ := sorry

end L16
