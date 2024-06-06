local QBCore = exports['qb-core']:GetCoreObject()
local availableMission = true

RegisterNetEvent('ps-carheist:server:policiasActivos')
AddEventHandler('ps-carheist:server:policiasActivos', function (data)
    
    local copsOnDuty = 0
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local dificultad = data.difficult 

    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local player = QBCore.Functions.GetPlayer(v)
        if player ~= nil then
            if player.PlayerData.job.name == "police" and player.PlayerData.onduty then

                copsOnDuty = copsOnDuty + 1
            end
        end
    end
    if copsOnDuty >= Config.copsRequired then
        if availableMission == true then
            
            --TriggerClientEvent('QBCore:Notify', _source, "La misión va comenzar", 'success', 5000) -- Debug test
            -- LLamar al evento que inicia la misión
            
            if dificultad == "easy" then
                
                -- Code easy
                TriggerClientEvent('ps-carheist:client:startMision', _source, dificultad)
                OcuppedMission()
            elseif dificultad == "middle" then
                
                -- Code middle
                TriggerClientEvent('ps-carheist:client:startMision', _source, dificultad)
                OcuppedMission()
            elseif dificultad == "hard" then

                -- Code hard
                TriggerClientEvent('ps-carheist:client:startMision', _source, dificultad)
                OcuppedMission()
            else
                TriggerClientEvent('QBCore:Notify', _source, Lang:t('notify.errorNil'), 'error', 5000) -- Debug test
            end
        else

            TriggerClientEvent('QBCore:Notify', _source,  Lang:t('notify.availableMission'), "error", 5000)

        end
        

    else
        TriggerClientEvent('QBCore:Notify', _source, Lang:t('notify.noCops'), 'error', 5000)
    end
end)


RegisterNetEvent('ps-carheist:server:PayContract')
AddEventHandler('ps-carheist:server:PayContract', function (data)
    
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local payContract = math.random(Config.Difficult[data].minMoney, Config.Difficult[data].maxMoney)
    TriggerClientEvent('QBCore:Notify', source, Lang:t('notify.payText1') .. payContract .. Lang:t('notify.payText2'), 'primary', 5000)
    xPlayer.Functions.AddMoney('cash', payContract, "Mission")

end)


function OcuppedMission()
    local timeOff =  Config.timeOff * 1000
    availableMission = false
    Wait(timeOff)
    availableMission = true
end