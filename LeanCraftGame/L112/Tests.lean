/- Hidden test battery for Level Cluster values. -/
import LeanCraftGame.Referee
import LeanCraftGame.L112.Player

open L112

#no_sorry Diverges
#no_sorry ClusterValue
#level_start "Cluster values"

-- the worked example
#expect_true "the constant sequence 3 converges to 3" unfolding ConvergesTo :
  ConvergesTo (fun _ => 3) 3
-- divergence
#expect_false "the constant sequence 3 does not diverge" unfolding Diverges ConvergesTo :
  Diverges (fun _ => 3)
#expect_false "7, 7, 7, 7, 7, 0, 0, 0, … does not diverge" unfolding Diverges ConvergesTo :
  Diverges (fun n => if n < 5 then 7 else 0)
#expect_true "0, 1, 0, 1, … diverges" unfolding Diverges ConvergesTo :
  Diverges (fun n => if n % 2 = 0 then 0 else 1)
#expect_true "0, 1, 2, 3, … diverges" unfolding Diverges ConvergesTo :
  Diverges (fun n => (n : ℝ))
-- cluster values
#expect_true "3 is a cluster value of the constant sequence 3" unfolding ClusterValue :
  ClusterValue (fun _ => 3) 3
#expect_false "4 is not a cluster value of the constant sequence 3" unfolding ClusterValue :
  ClusterValue (fun _ => 3) 4
#expect_true "0 is a cluster value of 0, 1, 0, 1, …" unfolding ClusterValue :
  ClusterValue (fun n => if n % 2 = 0 then 0 else 1) 0
#expect_true "1 is a cluster value of 0, 1, 0, 1, …" unfolding ClusterValue :
  ClusterValue (fun n => if n % 2 = 0 then 0 else 1) 1
#expect_false "2 is not a cluster value of 0, 1, 0, 1, …" unfolding ClusterValue :
  ClusterValue (fun n => if n % 2 = 0 then 0 else 1) 2
#expect_false "7 is not a cluster value of 7, 7, 7, 7, 7, 0, 0, 0, …" unfolding ClusterValue :
  ClusterValue (fun n => if n < 5 then 7 else 0) 7
#expect_false "0, 1, 2, 3, … has no cluster value 0" unfolding ClusterValue :
  ClusterValue (fun n => (n : ℝ)) 0

#level_report
