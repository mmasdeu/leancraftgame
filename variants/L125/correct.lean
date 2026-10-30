structure Time where
  hour : ℕ
  minute : ℕ

structure Date where
  year : ℕ
  month : ℕ := 1
  day : ℕ := 1

def newYear (y : ℕ) : Date := { year := y }

def Date.nextDay (d : Date) : Date :=
  if d.day < 30 then { d with day := d.day + 1 }
  else if d.month < 12 then { d with month := d.month + 1, day := 1 }
  else { year := d.year + 1, month := 1, day := 1 }

def Date.addDays (d : Date) : ℕ → Date
  | 0 => d
  | n + 1 => (Date.addDays d n).nextDay

structure Moment extends Date where
  time : Time

def Moment.addMinutes (m : Moment) (k : ℕ) : Moment :=
  let total := 60 * m.time.hour + m.time.minute + k
  { toDate := m.toDate.addDays (total / 1440), time := ⟨(total / 60) % 24, total % 60⟩ }
