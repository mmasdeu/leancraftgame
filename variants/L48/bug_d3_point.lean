def d3 : ℝ := deriv (fun x : ℝ => x ^ 3) 3

statement sq_hasDeriv : HasDerivAt (fun x : ℝ => x ^ 2) 6 3

statement rolle (f : ℝ → ℝ) (a b : ℝ) (hab : a < b) (hfc : ContinuousOn f (Set.Icc a b))
    (hfab : f a = f b) : ∃ c ∈ Set.Ioo a b, deriv f c = 0

statement mvt (f : ℝ → ℝ) (a b : ℝ) (hab : a < b) (hfc : ContinuousOn f (Set.Icc a b))
    (hfd : DifferentiableOn ℝ f (Set.Ioo a b)) :
    ∃ c ∈ Set.Ioo a b, deriv f c = (f b - f a) / (b - a)

def q1 : Fin 4 := 1
def q2 : Bool := false
