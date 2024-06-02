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
                TriggerClientEvent('QBCore:Notify', _source, "error inesperado", 'error', 5000) -- Debug test
            end
        else

            TriggerClientEvent('QBCore:Notify', _source, "Pasate mas tarde, estoy ocupado ahora mismo", "error", 5000)

        end
        

    else
        TriggerClientEvent('QBCore:Notify', _source, "No hay suficientes policias en linea", 'error', 5000)
    end
end)


function OcuppedMission()
    local timeOff =  Config.timeOff * 1000
    availableMission = false
    Wait(timeOff)
    availableMission = true
end