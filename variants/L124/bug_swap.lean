structure Point where
  x : ℕ
  y : ℕ

def moveRight (p : Point) (n : ℕ) : Point := { p with x := p.x + n }

structure Settings where
  volume : ℕ := 5
  brightness : ℕ := 7
  muted : ℕ := 0

def quiet : Settings := { volume := 0 }

structure Point3 extends Point where
  z : ℕ

def raise (q : Point3) (h : ℕ) : Point3 := { q with z := q.z + h }

structure Pair (α : Type) where
  fst : α
  snd : α

def Pair.swap {α : Type} (p : Pair α) : Pair α := ⟨p.fst, p.fst⟩

def Pair.dup {α : Type} (a : α) : Pair α := ⟨a, a⟩
