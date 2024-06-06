local Translations = {
    notify = {
        pressButton                 = 'Presiona [E] para hablar',
        pressButtonDeliver          = 'Presiona [E] para entregar el vehiculo',
        gpsCoords                   = 'Te he marcado las coordenadas en el GPS',
        gpsNewCoords                = 'Te he marcado la nueva ubicacion en el GPS',
        jobPolice                   = 'Fuera de aqui basura',

        errorNil                    = 'Error inesperado',
        availableMission            = 'Pasate mas tarde, estoy ocupado ahora mismo',
        noCops                      = 'No hay suficientes policias en linea',

        payText1                    = 'Buen trabajo amigo, aqui tienes ',
        payText2                    = ' € de recompensa. Ya sabes donde encontrarme',
    },
    menu = {

        headerMenu                  = 'Mision de robar coche',
        easyMenu                    = 'Robo Facil',
        middleMenu                  = 'Robo Medio',
        hardMenu                    = 'Robo Dificil',

        easyDescription             = 'Un atraco con pocas complicaciones.',
        middleDescription           = '¿Que te pensabas, que iba ser un camino de rosas?',
        hardDescription             = 'Demustra de lo que eres capaz, no creo que lo consigas.',
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})