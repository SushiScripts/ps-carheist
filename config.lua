Config = {}

Config.Difficult = {
    ['easy'] =
     {
        minMoney = 15000,               -- Minimum money you get from the mission
        maxMoney = 30000,           -- Max money you get from the mission
        amount = 15,                -- Amount the enemy weapon
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
        amount = 30,
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
        amount = 50,
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

Config.pedModelPoint = 'CSB_Bogdan' -- Hash ped point.
--Config.pedModelLocation = 'mp_s_m_armoured_01' -- Hash ped point heist car.
Config.pedLocation = vector4(-951.04, -3056.05, 13.95, 59.64)
Config.vehiclePoint = vector4(-1240.16, -2270.2, 13.39, 108.78)

Config.timeOff = 1800000  -- Time off (In ms)
Config.marketMoney = false
--Config.vehicleModel = 'btype3' --Hash vehicle.

--[[ Config.weaponModelEasy = '' -- Weapon model to ped in diffucult easy
Config.weaponModelMiddle = '' -- Weapon model to ped in diffucult middle
Config.weaponModelHard = '' -- Weapon model to ped in diffucult hard ]]



