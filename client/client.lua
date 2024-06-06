local QBCore = exports['qb-core']:GetCoreObject() --Qbcore
local PlayerJob = nil
local pedPlayer = nil
local ped = nil
local controlMenu = false
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

RegisterNetEvent('ps-carheist:client:startMision')
AddEventHandler('ps-carheist:client:startMision', function (difficult)
    spawnEnemys(difficult)
end)

function crearPed()
    
    local pedModel = Config.peds['StartMission'].pedModel
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
    ped = CreatePed(0, pedModel, Config.peds['StartMission'].pedLocation.x, Config.peds['StartMission'].pedLocation.y, Config.peds['StartMission'].pedLocation.z - 1, Config.peds['StartMission'].pedLocation.w, true, true)
    pedChop = CreatePed(0, pedChopModel, Config.peds['StartMission'].pedLocation.x, Config.peds['StartMission'].pedLocation.y - 0.5, Config.peds['StartMission'].pedLocation.z - 1, Config.peds['StartMission'].pedLocation.w, true, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped, animDic, 'base', 2.0, 2.0, 1000000, 51, 0, false, true, false)
    
    -- Chop
    FreezeEntityPosition(pedChop, true)
    SetEntityInvincible(pedChop, true)
    SetBlockingOfNonTemporaryEvents(pedChop, true)

    -- Message

    local zone= BoxZone:Create(Config.peds['StartMission'].pedLocation.xyz, Config.peds['StartMission'].zoneOptions.Width, Config.peds['StartMission'].zoneOptions.Height, 
    {
        name='zone_startMission',
        debugPoly= Config.peds['StartMission'].zoneOptions.debug,
    })
    zone:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            
            exports['qb-core']:DrawText(Lang:t('notify.pressButton'), 'left')
            ListenControl()

        else
            exports["qb-core"]:HideText() 
            controlMenu = false
        end
    end)
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
    TriggerEvent('QBCore:Notify', Lang:t('notify.gpsCoords'), 'primary', 5000)
end


function spawnCar(difficult)
    
    local configLocal = Config.Difficult[difficult]

    while not HasModelLoaded(configLocal.car) do
        RequestModel(configLocal.car)
        Wait(100)
    end

    vehicle = CreateVehicle(configLocal.car, Config.vehiclePoint.x, Config.vehiclePoint.y, Config.vehiclePoint.z, Config.vehiclePoint.w, true, true)

    local zone2 = CircleZone:Create(Config.vehiclePoint.xyz, 2, {
        name='zone_carHeist',
        debugPoly=false,
        useZ = true,
    })
    
    zone2:onPlayerInOut(function(isPointInside, point)
        
        if isPointInside then

            TriggerEvent('QBCore:Notify', Lang:t('notify.gpsNewCoords'), 'primary', 5000)
            TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(vehicle))

            RemoveBlip(blip)

            createBlips(Config.deliverCar.xyz)

            local zoneCar = CircleZone:Create(Config.deliverCar.xyz, 3, {
                name='zone_deliverCar',
                debugPoly=false,
                useZ = true,
            })
            zoneCar:onPlayerInOut(function(isPointInside, point)
                
                if isPointInside then
                    controlMenu = true
                    exports['qb-core']:DrawText(Lang:t('notify.pressButtonDeliver'), 'left')

                    CreateThread(function()
                        while controlMenu do
                            if IsControlJustReleased(0, 38) then

                                controlMenu = false
                                Wait(1000)
                                TaskLeaveVehicle(pedPlayer, vehicle, 0)
                                Wait(2000)
                                SetVehicleDoorsLocked(vehicle, 2)
                                Wait(5000)
                                DeleteEntity(vehicle)
                                RemoveBlip(blip)
                                TriggerServerEvent('ps-carheist:server:PayContract', difficult)
                            end
                            Wait(1)
                        end
                    end)
                else
                    exports["qb-core"]:HideText() 
                end
            end)
        else
        end
    end)
end

function ListenControl()
    controlMenu = true
    CreateThread(function()
        
        while controlMenu do
            
            if IsControlJustReleased(0, 38) then
                if PlayerJob.name == "police" then
                    TriggerEvent('QBCore:Notify', Lang:t('notify.jobPolice'), "error", 5000)
                    exports['qb-core']:HideText()
                    Wait(5000)
                else
                        TriggerEvent('ps-carheist:client:ShowMenu')
                end
            end
            Wait(1)
        end
    end)
end

RegisterNetEvent('ps-carheist:client:ShowMenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t('menu.headerMenu'),
            icon = 'fa-solid fa-gun',
            isMenuHeader = true, 
        },
        {
            header = Lang:t('menu.easyMenu'),
            txt = Lang:t('menu.easyDescription'),
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
            header = Lang:t('menu.middleMenu'),
            txt = Lang:t('menu.middleDescription'),
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
            header = Lang:t('menu.hardMenu'),
            txt = Lang:t('menu.hardDescription'),
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
end)

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
        RemoveBlip(blip)
        DeleteEntity(vehicle)

        
   end
end)



AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
        
    crearPed()
    PlayerJob = QBCore.Functions.GetPlayerData().job
   end
end)

