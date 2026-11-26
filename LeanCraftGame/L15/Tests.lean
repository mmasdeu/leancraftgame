/- Hidden test battery for Level 15: Set notation. -/
import LeanCraftGame.Referee
import LeanCraftGame.L15.Player

open L15

#no_sorry evens
#no_sorry primes
#no_sorry oddPrimes
#no_sorry multiples
#no_sorry fourOrSix
#no_sorry q1
#no_sorry q2
#level_start "Set notation"

#expect_choice "Question 1: how to read `s ∩ (t ∪ u)`" : q1 = 1
#expect_choice "Question 2: what `⋂ i : ℕ, Set.Ici i` is" : q2 = true
#expect_true "6 ∈ evens" unfolding evens : 6 ∈ evens
#expect_false "7 ∈ evens" unfolding evens : 7 ∈ evens
#expect_true "7 ∈ primes" unfolding primes : 7 ∈ primes
#expect_false "1 ∈ primes" unfolding primes : 1 ∈ primes
#expect_true "3 ∈ oddPrimes" unfolding oddPrimes primes evens : 3 ∈ oddPrimes
#expect_false "2 ∈ oddPrimes" unfolding oddPrimes primes evens : 2 ∈ oddPrimes
#expect_false "9 ∈ oddPrimes" unfolding oddPrimes primes evens : 9 ∈ oddPrimes
#expect_true "12 ∈ multiples 4" unfolding multiples : 12 ∈ multiples 4
#expect_false "4 ∈ multiples 12" unfolding multiples : 4 ∈ multiples 12
#expect_true "18 ∈ fourOrSix" unfolding fourOrSix multiples : 18 ∈ fourOrSix
#expect_true "8 ∈ fourOrSix" unfolding fourOrSix multiples : 8 ∈ fourOrSix
#expect_false "10 ∈ fourOrSix" unfolding fourOrSix multiples : 10 ∈ fourOrSix

#level_report
