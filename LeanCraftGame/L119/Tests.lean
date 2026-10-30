/- Hidden test battery for Level Closed forms. -/
import LeanCraftGame.Referee
import LeanCraftGame.L119.Player

open L119

#no_sorry cubeSum
#no_sorry cubeFormula
#no_sorry sameParity
#no_sorry geom
#no_sorry geomFormula
#no_sorry meanSquare
#level_start "Closed forms"

-- the worked examples
#expect_true "triSum 4 = 10 (the worked example)" unfolding triSum :
  triSum 4 = 10
#expect_true "triSum agrees with triFormula below 10 (the worked example)" unfolding triSum triFormula :
  ∀ n < 10, triSum n = triFormula n
#expect_true "pairs 5 = 10 (the worked example)" unfolding pairs :
  pairs 5 = 10
-- your definitions
#expect_true "cubeSum 0 = 0" unfolding cubeSum :
  cubeSum 0 = 0
#expect_true "cubeSum 3 = 36 (1 + 8 + 27)" unfolding cubeSum :
  cubeSum 3 = 36
#expect_true "cubeSum 5 = 225" unfolding cubeSum :
  cubeSum 5 = 225
#expect_true "cubeFormula 0 = 0" unfolding cubeFormula :
  cubeFormula 0 = 0
#expect_true "cubeFormula 2 = 9 (the square of 1 + 2)" unfolding cubeFormula :
  cubeFormula 2 = 9
#expect_true "cubeFormula 4 = 100" unfolding cubeFormula :
  cubeFormula 4 = 100
#expect_true "cubeSum agrees with cubeFormula for every n < 8" unfolding cubeSum cubeFormula :
  ∀ n < 8, cubeSum n = cubeFormula n
#expect_true "sameParity 0 = 0" unfolding sameParity :
  sameParity 0 = 0
#expect_true "sameParity 3 = 1 (only the pair (0, 2))" unfolding sameParity :
  sameParity 3 = 1
#expect_true "sameParity 4 = 2" unfolding sameParity :
  sameParity 4 = 2
#expect_true "sameParity 5 = 4" unfolding sameParity :
  sameParity 5 = 4
#expect_true "geom 0 = 0 (the empty sum)" unfolding geom :
  geom 0 = 0
#expect_true "geom 1 = 1" unfolding geom :
  geom 1 = 1
#expect_true "geom 3 = 7/4" unfolding geom :
  geom 3 = 7 / 4
#expect_true "geomFormula 0 = 0" unfolding geomFormula :
  geomFormula 0 = 0
#expect_true "geomFormula 1 = 1" unfolding geomFormula :
  geomFormula 1 = 1
#expect_true "geomFormula 3 = 7/4" unfolding geomFormula :
  geomFormula 3 = 7 / 4
#expect_true "geom agrees with geomFormula for every n < 6" unfolding geom geomFormula :
  ∀ n < 6, geom n = geomFormula n
#expect_true "meanSquare 0 = 0 (division by zero gives 0)" unfolding meanSquare :
  meanSquare 0 = 0
#expect_true "meanSquare 1 = 0" unfolding meanSquare :
  meanSquare 1 = 0
#expect_true "meanSquare 4 = 7/2 (the mean of 0, 1, 4, 9)" unfolding meanSquare :
  meanSquare 4 = 7 / 2
#expect_true "meanSquare 3 = 5/3 (not a whole number)" unfolding meanSquare :
  meanSquare 3 = 5 / 3

#level_report
