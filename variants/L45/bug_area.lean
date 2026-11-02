structure Point where
  x : ℕ
  y : ℕ

structure Rectangle where
  width : ℕ
  height : ℕ

namespace Point

def add (p q : Point) : Point := ⟨p.x + q.x, p.y + q.y⟩

def dist2 (p q : Point) : ℕ := (p.x - q.x)^2 + (q.x - p.x)^2 + (p.y - q.y)^2 + (q.y - p.y)^2

end Point

namespace Rectangle

def area (r : Rectangle) : ℕ := r.width + r.height

def grow (r : Rectangle) (k : ℕ) : Rectangle := ⟨r.width + 2 * k, r.height + 2 * k⟩

def topRight (r : Rectangle) : Point := ⟨r.width, r.height⟩

end Rectangle
