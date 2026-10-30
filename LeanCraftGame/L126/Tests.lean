/- Hidden test battery for Level Spot the bug: structures. -/
import LeanCraftGame.Referee
import LeanCraftGame.L126.Player

-- the referee's own copies: the colleague's code, and the right answers
namespace L126Ref
structure Version where
  major : ℕ
  minor : ℕ
  patch : ℕ
  deriving DecidableEq

def ofV (v : L126.Version) : Version := ⟨v.major, v.minor, v.patch⟩

def bumpPatch (v : Version) : Version := { v with patch := v.minor + 1 }
def bumpPatchRight (v : Version) : Version := { v with patch := v.patch + 1 }

def bumpMinor (v : Version) : Version := { v with minor := v.minor + 1 }
def bumpMinorRight (v : Version) : Version := { v with minor := v.minor + 1, patch := 0 }

def setPatch (v : Version) (p : ℕ) : Version := ⟨v.major, p, v.patch⟩
def setPatchRight (v : Version) (p : ℕ) : Version := ⟨v.major, v.minor, p⟩

def newer (a b : Version) : Version :=
  if a.major ≤ b.major ∧ a.minor ≤ b.minor ∧ a.patch ≤ b.patch then b else a
def newerRight (a b : Version) : Version :=
  if a.major < b.major ∨ (a.major = b.major ∧ (a.minor < b.minor ∨ (a.minor = b.minor ∧ a.patch ≤ b.patch)))
  then b else a
end L126Ref

#no_sorry L126.vPatch
#no_sorry L126.vMinor
#no_sorry L126.vSet
#no_sorry L126.pSet
#no_sorry L126.vA
#no_sorry L126.vB
#level_start "Spot the bug: structures"

#expect_true "bumpPatch gives the wrong answer on your version" :
  L126Ref.bumpPatch (L126Ref.ofV L126.vPatch) ≠ L126Ref.bumpPatchRight (L126Ref.ofV L126.vPatch)
#expect_true "bumpMinor gives the wrong answer on your version" :
  L126Ref.bumpMinor (L126Ref.ofV L126.vMinor) ≠ L126Ref.bumpMinorRight (L126Ref.ofV L126.vMinor)
#expect_true "setPatch gives the wrong answer on your version and patch number" :
  L126Ref.setPatch (L126Ref.ofV L126.vSet) L126.pSet ≠ L126Ref.setPatchRight (L126Ref.ofV L126.vSet) L126.pSet
#expect_true "newer gives the wrong answer on your two versions" :
  L126Ref.newer (L126Ref.ofV L126.vA) (L126Ref.ofV L126.vB) ≠ L126Ref.newerRight (L126Ref.ofV L126.vA) (L126Ref.ofV L126.vB)

#level_report
