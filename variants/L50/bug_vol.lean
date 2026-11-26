def I2 : ℝ := ∫ x in (0:ℝ)..1, x ^ 2

def vol : ENNReal := MeasureTheory.volume (Set.Icc (1:ℝ) 2)

statement ftc (f f' : ℝ → ℝ) (a b : ℝ) (hderiv : ∀ x ∈ Set.uIcc a b, HasDerivAt f (f' x) x)
    (hint : IntervalIntegrable f' MeasureTheory.volume a b) : ∫ y in a..b, f' y = f b - f a

def q1 : Bool := false
def q2 : Fin 4 := 1
def q3 : Fin 4 := 2
