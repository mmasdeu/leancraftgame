/- Hidden test battery for Level Spot the bug: classes. -/
import LeanCraftGame.Referee
import LeanCraftGame.L131.Player

namespace L131Ref
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
end L131Ref

#no_sorry L131.assocA
#no_sorry L131.assocB
#no_sorry L131.assocC
#no_sorry L131.badList
#no_sorry L131.version1
#no_sorry L131.version2
#level_start "Spot the bug: classes"

#expect_true "adding your marks as (a + b) + c and as a + (b + c) gives different results" unfolding L131.assocA L131.assocB L131.assocC :
  (L131Ref.Mark.mk L131.assocA + L131Ref.Mark.mk L131.assocB) + L131Ref.Mark.mk L131.assocC
    ≠ L131Ref.Mark.mk L131.assocA + (L131Ref.Mark.mk L131.assocB + L131Ref.Mark.mk L131.assocC)
#expect_true "the colleague's Size of your list is not the sum of its entries" unfolding L131.badList :
  L131Ref.Size.size L131.badList ≠ L131.badList.sum
#expect_true "max of your two versions is lower than one of them, according to compare" unfolding L131.version1 L131.version2 :
  compare (max (L131Ref.Version.ofPair L131.version1) (L131Ref.Version.ofPair L131.version2)) (L131Ref.Version.ofPair L131.version1) = Ordering.lt
  ∨ compare (max (L131Ref.Version.ofPair L131.version1) (L131Ref.Version.ofPair L131.version2)) (L131Ref.Version.ofPair L131.version2) = Ordering.lt

#level_report
