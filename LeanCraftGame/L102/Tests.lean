/- Hidden test battery for Level Challenge: calendars and triangles. -/
import LeanCraftGame.Referee
import LeanCraftGame.L102.Player

open L102

#no_sorry LeapYear
#no_sorry IsTriangle
#no_sorry ExactlyOneEven
#level_start "Challenge: calendars and triangles"

#expect_true "LeapYear 2024 is true" unfolding LeapYear :
  LeapYear 2024
#expect_false "LeapYear 2023 is false" unfolding LeapYear :
  LeapYear 2023
#expect_false "LeapYear 1900 is false (century year, not divisible by 400)" unfolding LeapYear :
  LeapYear 1900
#expect_true "LeapYear 2000 is true (divisible by 400)" unfolding LeapYear :
  LeapYear 2000
#expect_false "LeapYear 2100 is false (century year)" unfolding LeapYear :
  LeapYear 2100
#expect_true "LeapYear 1996 is true" unfolding LeapYear :
  LeapYear 1996
#expect_false "LeapYear 2022 is false (2 mod 4)" unfolding LeapYear :
  LeapYear 2022
#expect_true "LeapYear 400 is true" unfolding LeapYear :
  LeapYear 400
#expect_true "IsTriangle 3 4 5 is true" unfolding IsTriangle :
  IsTriangle 3 4 5
#expect_true "IsTriangle 2 2 2 is true" unfolding IsTriangle :
  IsTriangle 2 2 2
#expect_false "IsTriangle 1 2 3 is false (flat)" unfolding IsTriangle :
  IsTriangle 1 2 3
#expect_false "IsTriangle 5 1 1 is false (first side too long)" unfolding IsTriangle :
  IsTriangle 5 1 1
#expect_false "IsTriangle 1 5 1 is false (second side too long)" unfolding IsTriangle :
  IsTriangle 1 5 1
#expect_false "IsTriangle 1 1 5 is false (third side too long)" unfolding IsTriangle :
  IsTriangle 1 1 5
#expect_false "IsTriangle 0 3 3 is false (a side of length 0)" unfolding IsTriangle :
  IsTriangle 0 3 3
#expect_true "IsTriangle 2 3 4 is true" unfolding IsTriangle :
  IsTriangle 2 3 4
#expect_true "ExactlyOneEven 2 3 5 is true" unfolding ExactlyOneEven :
  ExactlyOneEven 2 3 5
#expect_true "ExactlyOneEven 3 5 4 is true" unfolding ExactlyOneEven :
  ExactlyOneEven 3 5 4
#expect_true "ExactlyOneEven 3 6 5 is true" unfolding ExactlyOneEven :
  ExactlyOneEven 3 6 5
#expect_false "ExactlyOneEven 2 4 5 is false (two even)" unfolding ExactlyOneEven :
  ExactlyOneEven 2 4 5
#expect_false "ExactlyOneEven 2 4 6 is false (all even)" unfolding ExactlyOneEven :
  ExactlyOneEven 2 4 6
#expect_false "ExactlyOneEven 1 3 5 is false (none even)" unfolding ExactlyOneEven :
  ExactlyOneEven 1 3 5
#expect_false "ExactlyOneEven 0 2 3 is false (0 and 2 are even)" unfolding ExactlyOneEven :
  ExactlyOneEven 0 2 3

#level_report
