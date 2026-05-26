local QBCore = exports["qb-core"]:GetCoreObject()

-- Helper: item adding
local function AddItem(src, item, amount)
    if Config.inv == "ox_inventory" then
        exports.ox_inventory:AddItem(src, item, amount)
    else
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.AddItem(item, amount)
        end
    end
end

-- Helper: item removal
local function RemoveItem(src, item, amount)
    if Config.inv == "ox_inventory" then
        exports.ox_inventory:RemoveItem(src, item, amount)
    else
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.RemoveItem(item, amount)
        end
    end
end

RegisterNetEvent("girmur", function()
    local src = source
    if not src then return end

    AddItem(src, itemname, 1)
end)


RegisterNetEvent("fjemur", function()
    local src = source
    if not src then return end

    RemoveItem(src, itemname, 1)
end)

-- QBCore usable item
if Config.framework == "qb" then
    QBCore.Functions.CreateUseableItem(itemname, function(source)
        TriggerClientEvent("banngass", source)
    end)
end