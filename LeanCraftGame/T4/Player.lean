/-

# The definition of a topology

A topology on `α` consists of a predicate saying which sets are open, together
with three conditions:

* `univ` is open;
* the union of **any** family of open sets is open;
* the intersection of **two** open sets is open.

I write `⋃₀ C` for the union of an unindexed family `C : Set (Set α)`.
The empty set needs no separate axiom: it is `⋃₀ ∅`. Binary intersections give
all nonempty finite intersections by induction; taking `univ` handles the empty
finite intersection.

An *arbitrary intersection* axiom would be different and too strong. A basis,
introduced in T7, need not itself be closed under intersections: pairs of basis
sets merely have to be refined by basis sets around each point.

**ACT III — TOPOLOGY**

The earlier acts gave you the vocabulary needed here: functions and quantifiers from
**sequences**, inverse images and local approximation from **limits**, and packaged
axioms from **structures**. This level turns those tools toward general spaces.

## The road from here

Test the topology axioms on reusable examples, starting with Sierpiński space.


## Your task

Complete the three axiom fields. Keep the predicates general: they must work
for every carrier and every family, not just for a favourite finite example.
-/
namespace T4

structure MyTopology (α : Type*) where
  IsOpen : Set α → Prop
  isOpen_univ : sorry
  isOpen_sUnion : sorry
  isOpen_inter : sorry

end T4
