local QBCore = exports['qb-core']:GetCoreObject()

-- アイテムを与える
RegisterServerEvent("lumberjack:giveItems")
AddEventHandler("lumberjack:giveItems", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        for _, item in ipairs(Config.ChoppedItems) do
            Player.Functions.AddItem(item.name, item.amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "add", item.amount)
        end
    end
end)

-- アイテムを売る
RegisterServerEvent("lumberjack:sellItems")
AddEventHandler("lumberjack:sellItems", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        local woodItem = Player.Functions.GetItemByName("wood")
        local barkItem = Player.Functions.GetItemByName("bark")
        local totalPayment = 0

        if woodItem then
            local woodPayment = woodItem.amount * Config.WoodPrice
            Player.Functions.RemoveItem("wood", woodItem.amount)
            totalPayment = totalPayment + woodPayment
        end

        if barkItem then
            local barkPayment = barkItem.amount * Config.BarkPrice
            Player.Functions.RemoveItem("bark", barkItem.amount)
            totalPayment = totalPayment + barkPayment
        end

        if totalPayment > 0 then
            Player.Functions.AddMoney("cash", totalPayment)
            TriggerClientEvent('QBCore:Notify', src, '木材を' .. totalPayment .. 'ドルで売却しました', 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, '売却できる木材がありません', 'error')
        end
    end
end)