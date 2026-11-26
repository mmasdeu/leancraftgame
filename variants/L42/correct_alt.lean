def rotM : Matrix (Fin 2) (Fin 2) ℚ := Matrix.of ![![0, -1], ![1, 0]]
def fibM : Matrix (Fin 2) (Fin 2) ℤ := !![1, 1; 1, 0]
def fib (n : ℕ) : ℤ := (fibM ^ n) 1 0
def singular : Matrix (Fin 2) (Fin 2) ℚ := !![3, -1; -6, 2]
def detB : ℚ := 2 * 4 - 1 * 7
