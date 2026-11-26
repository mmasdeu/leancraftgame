def Df (f : ℝ × ℝ → ℝ) (p : ℝ × ℝ) : ℝ × ℝ →L[ℝ] ℝ := 0
def Dg (g : ℝ → ℝ × ℝ) (t : ℝ) : ℝ →L[ℝ] ℝ × ℝ := fderiv ℝ g t
def normPair : ℝ := 4
def q1 : Fin 4 := 2
def q2 : Fin 4 := 1
def q3 : Bool := true
