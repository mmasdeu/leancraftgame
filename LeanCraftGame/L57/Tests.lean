/- Hidden test battery for Level Spot the bug: classes. -/
import LeanCraftGame.Referee
import LeanCraftGame.L57.Player

namespace L57Ref
class Size (α : Type) where
  size : α → ℕ
instance : Size ℕ where
  size n := n
structure Mark where
  v : ℕ
  deriving DecidableEq
instance : Add Mark where
  add a b := ⟨(a.v + b.v) / 2⟩
instance {α : Type} [Size α] : Size (List α) where
  size xs := match xs with
    | [] => 0
    | a :: _ => Size.size a
structure Version where
  major : ℕ
  minor : ℕ
instance : Ord Version where
  compare a b := (compare a.major b.major).then (compare a.minor b.minor)
instance : Max Version where
  max a b := if a.minor ≤ b.minor then b else a
def Version.ofPair (p : ℕ × ℕ) : Version := ⟨p.1, p.2⟩
end L57Ref

#no_sorry L57.assocA
#no_sorry L57.assocB
#no_sorry L57.assocC
#no_sorry L57.badList
#no_sorry L57.version1
#no_sorry L57.version2
#level_start "Spot the bug: classes"

#expect_true "adding your marks as (a + b) + c and as a + (b + c) gives different results" unfolding L57.assocA L57.assocB L57.assocC :
  (L57Ref.Mark.mk L57.assocA + L57Ref.Mark.mk L57.assocB) + L57Ref.Mark.mk L57.assocC
    ≠ L57Ref.Mark.mk L57.assocA + (L57Ref.Mark.mk L57.assocB + L57Ref.Mark.mk L57.assocC)
#expect_true "the colleague's Size of your list is not the sum of its entries" unfolding L57.badList :
  L57Ref.Size.size L57.badList ≠ L57.badList.sum
#expect_true "max of your two versions is lower than one of them, according to compare" unfolding L57.version1 L57.version2 :
  compare (max (L57Ref.Version.ofPair L57.version1) (L57Ref.Version.ofPair L57.version2)) (L57Ref.Version.ofPair L57.version1) = Ordering.lt
  ∨ compare (max (L57Ref.Version.ofPair L57.version1) (L57Ref.Version.ofPair L57.version2)) (L57Ref.Version.ofPair L57.version2) = Ordering.lt

#level_report
