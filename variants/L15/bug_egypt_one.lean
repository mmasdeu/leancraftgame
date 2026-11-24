-- A colleague's definitions (to read: the referee uses its own copy).
def diff (a b : ℕ) : ℤ := ((a - b : ℕ) : ℤ)                    -- meant: a - b in ℤ
def IsReciprocal (x y : ℚ) : Prop := y = 1 / x                 -- meant: x · y = 1
def average (a b : ℚ) : ℚ := a + b / 2                         -- meant: (a + b) / 2
def egypt (a b : ℕ) : ℚ := ((1 / a + 1 / b : ℕ) : ℚ)          -- meant: 1/a + 1/b in ℚ

-- diff gets these wrong
def diffA : ℕ := 3
def diffB : ℕ := 5
-- IsReciprocal accepts these, but recX · recY ≠ 1
def recX : ℚ := 0
def recY : ℚ := 0
-- average gets these wrong
def avgA : ℚ := 2
def avgB : ℚ := 2
-- egypt gets these wrong (both positive)
def egA : ℕ := 1
def egB : ℕ := 1
