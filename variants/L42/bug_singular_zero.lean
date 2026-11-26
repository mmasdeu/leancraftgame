def rotM : Matrix (Fin 2) (Fin 2) ℚ := !![0, -1; 1, 0]
def fibM : Matrix (Fin 2) (Fin 2) ℤ := !![1, 1; 1, 0]
def fib (n : ℕ) : ℤ := (fibM ^ n) 0 1
def singular : Matrix (Fin 2) (Fin 2) ℚ := !![1, 0; 0, 0]
def detB : ℚ := 1
