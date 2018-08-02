if GetLocale() ~= 'zhTW' then return end
local _, Addon = ...
local L = Addon.Locals

L.AddWaypoint = '新增路徑點'
L.AlertUpgrades = '升級提醒'
L.AlertUpgradesTip = '如停用，戰鬥中野生寵物戰鬥升級提醒框將不再顯示，但升級將以一個標記顯示。位置：（|TInterface\GossipFrame\AvailableQuestIcon:0:0👎-2|t）。'
L.AskForfeit = '沒有可供升級，退出戰鬥？'
L.AvailableBreeds = '\n可用品種：'
L.Battles = '戰鬥'
L.Breed = '品種'
L.BreedExplanation = '決定如何分派每一級獲得的狀態提升。'
L.CapturedPets = '已捕獲寵物'
L.CommonSearches = '通用搜索'
L.Defeat = '戰敗'
L.EnemyTeam = '敵對隊伍'
L.FilterPets = '過濾寵物'
L.LoadTeam = '載入隊伍'
L.Maximized = '最大'
L.Ninja='亂入者'
L.NoHistory = 'PetTracker 從沒見\n你與其對戰過'
L.NoneCollected = '未收集'
L.Rivals = '對手'
L.ShowJournal = '在日誌中顯示'
L.ShowPets = '顯示戰鬥寵物'
L.ShowStables = '顯示管理員'
L.Species = '寵物種類'
L.StableTip = '|cffffd200以些許花費到此|n治療寵物。|r'
L.TrackPets = '追踪寵物'
L.TellMore = '告訴我更多你的細節。'
L.PromptForfeit = '提示損耗'
L.PromptForfeitTip = '如啟用，寵物戰鬥中將在沒有升級可用的情況下提示損耗。'
L.UnlockActions = '解鎖敵對動作'
L.UnlockActionsTip = '如啟用，敵對動作條可以被拖動到螢幕的任意位置。'
L.UpgradeAlert = '野生寵物出現！'
L.TotalTamers = '總競爭對手'
L.Victory = '勝利'
L.ZoneTracker = '區域追踪'

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

這個小教學幫助你快速了解此插件，這樣就可以知道什麼是真正需要去做的：把……他們……一網打盡！]],

[[PetTracker 將幫助監視目前區域的進度。

|cffffd200區域追踪|r顯示缺少的寵物、來源及捕獲寵物的稀有度。]],

[[點擊|cffffd200戰鬥寵物|r切換追踪或更多選項。]],

[[打開|cffffd200世界地圖|r來查看 PetTracker 能為你的歷險做些什麼。]],

[[PetTracker 在世界地圖上顯示可能的寵物來源，從更新點到供應商。也能顯示寵物對戰師普通和附加訊息。

如要隱藏此位置，打開追踪選單並停用|cffffd200顯示戰鬥寵物|r。]],

[[還可以過濾顯示的搜索框中輸入的寵物。舉例說明：

• |cffffd200貓（Cat）|r代表貓種類。
• |cffffd200缺少（Missing）|r代表你並未擁有。
• |cffffd200水棲（Aquatic）|r代表水棲類。
• |cffffd200任務（Quest）|r代表從任務獲取的寵物。
• |cffffd200森林（Forest）|r代表棲息在森林。]],
}

L.JournalTutorial = {
[[打開|cffffd200寵物日誌|r 來查看 PetTracker 能為你的歷險做些什麼。]],
[[此選擇框可以切換|cffffd200區域追踪|r。這是一個特別有用的追踪加入你沒有用過追踪的話。]],
[[打開|cffffd200對手|r欄來了解關於他們更多。]],
[[|cffffd200對手|r欄提供了已知寵物戰鬥訊息，例如：

• 敵對寵物和它們的技能。
• 日常任務和獎勵。
• 戰鬥位置。]],
[[也可以在搜尋框內過濾要顯示的寵物。例如：

• |cffffd200雅姬（Aki）|r為『天選』雅姬。
• |cffffd200勇氣（Valor）|r為獎勵勇氣的對手。
• |cffffd200德拉諾（Dreenor）|r為德拉諾的對手。
• |cffffd200史詩（Epic）|r為對手使用史詩隊伍。
• |cffffd200> 20|r為等級大於20的對手。]],
[[PetTracker 記錄每個與之對戰的對手。選擇戰鬥並點擊|cffffd200載入隊伍|r來快速載入你所選擇的寵物。]]
}
