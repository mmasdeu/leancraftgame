/-
# Standard examples: Sierpiński space

For a point `p`, the **particular-point topology** declares a set open when it
is empty or contains `p`. Sierpiński space is this topology on `Bool` at `true`.

Thus its open sets are exactly `∅`, `{true}`, and `univ`. The singleton
`{false}` is **not** open. This tiny space will distinguish separation and
convergence properties later.

The shared module already provides `LeanCraftGame.Topology.MyTopology` and
`particularPoint`; you may use them or write the structure explicitly.

## Your task

Construct `sierpinskiSpace : MyTopology Bool` with precisely those open sets.
-/
namespace T5

open LeanCraftGame.Topology

def sierpinskiSpace : MyTopology Bool := sorry

end T5
