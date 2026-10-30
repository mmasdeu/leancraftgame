def stairs (n : Nat) : Nat :=
  match n with
  | 0 => 1
  | 1 => 1
  | m + 2 => stairs m + stairs (m + 1)

def choose (n k : Nat) : Nat :=
  match n, k with
  | _, 0 => 1
  | 0, _ => 0
  | m + 1, j + 1 => choose m j + choose m (j + 1)

def countEven : Nat → Nat
  | 0 => 1
  | 1 => 1
  | n + 2 => countEven n + 1
