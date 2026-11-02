structure Point where
  x : ℕ
  y : ℕ

def moveRight (p : Point) (n : ℕ) : Point := ⟨p.x + n, p.y⟩

structure Settings where
  volume : ℕ := 5
  brightness : ℕ := 7
  muted : ℕ := 0

def quiet : Settings := { volume := 0, brightness := 7, muted := 0 }

structure Point3 extends Point where
  z : ℕ

def raise (q : Point3) (h : ℕ) : Point3 := { toPoint := q.toPoint, z := q.z + h }

structure Pair (α : Type) where
  fst : α
  snd : α

def Pair.swap {α : Type} (p : Pair α) : Pair α := { fst := p.snd, snd := p.fst }

def Pair.dup {α : Type} (a : α) : Pair α := { fst := a, snd := a }
