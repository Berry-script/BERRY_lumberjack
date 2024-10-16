local QBCore = exports['qb-core']:GetCoreObject()
local spawnedTrees = {}
local cooldowns = {}

-- 木をスポーンする関数
local function SpawnTree(treeData)
    local model = GetHashKey(treeData.model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    local tree = CreateObject(model, treeData.coords.x, treeData.coords.y, treeData.coords.z, false, true, false)
    FreezeEntityPosition(tree, true)
    return tree
end

-- 木を切る関数
local function ChopTree(treeIndex)
    local treeData = Config.Trees[treeIndex]
    if cooldowns[treeIndex] and cooldowns[treeIndex] > GetGameTimer() then
        QBCore.Functions.Notify("この木はまだ切れません。", "error")
        return
    end

    QBCore.Functions.Progressbar("chopping_tree", "木を切っています...", Config.ChoppingTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "melee@large_wpn@streamed_core",
        anim = "ground_attack_on_spot",
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerServerEvent("lumberjack:giveItems")
        cooldowns[treeIndex] = GetGameTimer() + (treeData.cooldown * 1000)
        QBCore.Functions.Notify("木を切りました！", "success")
    end, function() -- Cancel
        QBCore.Functions.Notify("木を切るのをキャンセルしました。", "error")
    end)
end

-- 木をスポーンする
Citizen.CreateThread(function()
    for i, treeData in ipairs(Config.Trees) do
        local tree = SpawnTree(treeData)
        spawnedTrees[i] = tree

        exports.ox_target:addLocalEntity(tree, {
            {
                name = 'chop_tree',
                icon = 'fas fa-tree',
                label = '木を切る',
                onSelect = function()
                    ChopTree(i)
                end
            }
        })
    end
end)

-- 木材売却NPCの作成と対話オプションの追加
Citizen.CreateThread(function()
    local model = Config.SellNPC.model
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end

    local npc = CreatePed(4, model, Config.SellLocation.x, Config.SellLocation.y, Config.SellLocation.z - 1, Config.SellLocation.w, false, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    exports.ox_target:addLocalEntity(npc, {
        {
            name = 'sell_wood',
            icon = 'fas fa-dollar-sign',
            label = '木材を売る',
            onSelect = function()
                TriggerServerEvent("lumberjack:sellItems")
            end
        }
    })
end)