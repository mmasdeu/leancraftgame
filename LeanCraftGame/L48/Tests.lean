/- Hidden test battery for Level Spot the bug: structures. -/
import LeanCraftGame.Referee
import LeanCraftGame.L48.Player

-- the referee's own copies: the colleague's code, and the right answers
namespace L48Ref
structure Version where
  major : ℕ
  minor : ℕ
  patch : ℕ
  deriving DecidableEq

def ofV (v : L48.Version) : Version := ⟨v.major, v.minor, v.patch⟩

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
end L48Ref

#no_sorry L48.vPatch
#no_sorry L48.vMinor
#no_sorry L48.vSet
#no_sorry L48.pSet
#no_sorry L48.vA
#no_sorry L48.vB
#level_start "Spot the bug: structures"

#expect_true "bumpPatch gives the wrong answer on your version" :
  L48Ref.bumpPatch (L48Ref.ofV L48.vPatch) ≠ L48Ref.bumpPatchRight (L48Ref.ofV L48.vPatch)
#expect_true "bumpMinor gives the wrong answer on your version" :
  L48Ref.bumpMinor (L48Ref.ofV L48.vMinor) ≠ L48Ref.bumpMinorRight (L48Ref.ofV L48.vMinor)
#expect_true "setPatch gives the wrong answer on your version and patch number" :
  L48Ref.setPatch (L48Ref.ofV L48.vSet) L48.pSet ≠ L48Ref.setPatchRight (L48Ref.ofV L48.vSet) L48.pSet
#expect_true "newer gives the wrong answer on your two versions" :
  L48Ref.newer (L48Ref.ofV L48.vA) (L48Ref.ofV L48.vB) ≠ L48Ref.newerRight (L48Ref.ofV L48.vA) (L48Ref.ofV L48.vB)

#level_report
