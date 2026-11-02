structure Vec where
  x : ℤ
  y : ℤ
  deriving DecidableEq

instance addVec : Add Vec := ⟨fun u v => Vec.mk (u.x + v.x) (u.y + v.y)⟩

instance zeroVec : Zero Vec := ⟨Vec.mk 0 0⟩

instance negVec : Neg Vec := ⟨fun v => Vec.mk (0 - v.x) (0 - v.y)⟩

instance subVec : Sub Vec where
  sub u v := ⟨u.x - v.x, u.y - v.y⟩

instance shiftVec : HAdd Vec ℤ Vec where
  hAdd v n := Vec.mk (n + v.x) (n + v.y)
