/- Hidden test battery for Level Challenge: structures. -/
import LeanCraftGame.Referee
import LeanCraftGame.L125.Player

open L125

#no_sorry newYear
#no_sorry Date.nextDay
#no_sorry Date.addDays
#no_sorry Moment.addMinutes
#level_start "Challenge: structures"

-- the structure and the defaults
#expect_true "Date.mk 2024 3 14 has month 3 and day 14" :
  (Date.mk 2024 3 14).month = 3 ∧ (Date.mk 2024 3 14).day = 14
#expect_true "the default month is 1" :
  ({ year := 7 } : Date).month = 1
#expect_true "the default day is 1" :
  ({ year := 7 } : Date).day = 1
#expect_true "newYear 2025 is the 1st of January 2025" :
  (newYear 2025).year = 2025 ∧ (newYear 2025).month = 1 ∧ (newYear 2025).day = 1
-- nextDay
#expect_true "nextDay ⟨2024, 3, 14⟩ is the 15th" :
  (Date.nextDay ⟨2024, 3, 14⟩).year = 2024 ∧ (Date.nextDay ⟨2024, 3, 14⟩).month = 3 ∧ (Date.nextDay ⟨2024, 3, 14⟩).day = 15
#expect_true "nextDay ⟨2024, 3, 29⟩ is the 30th of the same month" :
  (Date.nextDay ⟨2024, 3, 29⟩).month = 3 ∧ (Date.nextDay ⟨2024, 3, 29⟩).day = 30
#expect_true "nextDay ⟨2024, 3, 30⟩ is the 1st of month 4" :
  (Date.nextDay ⟨2024, 3, 30⟩).year = 2024 ∧ (Date.nextDay ⟨2024, 3, 30⟩).month = 4 ∧ (Date.nextDay ⟨2024, 3, 30⟩).day = 1
#expect_true "nextDay ⟨2024, 11, 30⟩ is the 1st of month 12" :
  (Date.nextDay ⟨2024, 11, 30⟩).year = 2024 ∧ (Date.nextDay ⟨2024, 11, 30⟩).month = 12 ∧ (Date.nextDay ⟨2024, 11, 30⟩).day = 1
#expect_true "nextDay ⟨2024, 12, 29⟩ stays in year 2024" :
  (Date.nextDay ⟨2024, 12, 29⟩).year = 2024 ∧ (Date.nextDay ⟨2024, 12, 29⟩).month = 12 ∧ (Date.nextDay ⟨2024, 12, 29⟩).day = 30
#expect_true "nextDay ⟨2024, 12, 30⟩ is the 1st of month 1 of 2025" :
  (Date.nextDay ⟨2024, 12, 30⟩).year = 2025 ∧ (Date.nextDay ⟨2024, 12, 30⟩).month = 1 ∧ (Date.nextDay ⟨2024, 12, 30⟩).day = 1
-- addDays
#expect_true "addDays ⟨2024, 3, 14⟩ 0 is the same date" :
  (Date.addDays ⟨2024, 3, 14⟩ 0).year = 2024 ∧ (Date.addDays ⟨2024, 3, 14⟩ 0).month = 3 ∧ (Date.addDays ⟨2024, 3, 14⟩ 0).day = 14
#expect_true "addDays ⟨2024, 3, 14⟩ 1 is the 15th" :
  (Date.addDays ⟨2024, 3, 14⟩ 1).month = 3 ∧ (Date.addDays ⟨2024, 3, 14⟩ 1).day = 15
#expect_true "addDays ⟨2024, 3, 28⟩ 5 is ⟨2024, 4, 3⟩" :
  (Date.addDays ⟨2024, 3, 28⟩ 5).year = 2024 ∧ (Date.addDays ⟨2024, 3, 28⟩ 5).month = 4 ∧ (Date.addDays ⟨2024, 3, 28⟩ 5).day = 3
#expect_true "addDays ⟨2024, 12, 25⟩ 10 is ⟨2025, 1, 5⟩" :
  (Date.addDays ⟨2024, 12, 25⟩ 10).year = 2025 ∧ (Date.addDays ⟨2024, 12, 25⟩ 10).month = 1 ∧ (Date.addDays ⟨2024, 12, 25⟩ 10).day = 5
#expect_true "addDays ⟨2024, 12, 1⟩ 30 is ⟨2025, 1, 1⟩" :
  (Date.addDays ⟨2024, 12, 1⟩ 30).year = 2025 ∧ (Date.addDays ⟨2024, 12, 1⟩ 30).month = 1 ∧ (Date.addDays ⟨2024, 12, 1⟩ 30).day = 1
-- Moment.addMinutes: the time of day
#expect_true "10:15 plus 20 minutes is 10:35" :
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨10, 15⟩) 20).time.hour = 10 ∧
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨10, 15⟩) 20).time.minute = 35
#expect_true "10:15 plus 50 minutes is 11:05" :
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨10, 15⟩) 50).time.hour = 11 ∧
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨10, 15⟩) 50).time.minute = 5
#expect_true "23:30 plus 45 minutes is 0:15" :
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨23, 30⟩) 45).time.hour = 0 ∧
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨23, 30⟩) 45).time.minute = 15
#expect_true "12:00 plus 3000 minutes is 14:00" :
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨12, 0⟩) 3000).time.hour = 14 ∧
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨12, 0⟩) 3000).time.minute = 0
-- Moment.addMinutes: the date
#expect_true "10:15 plus 20 minutes keeps the date" :
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨10, 15⟩) 20).year = 2024 ∧
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨10, 15⟩) 20).month = 3 ∧
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨10, 15⟩) 20).day = 14
#expect_true "23:30 plus 45 minutes moves the date to 2024-3-15" :
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨23, 30⟩) 45).year = 2024 ∧
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨23, 30⟩) 45).month = 3 ∧
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨23, 30⟩) 45).day = 15
#expect_true "23:30 on 2024-12-30 plus 45 minutes is on 2025-1-1" :
  (Moment.addMinutes (Moment.mk ⟨2024, 12, 30⟩ ⟨23, 30⟩) 45).year = 2025 ∧
  (Moment.addMinutes (Moment.mk ⟨2024, 12, 30⟩ ⟨23, 30⟩) 45).month = 1 ∧
  (Moment.addMinutes (Moment.mk ⟨2024, 12, 30⟩ ⟨23, 30⟩) 45).day = 1
#expect_true "12:00 plus 1440 minutes is the next day" :
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨12, 0⟩) 1440).day = 15 ∧
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨12, 0⟩) 1440).time.hour = 12
#expect_true "12:00 plus 3000 minutes is two days later" :
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨12, 0⟩) 3000).month = 3 ∧
  (Moment.addMinutes (Moment.mk ⟨2024, 3, 14⟩ ⟨12, 0⟩) 3000).day = 16

#level_report
