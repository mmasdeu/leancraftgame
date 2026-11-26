/- Hidden test battery for Level 24: Finset and Fintype. -/
import LeanCraftGame.Referee
import LeanCraftGame.L24.Player

open L24

#no_sorry divs
#no_sorry squaresUpTo
#no_sorry subsetsOfSize
#no_sorry numFns
#level_start "Finset and Fintype"

#expect_false "Finset.range 4 contains 4" : 4 ∈ Finset.range 4
#expect_true "divs 12 is {1, 2, 3, 4, 6, 12}" unfolding divs : divs 12 = {1, 2, 3, 4, 6, 12}
#expect_true "9 is one of the divisors of 9" unfolding divs : 9 ∈ divs 9
#expect_true "7 has exactly two divisors" unfolding divs : (divs 7).card = 2
#expect_true "squaresUpTo 4 contains 16" unfolding squaresUpTo : 16 ∈ squaresUpTo 4
#expect_true "squaresUpTo 4 has five elements" unfolding squaresUpTo : (squaresUpTo 4).card = 5
#expect_false "squaresUpTo 3 contains 2" unfolding squaresUpTo : 2 ∈ squaresUpTo 3
#expect_true "{1, 2, 3, 4} has six subsets of size 2" unfolding subsetsOfSize :
  (subsetsOfSize {1, 2, 3, 4} 2).card = 6
#expect_true "{1, 3} is a subset of size 2 of {1, 2, 3, 4}" unfolding subsetsOfSize :
  ({1, 3} : Finset ℕ) ∈ subsetsOfSize {1, 2, 3, 4} 2
#expect_false "{1} is a subset of size 2 of {1, 2, 3, 4}" unfolding subsetsOfSize :
  ({1} : Finset ℕ) ∈ subsetsOfSize {1, 2, 3, 4} 2
#expect_true "the only subset of size 0 is ∅" unfolding subsetsOfSize :
  subsetsOfSize {1, 2, 3} 0 = {∅}
#expect_true "there are 8 functions Fin 3 → Bool" unfolding numFns : numFns = 8

#level_report
