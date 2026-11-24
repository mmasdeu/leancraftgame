/-
# Bijective need not mean homeomorphic

A homeomorphism needs a bijection whose map **and inverse** are continuous.
Bijectivity alone says nothing about open sets.

On `Bool`, use the discrete topology on the domain and the indiscrete topology
on the codomain. The identity is continuous in this direction: an indiscrete
open set is either `∅` or `univ`, whose inverse images are open everywhere.
Its inverse is again the identity, but now `{true}` is open in the discrete
codomain while its inverse image is not open in the indiscrete domain.

A homeomorphism also has an inverse function, two inverse laws, and continuity
in both directions. Homeomorphism is an equivalence relation: the identity works,
inverses swap the directions, and composition preserves all the fields. Open and
closed sets correspond under either direction because continuity uses preimages.

## Your tasks

First complete `MyHomeomorph`, whose data contains both maps and whose axioms
contain both inverse laws and both continuity conditions. Then supply the two
topologies and the map that realise the counterexample. The intended spaces are
`discrete Bool`, `indiscrete Bool`, and `id`.
-/
namespace T9

open LeanCraftGame.Topology

structure MyHomeomorph {α β : Type*} (τs : MyTopology α) (τt : MyTopology β) where
  toFun : α → β
  invFun : β → α
  left_inv : sorry
  right_inv : sorry
  continuous_toFun : sorry
  continuous_invFun : sorry

def sourceTopology : MyTopology Bool := sorry

def targetTopology : MyTopology Bool := sorry

def bijection : Bool → Bool := sorry

end T9
