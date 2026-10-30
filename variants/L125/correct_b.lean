structure Time where
  hour : ℕ
  minute : ℕ

structure Date where
  year : ℕ
  month : ℕ := 1
  day : ℕ := 1

def newYear (y : ℕ) : Date := ⟨y, 1, 1⟩

def Date.nextDay (d : Date) : Date :=
  match d with
  | ⟨y, m, day⟩ =>
    if day = 30 then (if m = 12 then ⟨y + 1, 1, 1⟩ else ⟨y, m + 1, 1⟩) else ⟨y, m, day + 1⟩

def Date.addDays (d : Date) : ℕ → Date
  | 0 => d
  | n + 1 => Date.nextDay (Date.addDays d n)

structure Moment extends Date where
  time : Time

def Moment.addMinutes (m : Moment) (k : ℕ) : Moment :=
  let total := 60 * m.time.hour + m.time.minute + k
  { m with toDate := Date.addDays m.toDate (total / 1440), time := { hour := total / 60 % 24, minute := total % 60 } }
