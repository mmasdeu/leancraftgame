/-
# Connectedness

A **separation** of a space consists of two open sets `U,V` which cover `univ`,
are disjoint, and are both nonempty. A preconnected space has no separation:
whenever open `U,V` cover the space and are disjoint, one of them is empty.
For a nonempty whole space this is the usual connectedness condition.

Equivalent intuition: a disconnected space has a nontrivial clopen subset.
Indiscrete spaces and Sierpiński space are connected; discrete spaces with at
least two points are disconnected. Continuous images preserve connectedness.

## Your task

Define `MyConnected` using two open sets, their union, their intersection, and
the conclusion that one set must be empty. Use the pedagogical `MyTopology`.
-/
namespace T13

open LeanCraftGame.Topology

def MyConnected {α : Type*} (τ : MyTopology α) : Prop := sorry

end T13
