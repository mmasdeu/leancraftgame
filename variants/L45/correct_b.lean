structure Point where
  x : ℕ
  y : ℕ

structure Rectangle where
  width : ℕ
  height : ℕ

namespace Point

def add : Point → Point → Point
  | ⟨a, b⟩, ⟨c, d⟩ => ⟨a + c, b + d⟩

def dist2 (p q : Point) : ℕ :=
  (max p.x q.x - min p.x q.x)^2 + (if p.y ≤ q.y then (q.y - p.y)^2 else (p.y - q.y)^2)

end Point

namespace Rectangle

def area : Rectangle → ℕ
  | ⟨w, h⟩ => w * h

def grow (r : Rectangle) (k : ℕ) : Rectangle :=
  { width := r.width + 2 * k, height := r.height + 2 * k }

def topRight (r : Rectangle) : Point := Point.mk r.width r.height

end Rectangle
