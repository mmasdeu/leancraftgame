def line : Set (Fin 2 → ℚ) := {v | v 1 = 2 * v 0}

def axes : Set (Fin 2 → ℚ) := {v | v 0 * v 1 = 0}
def a : Fin 2 → ℚ := ![1, 0]
def b : Fin 2 → ℚ := ![2, 0]

def parabola : Set (Fin 2 → ℚ) := {v | v 1 = v 0 ^ 2}
def p : Fin 2 → ℚ := ![1, 1]

def q1 : Fin 3 := 2
def q2 : Fin 3 := 0
def q3 : Bool := false
