Config = {}

Config.Difficult = {
    ['easy'] =
     {
        minMoney = 15000,               -- Minimum money you get from the mission
        maxMoney = 30000,           -- Max money you get from the mission
        amount = 8,                -- Amount the enemy weapon
        weapon = 'WEAPON_PISTOL',   -- Enemy weapon
        ammoWeapon = 50,            -- Amout to ammo of the enemys
        hasVest = false,            -- has a bulletproof vest
        car = 'ninef2',                   -- Vehicle of the mission.
        radius = 30,                --Enemy spawn radius, the smaller the number, the more the vehicle's spawn radius appears.
        accuracy = 40,              -- Enemy accuracy 
        enemysModel = {             -- Enemy models
            'IG_BallasOG',
            'G_M_Y_BallaSout_01',
            'CSB_Ballas_Leader',
            'G_F_Y_ballas_01'
        }
    },
    ['middle'] =
    {
        minMoney = 50000,
        maxMoney = 80000,
        amount = 10,
        weapon = 'WEAPON_MICROSMG',
        ammoWeapon = 100,
        hasVest = true,
        car = 'btype3',    
        radius = 40,
        accuracy = 60,
        enemysModel = {
            'IG_Security_A',
            'CSB_VagSpeak',
            'IG_G',
            'IG_Popov',
            'CSB_MP_Agent14'
        }
    },
    ['hard'] =
    {
        minMoney = 100000,
        maxMoney = 150000,
        amount = 20,
        weapon = 'WEAPON_ASSAULTRIFLE',
        ammoWeapon = 120,
        hasVest = true,
        car = 'tezeract',    
        radius = 75,
        accuracy = 80,
        enemysModel = {
            'S_M_Y_BlackOps_01',
            'S_M_Y_BlackOps_02',
            'MP_M_WeapExp_01',
            'CSB_Ramp_marine',
            'S_M_M_Marine_01',
            'S_M_Y_Marine_03'
        }
    }
}

Config.peds = {
    ['StartMission'] = 
    {
        pedModel = 'CSB_Bogdan',
        pedLocation = vector4(749.67, -1706.84, 29.18, 146.13),
        zoneOptions = 
        {
            Height = 3.0,
            Width = 3.0,
            debug = false
        }
    }
}

Config.deliverCar = vector3(761.92, -1866.08, 28.81)


Config.vehiclePoint = vector4(-1240.16, -2270.2, 13.39, 108.78)

Config.timeOff = 1800 -- Seconds // Default: 1800 Seconds = 30 minutes.
Config.marketMoney = false
Config.copsRequired = 0    -- Minimum cops required for mision start

Config.blips = {

    ['vehiclePoint'] = 
    {
        coords = 0,
        sprite = 0,
        color = 0,
        routeColor = 0
        --shotRange = true
    },
    ['sellerPoint'] =
    {
        coords = 0,
        sprite = 0,
        color = 0,
        routeColor = 0
        --shotRange = true
    }

}



