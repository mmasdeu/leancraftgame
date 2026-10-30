
structure Version where
  major : ℕ
  minor : ℕ
  patch : ℕ

def Version.bumpPatch (v : Version) : Version :=
  { v with patch := v.minor + 1 }

def Version.bumpMinor (v : Version) : Version :=
  { v with minor := v.minor + 1 }

def Version.setPatch (v : Version) (p : ℕ) : Version :=
  ⟨v.major, p, v.patch⟩

def Version.newer (a b : Version) : Version :=
  if a.major ≤ b.major ∧ a.minor ≤ b.minor ∧ a.patch ≤ b.patch then b else a

def vPatch : Version := ⟨1, 4, 7⟩
def vMinor : Version := ⟨1, 4, 0⟩
def vSet : Version := ⟨1, 4, 7⟩
def pSet : ℕ := 9
def vA : Version := ⟨1, 5, 0⟩
def vB : Version := ⟨2, 0, 0⟩
