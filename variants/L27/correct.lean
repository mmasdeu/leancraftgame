-- two numbers `lo` and `hi`, in this order, with an axiom `lo ≤ hi`
structure Interval where
  lo : Nat
  hi : Nat
  h : lo ≤ hi

-- a number `val` with an axiom saying that it is positive
structure PosNat where
  val : Nat
  pos : 0 < val
