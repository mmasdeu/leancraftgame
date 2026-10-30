/- Hidden test battery for Level Extending and updating. -/
import LeanCraftGame.Referee
import LeanCraftGame.L124.Player

open L124

#no_sorry moveRight
#no_sorry quiet
#no_sorry raise
#no_sorry Pair.swap
#no_sorry Pair.dup
#level_start "Extending and updating"

-- updating with `with`
#expect_true "moveRight ⟨3, 4⟩ 2 has x = 5" :
  (moveRight ⟨3, 4⟩ 2).x = 5
#expect_true "moveRight ⟨3, 4⟩ 2 has y = 4" :
  (moveRight ⟨3, 4⟩ 2).y = 4
#expect_true "moveRight ⟨0, 7⟩ 0 is ⟨0, 7⟩" :
  (moveRight ⟨0, 7⟩ 0).x = 0 ∧ (moveRight ⟨0, 7⟩ 0).y = 7
-- default values
#expect_true "the default volume is 5" :
  ({} : Settings).volume = 5
#expect_true "the default brightness is 7" :
  ({} : Settings).brightness = 7
#expect_true "the default muted is 0" :
  ({} : Settings).muted = 0
#expect_true "the second field of Settings is the brightness" :
  (Settings.mk 1 2 3).brightness = 2
#expect_true "the third field of Settings is muted" :
  (Settings.mk 1 2 3).muted = 3
#expect_true "quiet has volume 0" :
  quiet.volume = 0
#expect_true "quiet keeps the default brightness 7" :
  quiet.brightness = 7
#expect_true "quiet keeps the default muted 0" :
  quiet.muted = 0
-- extends
#expect_true "Point3.mk ⟨1, 2⟩ 3 has z = 3" :
  (Point3.mk ⟨1, 2⟩ 3).z = 3
#expect_true "Point3.mk ⟨1, 2⟩ 3 has x = 1" :
  (Point3.mk ⟨1, 2⟩ 3).x = 1
#expect_true "Point3.mk ⟨1, 2⟩ 3 has y = 2" :
  (Point3.mk ⟨1, 2⟩ 3).y = 2
#expect_true "raise (Point3.mk ⟨1, 2⟩ 3) 10 has z = 13" :
  (raise (Point3.mk ⟨1, 2⟩ 3) 10).z = 13
#expect_true "raise (Point3.mk ⟨1, 2⟩ 3) 10 keeps x = 1" :
  (raise (Point3.mk ⟨1, 2⟩ 3) 10).x = 1
#expect_true "raise (Point3.mk ⟨1, 2⟩ 3) 10 keeps y = 2" :
  (raise (Point3.mk ⟨1, 2⟩ 3) 10).y = 2
-- Pair
#expect_true "the first field of a Pair is fst" :
  (Pair.mk 1 2 : Pair ℕ).fst = 1
#expect_true "swap ⟨1, 2⟩ has fst = 2" :
  (Pair.swap (Pair.mk 1 2 : Pair ℕ)).fst = 2
#expect_true "swap ⟨1, 2⟩ has snd = 1" :
  (Pair.swap (Pair.mk 1 2 : Pair ℕ)).snd = 1
#expect_true "dup 4 has fst = 4" :
  (Pair.dup 4 : Pair ℕ).fst = 4
#expect_true "dup 4 has snd = 4" :
  (Pair.dup 4 : Pair ℕ).snd = 4

#level_report
