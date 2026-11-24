/- Hidden test battery for Level Challenge: triangles. -/
import LeanCraftGame.Referee
import LeanCraftGame.L10.Player

open L10

#no_sorry IsTriangle
#no_sorry IsRight
#no_sorry ExactlyOneEven
#level_start "Challenge: triangles"

#expect_true "3, 4, 5 is a triangle" unfolding IsTriangle :
  IsTriangle 3 4 5
#expect_false "1, 2, 10 is not a triangle" unfolding IsTriangle :
  IsTriangle 1 2 10
#expect_false "1, 2, 3 is flat, not a triangle" unfolding IsTriangle :
  IsTriangle 1 2 3
#expect_false "10, 2, 1 is not a triangle" unfolding IsTriangle :
  IsTriangle 10 2 1
#expect_true "Equilateral triangles: n, n, n for 0 < n < 20" unfolding IsTriangle :
  ∀ n < 20, 0 < n → IsTriangle n n n
#expect_true "IsRight 3 4 5, and 5 4 3 (any side can be the hypotenuse)" unfolding IsRight :
  IsRight 3 4 5 ∧ IsRight 5 4 3
#expect_true "IsRight 13 5 12" unfolding IsRight :
  IsRight 13 5 12
#expect_false "IsRight 0 5 5 is false (no side of length 0)" unfolding IsRight :
  IsRight 0 5 5
#expect_true "Every right triangle is a triangle (all sides < 15)" unfolding IsRight IsTriangle :
  ∀ a < 15, ∀ b < 15, ∀ c < 15, IsRight a b c → IsTriangle a b c
#expect_true "ExactlyOneEven 3 4 5" unfolding ExactlyOneEven :
  ExactlyOneEven 3 4 5
#expect_false "ExactlyOneEven 2 4 5" unfolding ExactlyOneEven :
  ExactlyOneEven 2 4 5
#expect_false "ExactlyOneEven 1 3 5" unfolding ExactlyOneEven :
  ExactlyOneEven 1 3 5
#expect_false "ExactlyOneEven 2 4 6" unfolding ExactlyOneEven :
  ExactlyOneEven 2 4 6
#expect_true "Primitive Pythagorean triples: exactly one of the three is even" unfolding ExactlyOneEven :
  ∀ t ∈ [(3, 4, 5), (4, 3, 5), (5, 12, 13), (8, 15, 17), (7, 24, 25), (20, 21, 29), (12, 35, 37)], ExactlyOneEven t.1 t.2.1 t.2.2

#level_report
