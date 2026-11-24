/-
# Bijective need not mean homeomorphic

A homeomorphism needs a bijection whose map **and inverse** are continuous.
Bijectivity alone says nothing about open sets.

On `Bool`, use the discrete topology on the domain and the indiscrete topology
on the codomain. The identity is continuous in this direction: an indiscrete
open set is either `∅` or `univ`, whose inverse images are open everywhere.
Its inverse is again the identity, but now `{true}` is open in the discrete
codomain while its inverse image is not open in the indiscrete domain.

## Your task

Supply the two topologies and the map that realise this counterexample.
The intended answer is `discrete Bool`, `indiscrete Bool`, and `id`.
-/
namespace T9

open LeanCraftGame.Topology

def sourceTopology : MyTopology Bool := sorry

def targetTopology : MyTopology Bool := sorry

def bijection : Bool → Bool := sorry

end T9
