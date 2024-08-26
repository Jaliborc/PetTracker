--[[
	Chinese Traditional Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'zhTW')
if not L then return end

-- main
L.AddWaypoint = '新增路徑點'
L.AskForfeit = '沒有可供升級，退出戰鬥？'
L.AvailableBreeds = '可用品種'
L.Breed = '品種'
L.BreedExplanation = '決定如何分派每一級獲得的狀態提升。'
L.CapturedPets = '已捕獲寵物'
L.CommonSearches = '通用搜索'
L.FilterSpecies = '過濾寵物'
L.LoadTeam = '載入隊伍'
L.Ninja='亂入者'
L.NoHistory = 'PetTracker 從沒見\n你與其對戰過'
L.NoneCollected = '未收集'
L.Rivals = '對手'
L.ShowJournal = '在日誌中顯示'
L.ShowPets = '顯示戰鬥寵物'
L.ShowStables = '顯示管理員'
L.Species = '寵物種類'
L.StableTip = '|cffffd200以些許花費到此|n治療寵物。|r'
L.TellMore = '告訴我更多你的細節。'
L.UpgradeAlert = '野生寵物出現！'
L.TotalTamers = '總競爭對手'

-- options
L.AlertUpgrades = '升級提醒'
L.AlertUpgradesTip = '如停用，戰鬥中野生寵物戰鬥升級提醒框將不再顯示，但升級將以一個標記顯示。位置：（|TInterface\GossipFrame\AvailableQuestIcon:0:0👎-2|t）。'
L.Forfeit = '提示損耗'
L.ForfeitTip = '如啟用，寵物戰鬥中將在沒有升級可用的情況下提示損耗。'

L.FAQ = {
'如何在地圖上顯示/隱藏全部寵物？',
'點擊地圖右上角落的放大鏡按鈕，點擊顯示戰鬥寵物。',

'如何只在地圖上顯示特定的寵物？',
'在世界地圖右上角有個過濾框。參見教學獲得更多的訊息和常見的範例。',

'如何再次顯示區域追踪？',
'打開寵物日誌界面並點擊右下方的區域追踪。',

'如何在區域追踪中顯示已捕獲的寵物？',
'點擊寵物對戰追踪並啟用已捕獲寵物。',

'如何禁用全部野生寵物出現提示？',
'到主界面選單，打開插件列表並禁用 PetTracker 野生寵物出現。',

'如何再次查看教程？',
'點擊右側按鈕。'

}

L.Tutorial = {
[[歡迎！現在使用的是 |cffffd200PetTracker|r，由 |cffffd200Jaliborc|r 製作。

這個小教程將幫助你快速了解此插件，這樣你就可以回到真正重要的事情上：抓住……嗯……全部捕捉到！]],

[[|cffffd200區域追踪|r 顯示你在目前區域內缺少的寵物、它們的來源及已捕獲寵物的稀有度。

|A:NPE_LeftClick:14:14|a 點擊|cffffd200"寵物"|r標題以獲取更多選項。]],

[[打開|cffffd200世界地圖|r來查看 PetTracker 能為你的探索做些什麼。]],

[[PetTracker 在世界地圖上顯示可能的寵物來源。它也顯示獸欄和有關馴獸師的額外信息。

如要過濾或隱藏這些位置，|A:NPE_LeftClick:14:14|a 打開|cffffd200"地圖過濾器"|r選單。]],

[[你可以通過在|cffffd200"過濾種類"|r框中輸入來過濾顯示的寵物。舉例說明：

• |cffffd200貓（Cat）|r代表貓種類。
• |cffffd200缺少（Missing）|r代表你並未擁有的種類。
• |cffffd200水棲（Aquatic）|r代表水棲類種類。
• |cffffd200任務（Quest）|r代表通過任務獲取的寵物。
• |cffffd200森林（Forest）|r代表棲息在森林的種類。

數學運算符也可以使用：
• |cffffd200< 稀有（Rare）|r代表缺少稀有品質的種類。
• |cffffd200< 15|r代表只有低於15級的寵物種類。]],

[[打開|cffffd200寵物日誌|r來查看 PetTracker 能為你的搜索做些什麼。]],

[[此選擇框可以切換|cffffd200區域追踪|r。如果你之前隱藏了追踪，這個功能特別有用。]],

[[打開|cffffd200對手|r標籤來了解更多信息。]],

[[|cffffd200對手|r標籤提供了已知寵物戰鬥的信息，例如：

• 敵方寵物及其技能。
• 日常任務及獎勵。
• 對手位置。]],

[[你可以通過在搜尋框內輸入來過濾顯示的對手。舉例說明：

• |cffffd200雅姬（Aki）|r代表『天選』雅姬。
• |cffffd200勇氣（Valor）|r代表獎勵勇氣的對手。
• |cffffd200德拉諾（Draenor）|r代表位於德拉諾的對手。
• |cffffd200史詩（Epic）|r代表使用史詩隊伍的對手。
• |cffffd200> 20|r代表等級大於20的對手。]],

[[PetTracker 記錄了你與每個對手的戰鬥。選擇戰鬥並點擊|cffffd200載入隊伍|r來快速載入你之前使用的寵物。]]
}	