/- Hidden test battery for Level Spot the bug: connectives. -/
import LeanCraftGame.Referee
import LeanCraftGame.L11.Player

namespace L11Ref
def InRange (n : Nat) : Prop := 13 ≤ n ∨ n ≤ 19
def IsComposite (n : Nat) : Prop := ¬ Nat.Prime n
def Coprime (a b : Nat) : Prop := ¬ (2 ∣ a ∧ 2 ∣ b)
def BothOdd (a b : Nat) : Prop := ¬ a % 2 = 0 ∧ b % 2 = 0
end L11Ref

#no_sorry L11.r
#no_sorry L11.c
#no_sorry L11.ca
#no_sorry L11.cb
#no_sorry L11.oa
#no_sorry L11.ob
#level_start "Spot the bug: connectives"

#expect_true "InRange accepts r" unfolding L11Ref.InRange L11.r :
  L11Ref.InRange L11.r
#expect_true "r is not between 13 and 19" unfolding L11.r :
  ¬ (13 ≤ L11.r ∧ L11.r ≤ 19)
#expect_true "IsComposite accepts c" unfolding L11Ref.IsComposite L11.c :
  L11Ref.IsComposite L11.c
#expect_true "c is not composite (it is not a product of two numbers greater than 1)" unfolding L11.c :
  ¬ (∃ x < 20, ∃ y < 20, 1 < x ∧ 1 < y ∧ x * y = L11.c)
#expect_true "Coprime accepts ca and cb" unfolding L11Ref.Coprime L11.ca L11.cb :
  L11Ref.Coprime L11.ca L11.cb
#expect_true "ca and cb have a common factor greater than 1" unfolding L11.ca L11.cb :
  Nat.gcd L11.ca L11.cb ≠ 1
#expect_true "oa and ob are both odd" unfolding L11.oa L11.ob :
  L11.oa % 2 = 1 ∧ L11.ob % 2 = 1
#expect_true "BothOdd rejects oa and ob" unfolding L11Ref.BothOdd L11.oa L11.ob :
  ¬ L11Ref.BothOdd L11.oa L11.ob

#level_report
