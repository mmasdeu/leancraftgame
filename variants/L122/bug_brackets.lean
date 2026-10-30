structure Point where
  x : ℕ
  y : ℕ

structure Rectangle where
  width : ℕ
  height : ℕ
structure Card where
  rank : ℕ
  suit : ℕ

def origin : Point := ⟨0, 0⟩
def p34 : Point := Point.mk 3 4
def wide : Rectangle := ⟨7, 2⟩
def queenOfHearts : Card := ⟨12, 2⟩
def perimeter (r : Rectangle) : ℕ := 2 * r.width + r.height
def swapPoint (p : Point) : Point := ⟨p.y, p.x⟩
