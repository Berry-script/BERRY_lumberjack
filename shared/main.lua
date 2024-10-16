Config = {}

-- 木の位置と設定
Config.Trees = {
    {
        coords = vec3(-2441.73, 3438.23, 43.32),
        model = "prop_tree_pine_02",
        cooldown = 300, -- 秒単位
    },
    {
        coords = vector3(-1737.89, 4284.82, 57.57),
        model = "prop_tree_pine_01",
        cooldown = 300,
    },
    -- 必要に応じて木を追加
}

-- 切った時に得られるアイテム
Config.ChoppedItems = {
    {name = "wood", amount = 3},
    {name = "bark", amount = 1},
    {name = "money", amount = 1},
}

-- 木を切るのにかかる時間（ミリ秒）
Config.ChoppingTime = 10000


Config.SellNPC = {
    model = "s_m_m_gardener_01",  -- NPCのモデル
}

-- SellLocationをvector4に変更
Config.SellLocation = vector4(-552.41, 5348.52, 74.74, 0.0)  -- w は向きを表す

-- 木材の売却価格
Config.WoodPrice = 10
Config.BarkPrice = 5