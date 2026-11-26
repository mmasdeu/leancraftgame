/- Hidden test battery for Level 28: Defining structures. -/
import LeanCraftGame.Referee
import LeanCraftGame.L28.Player

open L28

#no_sorry origin
#no_sorry p123
#no_sorry Point.add
#no_sorry Point.smul
#level_start "Defining structures"

#expect_true "the origin has coordinates (0, 0, 0)" unfolding origin :
  origin.x = 0 ∧ origin.y = 0 ∧ origin.z = 0
#expect_true "p123 has coordinates (1, 2, 3)" unfolding p123 :
  p123.x = 1 ∧ p123.y = 2 ∧ p123.z = 3
#expect_true "p123.add p123 has coordinates (2, 4, 6)" unfolding Point.add p123 :
  (p123.add p123).x = 2 ∧ (p123.add p123).y = 4 ∧ (p123.add p123).z = 6
#expect_true "adding the origin changes nothing" unfolding Point.add origin :
  ∀ a : Point, (a.add origin).x = a.x ∧ (a.add origin).y = a.y ∧ (a.add origin).z = a.z
#expect_true "Point.smul 2 p123 has coordinates (2, 4, 6)" unfolding Point.smul p123 :
  (Point.smul 2 p123).x = 2 ∧ (Point.smul 2 p123).y = 4 ∧ (Point.smul 2 p123).z = 6
#expect_true "scaling by 0 gives the origin" unfolding Point.smul :
  ∀ a : Point, (Point.smul 0 a).x = 0 ∧ (Point.smul 0 a).y = 0 ∧ (Point.smul 0 a).z = 0
#expect_model "(1/2, 1/2, 0) is in the simplex" : StandardTwoSimplex.mk (1 / 2) (1 / 2) 0
#expect_model "(1/3, 1/3, 1/3) is in the simplex" : StandardTwoSimplex.mk (1 / 3) (1 / 3) (1 / 3)
#expect_not_model "(1, 1, -1) is not in the simplex" : StandardTwoSimplex.mk 1 1 (-1)
#expect_not_model "(1/2, 1/2, 1/2) is not in the simplex" : StandardTwoSimplex.mk (1 / 2) (1 / 2) (1 / 2)
#expect_not_model "(0, 0, 0) is not in the simplex" : StandardTwoSimplex.mk 0 0 0

#level_report
