
# Create chat bot function
chatbot_factory <- function() {
  cost <- 0
  coffee_price <- c(230,250)
  
  ## introduction
  username <- readline("what is you name sir/madame?")
  print(paste("Hi",username,"how can i help you today?"))
  
  ## input into while loop
  while (TRUE) {
    order <- readline("what do you want for today?")
    
    ## for coffee order
    if (order == "coffee") {
      coffee_order <- readline("what coffee do you want?")
       
      if (coffee_order == "latte") {
         print(paste("latte would be",coffee_price[1],"bath"))
         cost <- cost + coffee_price[1]
       }
      if (coffee_order =="americano") {
         print(paste("americano would be",coffee_price[2],"bath"))
        cost <- cost + coffee_price[2]
      }
    }
    
    checkout <- readline("Do you want to check?")
    if (checkout == "yes") {
        print(paste("all order would be",cost))
        print("thank you for your order!")
    break 
          } else if (checkout == "no") {
      next
    }
    
    ## when no order
    if ( order == 'no') {
      print("No problem, have a nice day sir/madame")
      break
    }
 
  }
}
