--[[
	简体中文本地化
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'zhCN')
if not L then return end

-- 主界面
L.AddWaypoint = '添加导航点'
L.AskForfeit = '没有可升级的宠物。是否退出战斗？'
L.AvailableBreeds = '品种'
L.Breed = '品种'
L.BreedExplanation = '决定每级获得的属性如何分配。'
L.CapturedPets = '显示已捕获'
L.CommonSearches = '常用搜索'
L.TargetQuality = '显示条件'
L.FilterSpecies = '筛选宠物种类'
L.LoadTeam = '加载队伍'
L.MissingPets = '缺失宠物'
L.MissingRares = '缺失精良宠物'
L.Ninja = '忍者'
L.NoHistory = '未曾与该对手对战过'
L.NoneCollected = '未收集'
L.Rivals = '对手'
L.ShowJournal = '在宠物手册中显示'
L.ShowPets = '显示战斗宠物'
L.ShowStables = '显示兽栏'
L.Species = '宠物种类'
L.StableTip = '|cffffd200治疗宠物|n少许花费|r'
L.TellMore = '再多说一些你的信息。'
L.UpgradeAlert = '发现野生可升级宠物！'
L.TotalRivals = '全部对手'
L.ZoneTracker = '区域追踪器'

-- 自动生成项。除非必要否则无需翻译
L.Maximized = WINDOWED_MAXIMIZED
L.Defeat = BOSS_DEAD
L.Victory = EMOTE101_TOKEN:lower():gsub('^.', strupper)
L.EnemyTeam = PET_BATTLE_COMBAT_LOG_ENEMY_TEAM:gsub('%s.', strupper)
L.TrackPets = C_Spell.GetSpellInfo(122026).name

for i = 1, C_PetJournal.GetNumPetSources() do
	L['Source' .. i] = _G['BATTLE_PET_SOURCE_' .. i]
end

-- 选项设置
L.AlertUpgrades = '升级提醒'
L.AlertUpgradesTip = '禁用后战斗中不会弹出可升级提醒，但会以标记 |TInterface/GossipFrame/AvailableQuestIcon:0:0:-1:-2|t 显示可升级宠物。'
L.Forfeit = '认输提示'
L.ForfeitTip = '启用后，当野生宠物战斗中无可用升级时，会询问是否退出战斗。'
L.MinAlertQuality = '最低可升级品质'
L.MinAlertQualityTip = '仅等于或高于此品质的宠物会被认为可升级。'
L.OptionsDescription = '这些选项用于开关 PetTracker 的通用功能。把它们全抓住！'
L.RivalPortraits = '对手头像'
L.RivalPortraitsTip = '启用后，世界和战斗地图中会标记显示对手的头像。'
L.SpecieIcons = '种类图标'
L.SpecieIconsTip = '启用后，世界和战斗地图中会标记显示宠物种类图标而非类型图标。'
L.Switcher = '宠物切换UI'
L.SwitcherTip = '启用后，对战中默认的宠物切换界面将替换为优化版本。'
L.TargetQualityTip = ''
L.ZoneTrackerTip = '启用后，当前区域的宠物收集进度列表将显示在任务目标旁。|n|n|cff20ff20也可以在宠物手册中切换此选项。|r'

-- 帮助说明
L.PatronsDescription = 'PetTracker 免费分发，通过捐赠维持开发。在此向所有通过 Patreon 和 Paypal 支持的用户致以诚挚感谢，是你们让开发得以延续。你也可以通过 |cFFF96854patreon.com/jaliborc|r 成为赞助者。'
L.HelpDescription = '这里提供常见问题解答。我们也建议你跟随游戏内教程操作。若仍未解决问题，可前往 Discord 的 PetTracker 用户社区寻求帮助。'

L.FAQ = {
	'如何在地图上显示/隐藏所有宠物？',
	'点击世界地图右上角的「地图筛选」按钮，点击「宠物种类」。',

	'如何让地图仅显示特定宠物？',
	'点击世界地图右上角的「地图筛选」按钮，在「宠物种类」下方搜索框中输入「缺失」或「< 精良」等关键词。更多示例请参考教程。',

	'如何显示/隐藏当前区域的收集进度？',
	'打开宠物手册，点击右下角的「区域追踪器」。',

	'如何配置区域追踪器？',
	'点击追踪器的「宠物」标题栏，即可显示配置选项。',

	'宠物战斗中，如何移动敌方动作条？',
	'按住 Shift 键并拖动动作条。',
}

L.Tutorial = {
[[欢迎使用 |cffffd200PetTracker|r，由 |cffffd200Jaliborc|r 开发。

本教程为可选内容，将帮助你快速上手。之后你就能专注于真正重要的事：收集……呃，捕捉它们全部！]],
[[|cffffd200区域追踪器|r会显示当前区域你缺失的宠物、它们的来源，以及已捕获宠物的品质。

|A:NPE_LeftClick:14:14|a 点击 |cffffd200「宠物」|r 标题栏可查看更多选项。]],
[[打开 |cffffd200世界地图|r，体验 PetTracker 为探索带来的便利。]],
[[PetTracker 会在世界地图上显示宠物的可能来源，同时标注兽栏位置和驯兽师的额外信息。

要筛选或隐藏这些位置，请 |A:NPE_LeftClick:14:14|a 打开 |cffffd200「地图筛选」|r 菜单。]],
[[你可在 |cffffd200「宠物种类」|r 输入框中输入关键词筛选显示的宠物。示例如下：

• |cffffd200猫|r - 筛选猫类宠物
• |cffffd200缺失|r - 筛选未拥有的宠物种类
• |cffffd200水栖|r - 筛选水栖类宠物
• |cffffd200任务|r - 筛选任务获取的宠物
• |cffffd200森林|r - 筛选栖息于森林的宠物

还可使用数学运算符：
• |cffffd200< 精良|r - 筛选精良品质以下的宠物种类
• |cffffd200< 15|r - 筛选15级以下的宠物种类]],

[[打开 |cffffd200宠物手册|r，看看 PetTracker 如何优化你的浏览体验。]],
[[此复选框可开关 |cffffd200区域追踪器|r。若你之前隐藏了追踪器，这会非常实用。]],
[[打开 |cffffd200「对手」|r 标签页了解更多功能。]],
[[|cffffd200「对手」|r 标签页提供宠物对战相关信息，包括：

• 敌方宠物及其技能
• 日常任务与奖励
• 对战地点]],
[[你可在搜索框输入关键词筛选显示的对手。示例如下：

• |cffffd200亚济|r - 筛选天选者亚济
• |cffffd200勇气|r - 筛选奖励勇气点数的对手
• |cffffd200德拉诺|r - 筛选位于德拉诺的对手
• |cffffd200史诗|r - 筛选拥有史诗队伍的对手
• |cffffd200> 20|r - 筛选 20 级以上的对手]],
[[PetTracker 会记录你与每位对手的战斗记录。选择一场战斗并点击 |cffffd200「加载队伍」|r，可快速重新加载对战该对手时使用的宠物。]]
}
