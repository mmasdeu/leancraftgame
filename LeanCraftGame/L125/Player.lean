/-
# Challenge: structures

No new syntax here: put together everything from the three previous levels.
You build a small calendar. To keep it simple, the Lean calendar has **12
months of exactly 30 days** each, so the day of the month is between 1 and 30
and the month between 1 and 12.

A date is a structure `Date` with the fields `year`, `month` and `day`, in
this order. A *moment* is a date together with a time of day; the time of day
`Time` (declared for you) has an `hour` from 0 to 23 and a `minute` from 0 to
59. A `Moment` *extends* `Date` with one more field called `time`.

Think about what the functions must do at the edges:

* the day after the 30th of a month is the 1st of the next month;
* after the 12th month comes the 1st month of the next year;
* 23:59 plus one minute is 0:00 of the next day, and the date must follow;
* a minute count may be huge: a whole day is 1440 minutes.

Remember how a structure is built, in the order of its fields, and how `with`
copies the fields you do not mention.

## Your task

Declare `Date` (with defaults, see the comment) and `Moment`, then write the
functions. Each comment has an example.
-/
namespace L125

structure Time where
  hour : ℕ
  minute : ℕ

-- fields `year`, `month`, `day`, in this order, natural numbers;
-- the month and the day have the default value 1
structure Date where
  -- your fields here

-- January the 1st of the given year     (use the defaults)
def newYear (y : ℕ) : Date := sorry

-- the following day      (nextDay ⟨2024, 3, 30⟩ is ⟨2024, 4, 1⟩, nextDay ⟨2024, 12, 30⟩ is ⟨2025, 1, 1⟩)
def Date.nextDay (d : Date) : Date := sorry

-- the date `n` days later   (addDays ⟨2024, 3, 28⟩ 5 is ⟨2024, 4, 3⟩)
-- Use the cases `0` and `n + 1` and the function `nextDay`.
def Date.addDays (d : Date) : ℕ → Date
  | 0 => sorry
  | n + 1 => sorry

-- a date together with a time, in this order
structure Moment extends Date where
  -- your field here

-- the moment `k` minutes later; the date moves on when midnight is passed
--   (23:30 on 2024-3-14, plus 45 minutes, is 0:15 on 2024-3-15)
def Moment.addMinutes (m : Moment) (k : ℕ) : Moment := sorry

end L125
