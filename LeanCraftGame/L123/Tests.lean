/- Hidden test battery for Level Functions on structures. -/
import LeanCraftGame.Referee
import LeanCraftGame.L123.Player

open L123

#no_sorry Point.add
#no_sorry Point.dist2
#no_sorry Rectangle.area
#no_sorry Rectangle.grow
#no_sorry Rectangle.topRight
#level_start "Functions on structures"

-- Point.add
#expect_true "add ⟨1, 2⟩ ⟨3, 4⟩ has x = 4" :
  (Point.add ⟨1, 2⟩ ⟨3, 4⟩).x = 4
#expect_true "add ⟨1, 2⟩ ⟨3, 4⟩ has y = 6" :
  (Point.add ⟨1, 2⟩ ⟨3, 4⟩).y = 6
#expect_true "add ⟨5, 0⟩ ⟨0, 9⟩ has x = 5 and y = 9" :
  (Point.add ⟨5, 0⟩ ⟨0, 9⟩).x = 5 ∧ (Point.add ⟨5, 0⟩ ⟨0, 9⟩).y = 9
#expect_true "add ⟨2, 7⟩ ⟨0, 0⟩ gives ⟨2, 7⟩" :
  (Point.add ⟨2, 7⟩ ⟨0, 0⟩).x = 2 ∧ (Point.add ⟨2, 7⟩ ⟨0, 0⟩).y = 7
-- Point.dist2
#expect_true "dist2 ⟨0, 0⟩ ⟨3, 4⟩ = 25" :
  Point.dist2 ⟨0, 0⟩ ⟨3, 4⟩ = 25
#expect_true "dist2 ⟨3, 4⟩ ⟨0, 0⟩ = 25" :
  Point.dist2 ⟨3, 4⟩ ⟨0, 0⟩ = 25
#expect_true "dist2 ⟨1, 1⟩ ⟨4, 5⟩ = 25" :
  Point.dist2 ⟨1, 1⟩ ⟨4, 5⟩ = 25
#expect_true "dist2 ⟨4, 1⟩ ⟨1, 5⟩ = 25" :
  Point.dist2 ⟨4, 1⟩ ⟨1, 5⟩ = 25
#expect_true "dist2 ⟨1, 5⟩ ⟨4, 1⟩ = 25" :
  Point.dist2 ⟨1, 5⟩ ⟨4, 1⟩ = 25
#expect_true "dist2 ⟨2, 2⟩ ⟨2, 2⟩ = 0" :
  Point.dist2 ⟨2, 2⟩ ⟨2, 2⟩ = 0
#expect_true "dist2 ⟨7, 2⟩ ⟨2, 7⟩ = 50" :
  Point.dist2 ⟨7, 2⟩ ⟨2, 7⟩ = 50
-- Rectangle.area
#expect_true "area of a 7 by 2 rectangle is 14" :
  Rectangle.area ⟨7, 2⟩ = 14
#expect_true "area of a 3 by 0 rectangle is 0" :
  Rectangle.area ⟨3, 0⟩ = 0
#expect_true "area of a 4 by 4 rectangle is 16" :
  Rectangle.area ⟨4, 4⟩ = 16
-- Rectangle.grow
#expect_true "grow ⟨7, 2⟩ 1 has width 9" :
  (Rectangle.grow ⟨7, 2⟩ 1).width = 9
#expect_true "grow ⟨7, 2⟩ 1 has height 4" :
  (Rectangle.grow ⟨7, 2⟩ 1).height = 4
#expect_true "grow ⟨3, 5⟩ 0 is unchanged" :
  (Rectangle.grow ⟨3, 5⟩ 0).width = 3 ∧ (Rectangle.grow ⟨3, 5⟩ 0).height = 5
#expect_true "grow ⟨1, 6⟩ 3 has width 7 and height 12" :
  (Rectangle.grow ⟨1, 6⟩ 3).width = 7 ∧ (Rectangle.grow ⟨1, 6⟩ 3).height = 12
-- Rectangle.topRight
#expect_true "topRight ⟨7, 2⟩ has x = 7" :
  (Rectangle.topRight ⟨7, 2⟩).x = 7
#expect_true "topRight ⟨7, 2⟩ has y = 2" :
  (Rectangle.topRight ⟨7, 2⟩).y = 2
#expect_true "topRight ⟨1, 9⟩ has x = 1 and y = 9" :
  (Rectangle.topRight ⟨1, 9⟩).x = 1 ∧ (Rectangle.topRight ⟨1, 9⟩).y = 9

#level_report
