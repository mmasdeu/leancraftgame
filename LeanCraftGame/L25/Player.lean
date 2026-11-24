/-
# Injective and surjective

A map `f : ℕ → ℕ` is

* **injective** when distinct inputs have distinct outputs; the usable form
  is the contrapositive, `f a = f b → a = b`;
* **surjective** when every value is hit: `∀ m, ∃ n, f n = m`;
* **bijective** when it is both.

On a finite set, injective ⇔ surjective (the pigeonhole principle). On `ℕ`
they are independent: `n ↦ 2n` is injective and not surjective, `n ↦ n / 2`
is surjective and not injective. Hilbert's hotel lives in that gap, and so
does the notion of an infinite set (Dedekind: a set is infinite when it
admits an injective map to itself that is not surjective).

Bijections are what "the same set" means; homeomorphisms, in the Topology
world, are bijections that respect more structure.

## Your task

Define `Injective`, `Surjective` and `Bijective`. The referee tests them on
shifts, doublings, halvings and swaps.
-/
import Mathlib.Tactic

namespace L25

def Injective (f : ℕ → ℕ) : Prop :=
  sorry

def Surjective (f : ℕ → ℕ) : Prop :=
  sorry

def Bijective (f : ℕ → ℕ) : Prop :=
  sorry

end L25
