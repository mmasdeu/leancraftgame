/- Hidden test battery for Level 26: Inductive types. -/
import LeanCraftGame.Referee
import LeanCraftGame.L26.Player

namespace L26Ref
open L26.BinTree
/-- Every tree of height at most `h`. -/
def treesH : ℕ → List L26.BinTree
  | 0 => [empty]
  | h + 1 => empty :: ((treesH h).flatMap fun l => (treesH h).map fun r => node l r)
def e : L26.BinTree := empty
def n1 : L26.BinTree := node empty empty
def t3 : L26.BinTree := node n1 n1
def path3 : L26.BinTree := node (node n1 empty) empty
end L26Ref

open L26Ref

#no_sorry L26.size
#no_sorry L26.height
#no_sorry L26.mirror
#no_sorry L26.sumList
#level_start "Inductive types"

#expect_true "size of the empty tree is 0" : L26.size e = 0
#expect_true "a single node has size 1" : L26.size n1 = 1
#expect_true "node (node empty empty) (node empty empty) has size 3" : L26.size t3 = 3
#expect_true "there are 5 trees with 3 nodes (a Catalan number)" :
  ((treesH 3).filter (fun t => decide (L26.size t = 3))).length = 5
#expect_true "a single node has height 1" : L26.height n1 = 1
#expect_true "node (node (node empty empty) empty) empty has height 3" : L26.height path3 = 3
#expect_true "the balanced tree with 3 nodes has height 2" :
  L26.height t3 = 2
#expect_true "mirror swaps at every level, not only at the top" :
  L26.mirror path3 = .node .empty (.node .empty n1)
#expect_true "mirroring twice gives the tree back (every tree of height ≤ 2)" :
  ∀ t ∈ treesH 2, L26.mirror (L26.mirror t) = t
#expect_true "sumList [1, 2, 3] = 6" : L26.sumList [1, 2, 3] = 6
#expect_true "sumList [] = 0" : L26.sumList [] = 0

#level_report
