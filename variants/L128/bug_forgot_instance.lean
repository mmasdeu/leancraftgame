structure Vec where
  x : ℤ
  y : ℤ
  deriving DecidableEq

instance addVec : Add Vec where
  add u v := ⟨u.x + v.x, u.y + v.y⟩

instance zeroVec : Zero Vec where
  zero := ⟨0, 0⟩

instance negVec : Neg Vec where
  neg v := ⟨-v.x, -v.y⟩

instance subVec : Sub Vec where
  sub u v := u + -v

def shiftVec : Vec → ℤ → Vec := fun v n => ⟨v.x + n, v.y + n⟩
