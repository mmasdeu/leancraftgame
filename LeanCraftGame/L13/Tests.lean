/- Hidden test battery for Level 12: Sequences and convergence. -/
import LeanCraftGame.Referee
import LeanCraftGame.L13.Player

#no_sorry L13.ConvergesTo
#no_sorry L13.convergesTo_const
#no_sorry L13.convergesTo_add
#no_sorry L13.convergesTo_unique
#level_start "Sequences and convergence"

#expect_true "the constant sequence 3 converges to 3" unfolding L13.ConvergesTo :
  L13.ConvergesTo (fun _ => 3) 3
#expect_true "7, 7, 7, 7, 7, 0, 0, 0, … converges to 0" unfolding L13.ConvergesTo :
  L13.ConvergesTo (fun n => if n < 5 then 7 else 0) 0
#expect_false "the constant sequence 3 converges to 4" unfolding L13.ConvergesTo :
  L13.ConvergesTo (fun _ => 3) 4
#expect_false "0, 1, 2, 3, … converges to 0" unfolding L13.ConvergesTo :
  L13.ConvergesTo (fun n => (n : ℝ)) 0
#expect_false "0, 1, 0, 1, … converges to 0" unfolding L13.ConvergesTo :
  L13.ConvergesTo (fun n => if n % 2 = 0 then 0 else 1) 0
#expect_equiv "convergesTo_const: a constant sequence converges to its value" :
  L13.convergesTo_const ↔ ∀ a : ℝ, L13.ConvergesTo (fun _ => a) a
#expect_equiv "convergesTo_add: limits add up" :
  L13.convergesTo_add ↔ ∀ (s t : ℕ → ℝ) (a b : ℝ),
    L13.ConvergesTo s a → L13.ConvergesTo t b → L13.ConvergesTo (fun n => s n + t n) (a + b)
#expect_equiv "convergesTo_unique: a limit is unique" :
  L13.convergesTo_unique ↔ ∀ (s : ℕ → ℝ) (a b : ℝ),
    L13.ConvergesTo s a → L13.ConvergesTo s b → a = b

#level_report
