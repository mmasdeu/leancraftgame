/-

# Closed sets, interior and closure

A set is closed when its complement is open. The **interior** of `s` is the
union of all open subsets of `s`; the **closure** is the intersection of all
closed supersets. These are dual descriptions.

A set is dense when its closure is `univ`, and clopen when both it and its
complement are open. Interior and closure are monotone; closure is idempotent.
The finite examples make these ideas concrete: in Sierpiński space `{false}` is
closed because its complement `{true}` is open.

**ACT III — TOPOLOGY**

The earlier acts gave you the vocabulary needed here: functions and quantifiers from
**sequences**, inverse images and local approximation from **limits**, and packaged
axioms from **structures**. This level turns those tools toward general spaces.

## The road from here

Generate a topology from basic opens and connect inverse images to continuity.


## Your tasks

Define `MyClosed`, `MyInterior`, `MyClosure`, `Dense`, and `Clopen` using the
quantifications described above. Use `MyClosed` when defining `MyClosure`.
-/
namespace T6

open LeanCraftGame.Topology

def MyClosed {α : Type*} (τ : MyTopology α) (s : Set α) : Prop := sorry

def MyInterior {α : Type*} (τ : MyTopology α) (s : Set α) : Set α := sorry

def MyClosure {α : Type*} (τ : MyTopology α) (s : Set α) : Set α := sorry

def Dense {α : Type*} (τ : MyTopology α) (s : Set α) : Prop := sorry

def Clopen {α : Type*} (τ : MyTopology α) (s : Set α) : Prop := sorry

end T6
