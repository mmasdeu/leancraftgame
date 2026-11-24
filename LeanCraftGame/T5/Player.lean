/-
# Standard examples of topologies

I will reuse five examples throughout this world:

* **discrete**: every set is open;
* **indiscrete**: only `∅` and `univ` are open;
* **Sierpiński**: the particular-point topology on `Bool` at `true`;
* **particular point**: a set is open when empty or containing the chosen point;
* **cofinite**: a set is open when empty or its complement is finite.

The shared module `LeanCraftGame.Topology` proves these constructions once. The
finite module also enumerates the discrete, indiscrete and Sierpiński opens for
finite exhaustive checks. Cofinite facts about infinite sets require proofs,
not finite enumeration.

## Your tasks

Construct the five named spaces. `particularPointAtZero` is on `Nat` at `0`;
`cofiniteOnNat` uses the cofinite topology on `Nat`.
-/
namespace T5

open LeanCraftGame.Topology

def discreteOnNat : MyTopology Nat := sorry

def indiscreteOnNat : MyTopology Nat := sorry

def sierpinskiSpace : MyTopology Bool := sorry

def particularPointAtZero : MyTopology Nat := sorry

def cofiniteOnNat : MyTopology Nat := sorry

end T5
