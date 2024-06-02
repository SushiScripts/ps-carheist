local QBCore = exports['qb-core']:GetCoreObject() --Qbcore
local PlayerJob = nil
local pedPlayer = nil
local ped = nil
local pedChop = nil
local difficult = nil
local vehicle = nil
local blip = nil


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    crearPed()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    print(PlayerJob.name)
end)

CreateThread(function ()
    while true do
        local player = PlayerPedId()
        local pos = #(GetEntityCoords(player) - vector3(Config.pedLocation.x, Config.pedLocation.y, Config.pedLocation.z))
        if pos <= 1  then
            -- body
            exports['qb-core']:DrawText("Presiona [E] para hablar", 'left')

            if IsControlJustReleased(0, 38) then
                if PlayerJob.name == "police" then
                    TriggerEvent('QBCore:Notify', "Fuera de aqui basura", "error", 5000)
                    exports['qb-core']:HideText()
                    Wait(5000)
                else
                        exports['qb-menu']:openMenu({
                            {
                                header = 'Mision de robar coche',
                                icon = 'fa-solid fa-gun',
                                isMenuHeader = true, 
                            },
                            {
                                header = 'Atraco Facil',
                                txt = 'Un atraco con pocas complicaciones.',
                                icon = 'fa-solid fa-egg',
                                params = {
                                    isServer = true,
                                    event = 'ps-carheist:server:policiasActivos',
                                    args = {
                                        difficult = "easy"
                                    }
                                }
                            },  
                            {
                                header = 'Atraco Medio',
                                txt = '¿Que te pensabas, que iba ser un camino de rosas?',
                                icon = 'fa-solid fa-hand-middle-finger',
                                params = {
                                    isServer = true,
                                    event = 'ps-carheist:server:policiasActivos',
                                    args = {
                                        difficult = "middle"
                                    }
                                }
                            }, 
                            {
                                header = 'Atraco Dificil',
                                txt = 'Demustra de lo que eres capaz, no creo que lo consigas.',
                                icon = 'fa-solid fa-explosion',
                                params = {
                                    isServer = true,
                                    event = 'ps-carheist:server:policiasActivos',
                                    args = {
                                        difficult = "hard"
                                    }
                                }
                            }
                        })
                end
            end
        else
            exports['qb-core']:HideText()
        end
        Wait(0)
    end
end)

RegisterNetEvent('ps-carheist:client:startMision')
AddEventHandler('ps-carheist:client:startMision', function (difficult)
    spawnEnemys(difficult)
end)

function crearPed()
    
    local pedModel = Config.pedModelPoint
    local pedChopModel = 'A_C_Husky'
    local animDic = 'rcmnigel1a'
    while not HasModelLoaded(pedModel) do
        RequestModel(pedModel)
        Wait(100)
    end
    while not HasAnimDictLoaded(animDic) do
        RequestAnimDict(animDic)
        Wait(100)
    end

    while not HasModelLoaded(pedChopModel) do
        RequestModel(pedChopModel)
        Wait(100)
    end

    -- Ped
    ped = CreatePed(0, pedModel, Config.pedLocation.x, Config.pedLocation.y, Config.pedLocation.z - 1, Config.pedLocation.w, true, true)
    pedChop = CreatePed(0, pedChopModel, Config.pedLocation.x, Config.pedLocation.y - 0.5, Config.pedLocation.z - 1, Config.pedLocation.w, true, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped, animDic, 'base', 2.0, 2.0, 1000000, 51, 0, false, true, false)
    
    -- Chop
    FreezeEntityPosition(pedChop, true)
    SetEntityInvincible(pedChop, true)
    SetBlockingOfNonTemporaryEvents(pedChop, true)
end

function spawnEnemys(difficult)

    local configLocal = Config.Difficult[difficult]

    for i, value in ipairs(configLocal.enemysModel) do
        RequestModel(value)
    end

    pedPlayer = PlayerPedId()

    AddRelationshipGroup('DEFENDERS')
    SetPedRelationshipGroupHash(pedPlayer, GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(0, GetHashKey('DEFENDERS'), GetHashKey('DEFENDERS'))
    SetRelationshipBetweenGroups(5, GetHashKey('DEFENDERS'), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(5, GetHashKey('PLAYER'), GetHashKey('DEFENDERS'))

    for i = 1, configLocal.amount do
        local position = RandomPosition(vector4(-1231.73, -2275.7, 13.94, 239.66), configLocal.radius)

        local defender = CreatePed(0, configLocal.enemysModel[1], position.x, position.y, position.z, position.w, true, false)
        
        SetPedRelationshipGroupHash(defender, GetHashKey('DEFENDERS'))
        SetPedAccuracy(defender, configLocal.accuracy)
        SetPedFleeAttributes(defender, 0, false)
        GiveWeaponToPed(defender, configLocal.weapon, configLocal.ammoWeapon, false, true)
        SetPedDropsWeaponsWhenDead(defender, false)
        TaskGuardCurrentPosition(defender, 10.0, 10.0, true)
        
        if configLocal.hasVest then
            SetPedArmour(defender, 100)
        end

        availableMission = false
    end
    spawnCar(difficult)
    createBlips(Config.vehiclePoint)
    TriggerEvent('QBCore:Notify', "Te he marcado las coordenadas en el GPS", 'success', 5000)
end

function spawnCar(difficult)
    
    local configLocal = Config.Difficult[difficult]

    while not HasModelLoaded(configLocal.car) do
        RequestModel(configLocal.car)
        Wait(100)
    end

    vehicle = CreateVehicle(configLocal.car, Config.vehiclePoint.x, Config.vehiclePoint.y, Config.vehiclePoint.z, Config.vehiclePoint.w, true, true)
end

function createBlips(coords)
    
    blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 229)
    SetBlipColour(blip, 59)
    SetBlipRoute(blip, true)
    SetBlipAsShortRange(blip, true)
    SetBlipRouteColour(blip, 59)
end

-- Get random position to peds.
function RandomPosition(center, radius)
    local angle = math.rad(math.random(0, 360))
    local offsetX = (math.max(0.5, math.random()) * radius) * math.cos(angle)
    local offsetY = (math.max(0.5, math.random()) * radius) * math.sin(angle)

    local randomPosition = vector4(center.x + offsetX, center.y + offsetY, center.z, center.w + offsetX)
    return randomPosition
end

AddEventHandler('onResourceStop', function(resource)
   if resource == GetCurrentResourceName() then
      
        ped = nil
        pedChop = nil
        difficult = nil
        blip = nil
        DeleteEntity(vehicle)

        
   end
end)

AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
        
    crearPed()
    PlayerJob = QBCore.Functions.GetPlayerData().job
   end
end)

