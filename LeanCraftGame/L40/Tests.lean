/- Hidden test battery for Level 40: Subspaces and quotients. -/
import LeanCraftGame.Referee
import LeanCraftGame.L40.Player

open L40

#no_sorry line
#no_sorry a
#no_sorry b
#no_sorry p
#no_sorry q1
#no_sorry q2
#no_sorry q3
#level_start "Subspaces and quotients"

#expect_true "![1, 2] is on line" unfolding line : ![1, 2] ∈ line
#expect_false "![2, 1] is on line" unfolding line : ![2, 1] ∈ line
#expect_true "line contains the zero vector (zero_mem')" unfolding line : ![0, 0] ∈ line
#expect_true "line is closed under addition (add_mem')" unfolding line :
  ∀ x y z t : ℚ, ![x, y] ∈ line → ![z, t] ∈ line → ![x + z, y + t] ∈ line
#expect_true "line is closed under negation and tripling (smul_mem')" unfolding line :
  ∀ x y : ℚ, ![x, y] ∈ line → ![-x, -y] ∈ line ∧ ![3 * x, 3 * y] ∈ line
#expect_true "your a and b lie on the axes" unfolding axes a b : a ∈ axes ∧ b ∈ axes
#expect_true "a + b is not on the axes" unfolding axes a b : a + b ∉ axes
#expect_true "your p lies on the parabola" unfolding parabola p : p ∈ parabola
#expect_true "2 • p is not on the parabola" unfolding parabola p : ![2 * p 0, 2 * p 1] ∉ parabola
#expect_choice "Question 1: what `U ⊔ W` is" : q1 = 2
#expect_choice "Question 2: what `⊥ : Submodule K V` is" : q2 = 0
#expect_choice "Question 3: is `{v | v 1 = 2 * v 0 + 1}` a subspace?" : q3 = false

#level_report
