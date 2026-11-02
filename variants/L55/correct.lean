class Size (α : Type) where
  size : α → ℕ

instance sizeNat : Size ℕ where
  size n := n

instance sizeString : Size String where
  size s := s.length

class Weighted (α : Type) extends Size α where
  weight : α → ℕ

instance weightedNat : Weighted ℕ where
  size n := n
  weight n := 2 * n

instance weightedString : Weighted String where
  size s := s.length
  weight _ := 10

structure Pair (α : Type) where
  fst : α
  snd : α
  deriving DecidableEq

instance addPair {α : Type} [Add α] : Add (Pair α) where
  add p q := ⟨p.fst + q.fst, p.snd + q.snd⟩

instance sizePair {α : Type} [Size α] : Size (Pair α) where
  size p := Size.size p.fst + Size.size p.snd

instance sizeList {α : Type} [Size α] : Size (List α) where
  size xs := (xs.map Size.size).sum

def largest {α : Type} [Size α] (xs : List α) : ℕ :=
  (xs.map Size.size).foldr max 0

def heavy {α : Type} [Weighted α] (a : α) : ℕ :=
  Size.size a + Weighted.weight a
