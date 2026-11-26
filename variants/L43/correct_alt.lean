open Filter Topology

def EventuallyPos (u : ℕ → ℝ) : Prop := ∀ᶠ n in atTop, u n > 0
def OftenZero (u : ℕ → ℝ) : Prop := ∃ᶠ k in atTop, u k = 0
def ConvTo (u : ℕ → ℝ) (a : ℝ) : Prop := Filter.Tendsto u Filter.atTop (nhds a)
def ToInfinity (u : ℕ → ℝ) : Prop := Tendsto (fun n => u n) atTop atTop
def ContAt (f : ℝ → ℝ) (x : ℝ) : Prop := Tendsto f (𝓝 x) (𝓝 (f x))

def q1 : Fin 4 := 3
def q2 : Fin 3 := 1
def q3 : Bool := true
