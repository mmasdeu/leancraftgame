def stairs : Nat → Nat
  | 0 => 1
  | 1 => 1
  | n + 2 => stairs n + stairs (n + 1)

def choose : Nat → Nat → Nat
  | _, 0 => 1
  | 0, _ + 1 => 0
  | n + 1, k + 1 => choose n k + choose n (k + 1)

def countEven : Nat → Nat
  | 0 => 0
  | n + 1 => if (n + 1) % 2 = 0 then countEven n + 1 else countEven n
