/-
# Generic statements

*Noor reads your AM-GM statements and asks: "Why only `ℝ`? Half of these hold in every
ring, or every ordered type." A Mathlib theorem is stated once, for every type where it
makes sense, and then serves `ℤ`, `ℚ`, `ℝ` and the rest.*

In Mathlib it looks like this:

```lean
variable {R : Type*} [CommRing R]

theorem sub_mul_add (a b : R) : (a - b) * (a + b) = a ^ 2 - b ^ 2 := by ring
```

* `{R : Type*}`: `R` is a **type**, any type, given implicitly (Lean reads it off `a`
  and `b`). `Type*` means "a type in any universe"; you can read it as "a type".
* `[CommRing R]`: an **instance argument**, the assumption "`R` is a commutative ring".
  It is what makes `+`, `-`, `*`, `0`, `1` and `^` available on `R`, with their laws.

The same statement then applies to `ℤ`, `ℚ`, `ℝ`, `ℤ/nℤ`, polynomials… Other common
classes:

| Class | Gives | Example |
|---|---|---|
| `[CommRing R]` | `+ - * 0 1` with the ring laws | `ℤ`, `ℝ` |
| `[PartialOrder α]` | `≤`, reflexive, transitive, antisymmetric | sets under `⊆` |
| `[LinearOrder α]` | a partial order where any two elements compare; also `min`, `max` | `ℝ` |
| `[Lattice α]` | `⊓` (inf, meet) and `⊔` (sup, join) | sets with `∩`, `∪` |
| `[MetricSpace X]` | `dist x y` with the metric axioms | `ℝ`, `ℝ²` |

## Choosing the class

The class must be strong enough for the statement to **make sense**, and no stronger
than needed, or the theorem says less than it could. The `am` of level 2 divides by 2,
so it needs a **field**: with `[CommRing K]` Lean cannot find a division on `K`, while

```lean
def am {K : Type*} [Field K] (a b : K) : K := (a + b) / 2
```

works for `ℚ` and `ℝ` alike. In the same way, `max a b` only exists in a **linear**
order: with `[PartialOrder α]` a statement about `max` does not even typecheck (Lean
cannot find `Max α`), while with `[LinearOrder α]` it does.

In this game, write the type and the class inside each statement, as in
`statement foo {R : Type*} [CommRing R] (a b : R) : …`. (A `variable` line would turn
the statement into a family of statements, one for each `R`.)

## Your task

1. `sq_sub_sq'`: in every commutative ring, `(a + b) * (a - b) = a ^ 2 - b ^ 2`.
2. `absorb`: in every lattice, `x ⊓ (x ⊔ y) = x` (type `⊓` as `\inf`, `⊔` as `\sup`).
3. `max_comm'`: in every linear order, `max a b = max b a`.
4. `dist_triangle'`: in every metric space, `dist x z ≤ dist x y + dist y z`.

Make the type and the class implicit or instance arguments, and the elements explicit,
as Mathlib does: a user should be able to write `sq_sub_sq' 3 2` for integers.
-/
namespace L6

statement sq_sub_sq' : sorry

statement absorb : sorry

statement max_comm' : sorry

statement dist_triangle' : sorry

end L6
