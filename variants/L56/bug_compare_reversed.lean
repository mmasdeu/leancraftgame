structure Score where
  pts : ℕ
  penalty : ℕ
  deriving DecidableEq

def Score.value (s : Score) : ℤ := (s.pts : ℤ) - s.penalty

instance ordScore : Ord Score where
  compare a b := (compare b.value a.value).then (compare b.pts a.pts)

instance maxScore : Max Score where
  max a b := if compare a b = Ordering.lt then b else a

instance minScore : Min Score where
  min a b := if compare a b = Ordering.gt then b else a

def best : List Score → Score
  | [] => ⟨0, 0⟩
  | [a] => a
  | a :: b :: rest => max a (best (b :: rest))
