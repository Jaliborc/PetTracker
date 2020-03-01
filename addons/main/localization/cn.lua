--[[
	Chinese Simplified Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'zhCN')
if not L then return end

-- main
L.AddWaypoint = '添加路径点'
L.AskForfeit = '没有可供升级，退出战斗？'
L.AvailableBreeds = '可用种属'
L.Breed = '种属'
L.BreedExplanation = '确定每级上涨种属属性情况。'
L.CapturedPets = '已捕获宠物'
L.CommonSearches = '通用搜索'
L.FilterPets = '过滤宠物'
L.LoadTeam = '加载队伍'
L.Ninja = '乱入者'
L.NoHistory = 'PetTracker 从没见\n你与其对战过'
L.NoneCollected = '未收集'
L.Rivals = '对手'
L.ShowJournal = '在日志中显示'
L.ShowPets = '显示战斗宠物'
L.ShowStables = '显示管理员'
L.Species = '种类'
L.StableTip = '|cffffd200到此治疗|n宠物，些许花费。|r'
L.TellMore = '告诉我更多你的细节。'
L.UpgradeAlert = '野生宠物出现！'
L.TotalRivals = '全部对手'

-- options
L.AlertUpgrades = '升级提醒'
L.AlertUpgradesTip = '如禁用，战斗中野生宠物战斗升级提醒框将不再显示，但升级将以一个标记显示。位置：（|TInterface/GossipFrame/AvailableQuestIcon:0:0:-1:-2|t）。'
L.Switcher = '切换器'
L.SwitcherTip = '如启用，宠物战斗切换默认用户界面将被替换为一个进阶级别的。'
L.RivalPortraits = '对手头像'
L.RivalPortraitsTip = '如启用，世界和战斗地图上显示对手将以他们的头像标记。'
L.FAQDescription = '这些是最常见的问题。要再次查看教程，请使用左下角的“默认”按钮重置插件设置。'
L.Forfeit = '提示损耗'
L.ForfeitTip = '如启用，宠物战斗中将在没有升级可用的情况下提示损耗。'
L.OptionsDescription = '此选项允许切换 PetTracker 常用功能开关。把他们一网打尽！'
L.TrackPetsTip = '如启用，当前区域宠物捕获进度列表将被显示在任务目标旁边。'

L.FAQ = {
	'如何在地图上显示/隐藏全部宠物？',
	'点击地图右上角落的放大镜按钮。点击“宠物”下的“种属”。',

	'如何只在地图上显示特定的宠物？',
	'在世界地图右上角有个过滤框。参见教程获得更多的信息和常见的举例。',

	'如何再次在目标显示捕获进度？',
	'打开宠物日志界面并点击右下方的“追踪宠物”。',

	'如何在区域追踪中显示已捕获的宠物？',
	'点击跟踪器的"宠物"标题，然后启用“显示已捕获”。',

	'如何移动敌人动作条？',
	'按住 Shift 键并拖动动作条。',
}

L.Tutorial = {
[[欢迎！现在使用的是 |cffffd200PetTracker|r，由 |cffffd200Jaliborc|r 制作，|cffffd200Adavak - CN 斯坦索姆|r简体中文汉化。

这个小教程帮助你快速了解此插件，这样就可以知道什么是真正需要去做的：把……他们……一网打尽！]],

[[PetTracker 将帮助监视当前区域的进度。

|cffffd200区域追踪|r显示缺失的宠物、来源及捕获宠物的稀有度。]],

[[点击|cffffd200战斗宠物|r切换追踪或更多选项。]],

[[打开|cffffd200世界地图|r来查看 PetTracker 能为你的历险做些什么。]],

[[PetTracker 在世界地图上显示可能的宠物来源，从刷新点到供应商。也能显示宠物对战师普通和附加信息。

如要隐藏此位置，打开追踪菜单并禁用|cffffd200显示战斗宠物|r。]],

[[还可以过滤显示的搜索框中输入的宠物。举例说明：

• |cffffd200猫（Cat）|r代表猫种类。
• |cffffd200缺失（Missing）|r代表你并未拥有。
• |cffffd200水栖（Aquatic）|r代表水栖类。
• |cffffd200任务（Quest）|r代表从任务获取的宠物。
• |cffffd200森林（Forest）|r代表栖息在森林。]],

[[打开|cffffd200宠物日志|r 来查看 PetTracker 能为你的历险做些什么。]],
[[此选择框可以切换|cffffd200区域追踪|r。这是一个特别有用的追踪加入你没有用过追踪的话。]],
[[打开|cffffd200对手|r栏来了解关于他们更多。]],
[[|cffffd200对手|r栏提供了已知宠物战斗信息，例如：

• 敌对宠物和它们的技能。
• 日常任务和奖励。
• 战斗位置。]],
[[也可以在搜索框内过滤要显示的宠物。例如：

• |cffffd200亚济（Aki）|r为天选者亚济。
• |cffffd200勇气（Valor）|r为奖励勇气的对手。
• |cffffd200德拉诺（Draenor）|r为德拉诺的对手。
• |cffffd200史诗（Epic）|r为对手使用史诗队伍。
• |cffffd200> 20|r为等级大于20的对手。]],
[[PetTracker 记录每个与之对战的对手。选择战斗并点击|cffffd200加载队伍|r来快速加载你所选择的宠物来对付他们。]]
}
