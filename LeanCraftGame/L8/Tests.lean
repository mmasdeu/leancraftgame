/- Hidden test battery for Level Or and not. -/
import LeanCraftGame.Referee
import LeanCraftGame.L9.Player

open L9

#no_sorry FreeTicket
#no_sorry PaysFull
#no_sorry NotTiny
#level_start "Or and not"

#expect_true "FreeTicket 3 is true" unfolding FreeTicket :
  FreeTicket 3
#expect_true "FreeTicket 70 is true" unfolding FreeTicket :
  FreeTicket 70
#expect_true "FreeTicket 65 is true" unfolding FreeTicket :
  FreeTicket 65
#expect_false "FreeTicket 30 is false" unfolding FreeTicket :
  FreeTicket 30
#expect_false "FreeTicket 5 is false" unfolding FreeTicket :
  FreeTicket 5
#expect_true "PaysFull 30 is true" unfolding PaysFull FreeTicket :
  PaysFull 30
#expect_true "PaysFull 5 is true" unfolding PaysFull FreeTicket :
  PaysFull 5
#expect_false "PaysFull 3 is false" unfolding PaysFull FreeTicket :
  PaysFull 3
#expect_false "PaysFull 65 is false" unfolding PaysFull FreeTicket :
  PaysFull 65
#expect_true "NotTiny 5 is true" unfolding NotTiny :
  NotTiny 5
#expect_true "NotTiny 2 is true" unfolding NotTiny :
  NotTiny 2
#expect_false "NotTiny 0 is false" unfolding NotTiny :
  NotTiny 0
#expect_false "NotTiny 1 is false" unfolding NotTiny :
  NotTiny 1

#level_report
