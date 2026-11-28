/-
# Generic statements

*Noor reads your AM-GM statements: "Why only `ℝ`? Half of these hold in every ring, or
every ordered type." Mathlib states a theorem once, for every type where it makes sense.*

```lean
variable {R : Type*} [CommRing R]

theorem add_sq' (a b : R) : (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2 := by ring
```

* `{R : Type*}`: `R` is any type, given implicitly (Lean reads it off `a` and `b`). Read
  `Type*` as "a type".
* `[CommRing R]`: an instance argument, the assumption "`R` is a commutative ring". It
  makes `+`, `-`, `*`, `0`, `1` and `^` available on `R`, with their laws.

The theorem then applies to `ℤ`, `ℚ` (the rationals), `ℝ` and many more. Other common
classes:

| Class | Gives | Example |
|---|---|---|
| `[CommRing R]` | `+ - * 0 1` with the ring laws | `ℤ`, `ℝ` |
| `[PartialOrder α]` | `≤`, reflexive, transitive, antisymmetric | sets under `⊆` |
| `[LinearOrder α]` | a partial order where any two elements compare; also `min`, `max` | `ℝ` |
| `[Lattice α]` | a partial order with `⊓` (greatest lower bound) and `⊔` (least upper bound) | sets with `∩`, `∪` |
| `[MetricSpace X]` | a distance `dist x y : ℝ`, symmetric, zero only when `x = y`, with the triangle inequality | `ℝ`, `ℝ²` |

## Choosing the class

Pick a class just strong enough for the statement to make sense. A stronger one makes the
theorem say less. Level 2's `am` was over `ℝ`. To make it generic, note that it divides by
2, so it needs a **field**. With `[CommRing K]` Lean finds no division on `K`, while

```lean
def am {K : Type*} [Field K] (a b : K) : K := (a + b) / 2
```

works for `ℚ` and `ℝ`. If Lean says it can't find an instance (`failed to synthesize`),
your class doesn't provide an operation you used.

In this game, write the type and the class inside each statement:
`statement foo {R : Type*} [CommRing R] (a b : R) : …`, not a `variable` line.

## Your task

1. `sq_sub_sq'`: in every commutative ring, `(a + b) * (a - b) = a ^ 2 - b ^ 2`.
2. `absorb`: in every lattice, `x ⊓ (x ⊔ y) = x` (type `⊓` as `\inf`, `⊔` as `\sup`).
3. `max_comm'`: in every linear order, `max a b = max b a`.
4. `dist_triangle'`: in every metric space, `dist x z ≤ dist x y + dist y z`.

As in Mathlib, make the type implicit, the class an instance argument, and the elements
explicit. A user should be able to write `sq_sub_sq' 3 2` for integers.
-/
namespace L6

statement sq_sub_sq' : sorry

statement absorb : sorry

statement max_comm' : sorry

statement dist_triangle' : sorry

end L6
