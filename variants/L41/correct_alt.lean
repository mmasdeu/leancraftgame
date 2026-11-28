open MeasureTheory

def I2 : ℝ := ∫ t in (0:ℝ)..1, t ^ 2

def vol : ENNReal := volume (Set.Icc (0:ℝ) 2)

statement ftc {f f' : ℝ → ℝ} {a b : ℝ} : (∀ x ∈ Set.uIcc a b, HasDerivAt f (f' x) x) →
    IntervalIntegrable f' volume a b → f b - f a = ∫ y in a..b, f' y

def q1 : Bool := false
def q2 : Fin 4 := 1
def q3 : Fin 4 := 2
