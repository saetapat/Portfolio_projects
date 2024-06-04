# Create game function 
game <- function() {
    ## assign score variables 
    user_score <- 0
    com_score <- 0
    ## game introduction
    flush.console()
    username <- readline( "what is your name: ")
    print("Hi, player")
    print (" Welcome to rock paper scissor game")

    while ( 1 > 0 ) {
    hands <- c("rock","paper","scissor")
    com_hand <- sample(hands,1)
    flush.console()
    user_hand <- readline("Choose you hand: ")

        if (user_hand == "quit") {
            break
        }

        ## game condition

        if (user_hand == "rock" & com_hand == "paper") {
            com_score = com_score + 1
           print (paste("you:", user_hand," ","bot:", com_hand))
        } else if ( user_hand == "rock" & com_hand == "scissor")  {
            user_score = user_score + 1
            print( paste("you:", user_hand," ","bot:", com_hand))
        }  else if (user_hand == "paper" & com_hand == "rock")   {
            user_score = user_score + 1
            print( paste("you:", user_hand," ","bot:", com_hand))
        } else if (user_hand == "paper" & com_hand == "scissor") {
            com_score = com_score + 1
            print( paste("you:", user_hand," ","bot:", com_hand))
        } else if (user_hand == "scissor" & com_hand == "rock")  {
            com_score = com_score +1
            print( paste("you:", user_hand," ","bot:", com_hand))
        } else if (user_hand == "scissor" & com_hand == "paper") {
            user_score = user_score + 1
            print( paste("you:", user_hand," ","bot:", com_hand))
        } else if (user_hand == com_hand) {
            print( paste("you:", user_hand," ","bot:", com_hand))
        }
    print ( paste ("your score is:",user_score))
    print ( paste ("bot score is:",com_score))
    }

    ## quit state
    print ( "YOU QUIT GAME")
    print ( paste ("your final score is:",user_score))
    print ( paste ("bot final score is:",com_score))
    ## score 
    if (user_score > com_score) {
        print ("You WINNN")
    } else if (user_score < com_score) {
        print ("YOU LOSEE")
    } else if (user_score == com_score) {
        print ("HOLY SHIT IT'S EVEN")
    }
}
