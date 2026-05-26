local QBCore = exports["qb-core"]:GetCoreObject()

local function Notify(msg, nType)
    lib.notify({
        description = Locale(msg),
        type = nType or 'inform'
    })
end

local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

-- ox_target / qb-target
if target == "ox_target" then 
    exports.ox_target:addModel(mursteiner, {
        {
            label = Locale('pickup'),
            name = "murstein1",
            useZ = true,
            event = "plukkoppmur",
            icon = "fa fa-signing",
            distance = 2.5
        },
    })

    exports.ox_target:addGlobalVehicle({
        {
            label = Locale('plasserpedal'),
            name = 'murstein',
            icon = 'fa fa-signing',
            distance = 3.5,
            onSelect = function(data)
                if not DoesEntityExist(data.entity) then return end
                TriggerEvent("banngass")
            end,
        }
    })
else
    exports['qb-target']:AddTargetModel(mursteiner, {
        options = {
            {
                event = 'plukkoppmur',
                icon = 'fa fa-signing',
                label = Locale('pickup'),
            },
        },
        distance = 2.5
    })

    if useitem == false then 
        exports['qb-target']:AddGlobalVehicle({
            options = { 
                { 
                    type = "client", 
                    icon = 'fa fa-signing', 
                    label = Locale('plasserpedal'),
                    item = itemname,
                    canInteract = function(entity, distance, data)
                        return DoesEntityExist(entity)
                    end,
                    action = function(entity)
                        TriggerEvent("banngass")
                    end
                }
            },
            distance = 3.5, 
        })
    end
end

-- pickup event
RegisterNetEvent("plukkoppmur", function()
    local playerPed = cache.ped

    loadAnimDict("pickup_object")
    TaskPlayAnim(playerPed, "pickup_object", "pickup_low", 1.0, -1.0, -1, 2, 1, true, true, true)

    Wait(2000)
    ClearPedTasks(playerPed)

    TriggerServerEvent("girmur")
end)

-- main logic
RegisterNetEvent("banngass", function()
    local playerPed = cache.ped

    local hasItem = false

    if Config.inv == "ox_inventory" then
        local count = exports.ox_inventory:Search('count', itemname)
        hasItem = (count and count > 0)
    else
        hasItem = QBCore.Functions.HasItem(itemname, 1)
    end

    local coords = GetEntityCoords(playerPed)
    local vehicle = QBCore.Functions.GetClosestVehicle(coords)

    if not vehicle or vehicle == 0 then return end

    local vehCoords = GetEntityCoords(vehicle)
    local distance = #(coords - vehCoords)

    local doorLock = GetVehicleDoorLockStatus(vehicle)

    if not hasItem then 
        Notify('missingbrick', 'error')
        return 
    end

    if doorLock == 2 then 
        Notify('locked', 'error')
        return 
    end

    if distance < 3.5 then 
        SetVehicleDoorOpen(vehicle, 0, false, true)

        loadAnimDict("pickup_object")
        TaskPlayAnim(playerPed, "pickup_object", "pickup_low", 1.0, -1.0, -1, 2, 1, true, true, true)

        Wait(2000)

        TriggerServerEvent("fjemur")

        ClearPedTasks(playerPed)

        SetVehicleDoorShut(vehicle, 0, false)

        SetVehicleEngineOn(vehicle, true, true, false)

        Wait(1000)

        Notify('placedonpedal', 'success')

        TaskVehicleTempAction(playerPed, vehicle, 32, 15000)

        if breakcar then 
            CreateThread(function()
                while true do
                    Wait(10)

                    if HasEntityCollidedWithAnything(vehicle) then 
                        SetVehicleEngineOn(vehicle, false, false, false)
                        SetVehicleEngineHealth(vehicle, 0)
                        SetVehicleUndriveable(vehicle, true)
                        break
                    elseif loopabreaka then
                        break
                    end
                end
            end)

            Wait(15000)
            loopabreaka = true
        end
    else
        Notify('close', 'error')
    end
end)