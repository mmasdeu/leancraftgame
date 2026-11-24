/-
# Relations and partitions

Quotients are everywhere in topology (the circle is `ℝ` modulo `ℤ`, a
projective space is a sphere modulo `±1`), and a quotient starts with an
**equivalence relation**: a relation `R` that is

* reflexive: `R x x` for every `x`,
* symmetric: `R x y` implies `R y x`,
* transitive: `R x y` and `R y z` imply `R x z`.

The **class** of `x` is the set of the `y` with `R x y`. The classes of an
equivalence relation form a **partition**: every point lies in exactly one
class. Conversely every function `f` has *fibres* `f⁻¹(c)`, which form a
partition, and the relation "`f x = f y`" (the *kernel* of `f`) is the
equivalence relation whose classes are the fibres. Every equivalence
relation is the kernel of the map to its set of classes: this is why a
quotient is the "universal" way to identify points.

On a finite set we take relations with Boolean values, `R : Fin n → Fin n →
Bool`, so that the referee can evaluate them: `R x y = true` means "`x` is
related to `y`". For example
`fun x y => x.val % 2 == y.val % 2` relates numbers of the same parity.

## Your task

1. Define `IsEquivalence R` (the three properties).
2. Define `cls R x`, the class of `x`.
3. Define `kernel f`, the relation "same value under `f`".
4. Construct `twoBlocks`, an equivalence relation on `{0, 1, 2, 3}` with
   exactly two classes, of sizes `1` and `3`.
-/
import LeanCraftGame.Lib.Topology

namespace L60

-- reflexive, symmetric and transitive
def IsEquivalence {n : Nat} (R : Fin n → Fin n → Bool) : Prop := sorry

-- the class of x: the points y related to x
def cls {n : Nat} (R : Fin n → Fin n → Bool) (x : Fin n) : Finset (Fin n) := sorry

-- x and y are related when f x = f y
def kernel {m n : Nat} (f : Fin m → Fin n) : Fin m → Fin m → Bool := sorry

-- an equivalence relation on {0, 1, 2, 3} with a class of size 1 and a class of size 3
def twoBlocks : Fin 4 → Fin 4 → Bool := sorry

end L60
