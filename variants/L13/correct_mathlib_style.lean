def ConvergesTo (s : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ε > 0 → ∃ N, ∀ n, n ≥ N → |s n - a| < ε
statement convergesTo_const {a : ℝ} : ConvergesTo (fun _ ↦ a) a
statement convergesTo_add {s t : ℕ → ℝ} {a b : ℝ} (ht : ConvergesTo t b) (hs : ConvergesTo s a) :
    ConvergesTo (s + t) (a + b)
statement convergesTo_unique {s : ℕ → ℝ} {a b : ℝ} : ConvergesTo s a → ConvergesTo s b → b = a
