class Size (α : Type) where
  size : α → ℕ

instance sizeNat : Size ℕ where
  size n := n

def bigger {α : Type} [Size α] (a b : α) : Prop := Size.size b < Size.size a

structure Rect where
  w : ℕ
  h : ℕ

instance sizeString : Size String where
  size s := String.length s

instance sizeList : Size (List ℕ) where
  size xs := List.length xs

instance sizeRect : Size Rect where
  size r := Nat.mul r.1 r.2
