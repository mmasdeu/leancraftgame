def Df (f : ℝ × ℝ → ℝ) (p : ℝ × ℝ) : ℝ × ℝ →L[ℝ] ℝ := fderiv ℝ f p
def Dg (g : ℝ → ℝ × ℝ) (t : ℝ) : ℝ →L[ℝ] ℝ := fderiv ℝ (fun s => (g s).1) t
def normPair : ℝ := 4
def q1 : Fin 4 := 2
def q2 : Fin 4 := 1
def q3 : Bool := true
