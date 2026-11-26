/- Hidden test battery for Level 12: Sequences and convergence. -/
import LeanCraftGame.Referee
import LeanCraftGame.L12.Player

#no_sorry L12.ConvergesTo
#no_sorry L12.convergesTo_const
#no_sorry L12.convergesTo_add
#no_sorry L12.convergesTo_unique
#level_start "Sequences and convergence"

#expect_true "the constant sequence 3 converges to 3" unfolding L12.ConvergesTo :
  L12.ConvergesTo (fun _ => 3) 3
#expect_true "7, 7, 7, 7, 7, 0, 0, 0, … converges to 0" unfolding L12.ConvergesTo :
  L12.ConvergesTo (fun n => if n < 5 then 7 else 0) 0
#expect_false "the constant sequence 3 converges to 4" unfolding L12.ConvergesTo :
  L12.ConvergesTo (fun _ => 3) 4
#expect_false "0, 1, 2, 3, … converges to 0" unfolding L12.ConvergesTo :
  L12.ConvergesTo (fun n => (n : ℝ)) 0
#expect_false "0, 1, 0, 1, … converges to 0" unfolding L12.ConvergesTo :
  L12.ConvergesTo (fun n => if n % 2 = 0 then 0 else 1) 0
#expect_equiv "convergesTo_const: a constant sequence converges to its value" :
  L12.convergesTo_const ↔ ∀ a : ℝ, L12.ConvergesTo (fun _ => a) a
#expect_equiv "convergesTo_add: limits add up" :
  L12.convergesTo_add ↔ ∀ (s t : ℕ → ℝ) (a b : ℝ),
    L12.ConvergesTo s a → L12.ConvergesTo t b → L12.ConvergesTo (fun n => s n + t n) (a + b)
#expect_equiv "convergesTo_unique: a limit is unique" :
  L12.convergesTo_unique ↔ ∀ (s : ℕ → ℝ) (a b : ℝ),
    L12.ConvergesTo s a → L12.ConvergesTo s b → a = b

#level_report
