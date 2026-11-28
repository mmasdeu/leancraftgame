def ConvergesTo (s : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |s n - a| < ε
statement convergesTo_const (a : ℝ) : ConvergesTo (fun _ ↦ a) a
statement convergesTo_add (s t : ℕ → ℝ) (a b : ℝ) (hs : ConvergesTo s a) (ht : ConvergesTo t b) :
    ConvergesTo (fun n ↦ s n + t n) (a + b)
statement convergesTo_unique (s : ℕ → ℝ) (a b : ℝ) (sa : ConvergesTo s a) (sb : ConvergesTo s b) : a = b
