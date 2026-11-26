def seqA : ℕ → ℝ := fun n => if n < 3 then 1 else 2
def limA : ℝ := 2
def seqB : ℕ → ℝ := fun n => if n % 2 = 0 then 1 else 3
def limB : ℝ := 1
def seqC : ℕ → ℝ := fun _ => 0
def funD : ℝ → ℝ := fun x => 2 * x
