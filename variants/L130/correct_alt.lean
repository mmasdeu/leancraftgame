structure Score where
  pts : ℕ
  penalty : ℕ
  deriving DecidableEq

def Score.value (s : Score) : ℤ := (s.pts : ℤ) - (s.penalty : ℤ)

instance ordScore : Ord Score where
  compare a b :=
    if a.value < b.value then Ordering.lt
    else if b.value < a.value then Ordering.gt
    else compare a.pts b.pts

instance maxScore : Max Score where
  max a b := if compare b a = Ordering.gt then b else a

instance minScore : Min Score where
  min a b := if compare b a = Ordering.lt then b else a

def best : List Score → Score
  | [] => ⟨0, 0⟩
  | a :: rest => rest.foldl max a
