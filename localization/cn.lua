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
L.FilterSpecies = '过滤宠物'
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
L.FAQDescription = '这些是最常见的问题。要再次查看教程，请使用左下角的“默认”按钮重置插件设置。'
L.Forfeit = '提示损耗'
L.ForfeitTip = '如启用，宠物战斗中将在没有升级可用的情况下提示损耗。'
L.OptionsDescription = '此选项允许切换 PetTracker 常用功能开关。把他们一网打尽！'
L.RivalPortraits = '对手头像'
L.RivalPortraitsTip = '如启用，世界和战斗地图上显示对手将以他们的头像标记。'
L.SpecieIcons = '种类图标'
L.SpecieIconsTip = '如禁用，在世界和战斗地图上显示时，宠物将以其类型而不是种类来标记。'
L.Switcher = '切换器'
L.SwitcherTip = '如启用，宠物战斗切换默认用户界面将被替换为一个进阶级别的。'
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
[[欢迎！现在使用的是 |cffffd200PetTracker|r，由 |cffffd200Jaliborc|r 制作，简体中文汉化由 |cffffd200Adavak - CN 斯坦索姆|r 完成。

本教程将帮助你快速了解此插件，然后你就可以回到真正重要的事情上：捕捉……呃……抓住所有宠物！]],

[[|cffffd200区域追踪|r 显示你在当前区域缺少的宠物、它们的来源及你已捕获宠物的稀有度。

|A:NPE_LeftClick:14:14|a 点击|cffffd200"宠物"|r标题以获取更多选项。]],

[[打开|cffffd200世界地图|r来查看 PetTracker 能为你的探索做些什么。]],

[[PetTracker 在世界地图上显示可能的宠物来源。它还显示了兽栏和关于驯宠师的额外信息。

如需过滤或隐藏这些位置，|A:NPE_LeftClick:14:14|a 打开 |cffffd200"地图过滤器"|r菜单。]],

[[你可以通过在|cffffd200"过滤种类"|r框中输入内容来过滤显示的宠物。以下是一些示例：

• |cffffd200猫（Cat）|r：查找猫类宠物。
• |cffffd200缺失（Missing）|r：查找你未拥有的种类。
• |cffffd200水栖（Aquatic）|r：查找水栖类种类。
• |cffffd200任务（Quest）|r：查找通过任务获得的宠物。
• |cffffd200森林（Forest）|r：查找栖息在森林的种类。

数学运算符也可以使用：
• |cffffd200< 稀有（Rare）|r：查找缺少稀有品质宠物的种类。
• |cffffd200< 15|r：查找只有低于15级宠物的种类。]],

[[打开|cffffd200宠物日志|r 来查看 PetTracker 能为你的浏览做些什么。]],

[[此选择框允许你切换 |cffffd200区域追踪|r。如果你之前隐藏了追踪，这个功能特别有用。]],

[[打开 |cffffd200对手|r 标签来了解更多信息。]],

[[|cffffd200对手|r 标签提供了关于现有宠物战斗遭遇的信息，例如：

• 敌方宠物及其技能。
• 日常任务及奖励。
• 遭遇地点。]],

[[你可以通过在搜索框内输入内容来过滤要显示的宠物。以下是一些示例：

• |cffffd200亚济（Aki）|r：查找天选者亚济。
• |cffffd200勇气（Valor）|r：查找奖励勇气的对手。
• |cffffd200德拉诺（Draenor）|r：查找位于德拉诺的对手。
• |cffffd200史诗（Epic）|r：查找使用史诗队伍的对手。
• |cffffd200> 20|r：查找等级超过20的对手。]],

[[PetTracker 记录了你与每个对手的战斗。选择一场战斗并点击|cffffd200加载队伍|r来快速重新加载你曾使用的宠物。]]
}