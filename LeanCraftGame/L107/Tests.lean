/- Hidden test battery for Level Sequences that come back. -/
import LeanCraftGame.Referee
import LeanCraftGame.L107.Player

open L107

#no_sorry EventuallyEqual
#no_sorry InfinitelyOften
#no_sorry OnlyFinitelyOften
#no_sorry Recurrent
#level_start "Level Sequences that come back"

-- 0, 1, 0, 1, …
#expect_true "InfinitelyOften (0, 1, 0, 1, …) 0 is true" unfolding InfinitelyOften :
  InfinitelyOften (fun n => n % 2) 0
#expect_true "InfinitelyOften (0, 1, 0, 1, …) 1 is true" unfolding InfinitelyOften :
  InfinitelyOften (fun n => n % 2) 1
#expect_false "EventuallyEqual (0, 1, 0, 1, …) 0 is false (it keeps leaving 0)" unfolding EventuallyEqual :
  EventuallyEqual (fun n => n % 2) 0
-- 7, 7, 7, 7, 7, 0, 0, …
#expect_true "EventuallyEqual (7, 7, 7, 7, 7, 0, 0, …) 0 is true" unfolding EventuallyEqual :
  EventuallyEqual (fun n => if n < 5 then 7 else 0) 0
#expect_false "EventuallyEqual (7, 7, 7, 7, 7, 0, 0, …) 7 is false (7 is only the beginning)" unfolding EventuallyEqual :
  EventuallyEqual (fun n => if n < 5 then 7 else 0) 7
#expect_false "InfinitelyOften (7, 7, 7, 7, 7, 0, 0, …) 7 is false (met five times, not infinitely often)" unfolding InfinitelyOften :
  InfinitelyOften (fun n => if n < 5 then 7 else 0) 7
#expect_true "OnlyFinitelyOften (7, 7, 7, 7, 7, 0, 0, …) 7 is true" unfolding OnlyFinitelyOften :
  OnlyFinitelyOften (fun n => if n < 5 then 7 else 0) 7
#expect_false "Recurrent (7, 7, 7, 7, 7, 0, 0, …) is false (back to 7 only finitely often)" unfolding Recurrent :
  Recurrent (fun n => if n < 5 then 7 else 0)
-- the identity
#expect_false "InfinitelyOften (n) 3 is false (each value appears once)" unfolding InfinitelyOften :
  InfinitelyOften (fun n => n) 3
#expect_false "EventuallyEqual (n) 0 is false" unfolding EventuallyEqual :
  EventuallyEqual (fun n => n) 0
#expect_true "OnlyFinitelyOften (n) 3 is true" unfolding OnlyFinitelyOften :
  OnlyFinitelyOften (fun n => n) 3
#expect_false "Recurrent (n) is false (0, 1, 2, … never returns to 0)" unfolding Recurrent :
  Recurrent (fun n => n)
-- a constant: the value a is irrelevant for a definition that ignores it
#expect_false "EventuallyEqual (a constant 7) 0 is false (the value a matters)" unfolding EventuallyEqual :
  EventuallyEqual (fun _ => 7) 0
#expect_true "EventuallyEqual (a constant 7) 7 is true" unfolding EventuallyEqual :
  EventuallyEqual (fun _ => 7) 7
#expect_true "Recurrent (a constant) is true" unfolding Recurrent :
  Recurrent (fun _ => 7)
-- n % 3
#expect_false "InfinitelyOften (0, 1, 2, 0, 1, 2, …) 3 is false (3 is never met)" unfolding InfinitelyOften :
  InfinitelyOften (fun n => n % 3) 3
#expect_false "EventuallyEqual (0, 1, 2, 0, 1, 2, …) 0 is false" unfolding EventuallyEqual :
  EventuallyEqual (fun n => n % 3) 0
-- 0, 1, 0, 3, 0, 5, … : unbounded, and still back to 0 again and again
#expect_true "InfinitelyOften (0, 1, 0, 3, 0, 5, …) 0 is true" unfolding InfinitelyOften :
  InfinitelyOften (fun n => if n % 2 = 0 then 0 else n) 0
#expect_false "EventuallyEqual (0, 1, 0, 3, 0, 5, …) 0 is false" unfolding EventuallyEqual :
  EventuallyEqual (fun n => if n % 2 = 0 then 0 else n) 0
#expect_false "InfinitelyOften (0, 1, 0, 3, 0, 5, …) 5 is false (5 is met only once)" unfolding InfinitelyOften :
  InfinitelyOften (fun n => if n % 2 = 0 then 0 else n) 5
#expect_true "Recurrent (0, 1, 0, 3, 0, 5, …) is true" unfolding Recurrent :
  Recurrent (fun n => if n % 2 = 0 then 0 else n)
#expect_true "Recurrent (0, 1, 0, 1, …) is true" unfolding Recurrent :
  Recurrent (fun n => n % 2)
-- 1, 0, 0, 0, …: many zeros, but the starting value 1 never comes back
#expect_false "Recurrent (1, 0, 0, 0, …) is false (u 0 = 1, not 0)" unfolding Recurrent :
  Recurrent (fun n => if n = 0 then 1 else 0)
#expect_false "OnlyFinitelyOften (0, 1, 0, 1, …) 0 is false (0 keeps coming back)" unfolding OnlyFinitelyOften :
  OnlyFinitelyOften (fun n => n % 2) 0
#expect_false "OnlyFinitelyOften (a constant 7) 7 is false" unfolding OnlyFinitelyOften :
  OnlyFinitelyOften (fun _ => 7) 7
-- lemmas
#expect_true "InfinitelyOften u a implies not OnlyFinitelyOften u a" unfolding InfinitelyOften OnlyFinitelyOften :
  ∀ u : ℕ → ℕ, ∀ a, InfinitelyOften u a → ¬ OnlyFinitelyOften u a
#expect_true "EventuallyEqual u a implies OnlyFinitelyOften u (a + 1)" unfolding EventuallyEqual OnlyFinitelyOften :
  ∀ u : ℕ → ℕ, ∀ a, EventuallyEqual u a → OnlyFinitelyOften u (a + 1)

#level_report
