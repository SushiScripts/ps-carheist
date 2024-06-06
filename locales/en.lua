local Translations = {
    notify = {
        pressButton                 = 'Press [E] to speak',
        pressButtonDeliver          = 'Press [E] to deliver the vehicle.',
        gpsCoords                   = 'I have marked the coordinates in the GPS for you.',
        gpsNewCoords                = 'I have marked the new location in the GPS for you',
        jobPolice                   = 'Get out of here trash',

        errorNil                    = 'Unexpected error',
        availableMission            = 'Drop by later, Im busy right now',
        noCops                      = 'Not enough cops on the line',

        payText1                    = 'Good job buddy, here you go ',
        payText2                    = ' € reward. You know where to find me',
    },
    menu = {

        headerMenu                  = 'Mission to steal a car',
        easyMenu                    = 'Easy Robbery',
        middleMenu                  = 'Medium Robbery',
        hardMenu                    = 'Robbery Difficult',

        easyDescription             = 'A heist with few complications.',
        middleDescription           = 'What did you think, it was going to be a bed of roses?',
        hardDescription             = "Show what you're capable of, I don't think you'll get it.",
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})