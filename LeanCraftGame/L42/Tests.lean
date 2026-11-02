/- Hidden test battery for Level Cluster values. -/
import LeanCraftGame.Referee
import LeanCraftGame.L42.Player

open L42

#no_sorry ClusterValue
#no_sorry IsSubseqLimit
#level_start "Cluster values"

-- the worked example
#expect_true "the constant sequence 3 converges to 3" unfolding ConvergesTo :
  ConvergesTo (fun _ => 3) 3
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
-- subsequences
#expect_true "the even terms of 0, 1, 0, 1, … converge to 0" unfolding IsSubseqLimit ConvergesTo :
  IsSubseqLimit (fun n => if n % 2 = 0 then 0 else 1) (fun n => 2 * n) 0
#expect_true "the odd terms of 0, 1, 0, 1, … converge to 1" unfolding IsSubseqLimit ConvergesTo :
  IsSubseqLimit (fun n => if n % 2 = 0 then 0 else 1) (fun n => 2 * n + 1) 1
#expect_false "the even terms of 0, 1, 0, 1, … do not converge to 1" unfolding IsSubseqLimit ConvergesTo :
  IsSubseqLimit (fun n => if n % 2 = 0 then 0 else 1) (fun n => 2 * n) 1
#expect_false "φ n = 0 is not a subsequence: it is not strictly increasing" unfolding IsSubseqLimit ConvergesTo :
  IsSubseqLimit (fun n => if n % 2 = 0 then 0 else 1) (fun _ => 0) 0
#expect_false "φ n = n / 2 repeats terms: it is not strictly increasing" unfolding IsSubseqLimit ConvergesTo :
  IsSubseqLimit (fun _ => 3) (fun n => n / 2) 3
#expect_true "the terms of 7, 7, 7, 7, 7, 0, 0, 0, … from index 1 on converge to 0" unfolding IsSubseqLimit ConvergesTo :
  IsSubseqLimit (fun n => if n < 5 then 7 else 0) (fun n => n + 1) 0

#level_report
