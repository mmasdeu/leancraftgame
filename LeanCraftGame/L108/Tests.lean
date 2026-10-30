/- Hidden test battery for Level Divisibility and gcd. -/
import LeanCraftGame.Referee
import LeanCraftGame.L108.Player

open L108

#no_sorry Coprime'
#no_sorry IsGcd
#no_sorry IsPrime'
#no_sorry Squarefree'
#level_start "Divisibility and gcd"

#expect_true "CommonDiv 3 6 9 is true" unfolding CommonDiv :
  CommonDiv 3 6 9
#expect_false "Coprime' 6 15 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  Coprime' 6 15
#expect_false "Coprime' 4 6 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  Coprime' 4 6
#expect_true "Coprime' 0 1 is true" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  Coprime' 0 1
#expect_true "Coprime' 1 1 is true" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  Coprime' 1 1
#expect_false "Coprime' 0 4 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  Coprime' 0 4
#expect_false "Coprime' 0 0 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  Coprime' 0 0
#expect_false "IsGcd 12 18 3 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  IsGcd 12 18 3
#expect_false "IsGcd 12 18 12 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  IsGcd 12 18 12
#expect_false "IsGcd 8 12 2 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  IsGcd 8 12 2
#expect_true "IsGcd 0 5 5 is true" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  IsGcd 0 5 5
#expect_true "IsGcd 0 0 0 is true" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  IsGcd 0 0 0
#expect_true "IsGcd 6 0 6 is true" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  IsGcd 6 0 6
#expect_false "IsGcd 0 0 4 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  IsGcd 0 0 4
#expect_false "IsPrime' 0 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  IsPrime' 0
#expect_false "IsPrime' 1 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  IsPrime' 1
#expect_false "IsPrime' 4 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  IsPrime' 4
#expect_false "IsPrime' 9 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  IsPrime' 9
#expect_false "Squarefree' 12 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  Squarefree' 12
#expect_true "Squarefree' 1 is true" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  Squarefree' 1
#expect_false "Squarefree' 0 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  Squarefree' 0
#expect_false "Squarefree' 18 is false" unfolding Coprime' IsGcd IsPrime' Squarefree' CommonDiv :
  Squarefree' 18

#level_report
