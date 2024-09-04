--[[
	English Localization (default)
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'enUS', true)

-- main
L.AddWaypoint = 'Add Waypoint'
L.AskForfeit = 'No upgrades are available. Quit battle?'
L.AvailableBreeds = 'Available Breeds'
L.Breed = 'Breed'
L.BreedExplanation = 'Determines how stats gained at each level are distributed.'
L.CapturedPets = 'Show Captured'
L.CommonSearches = 'Common Searches'
L.DisplayCondition = 'Display Condition'
L.FilterSpecies = 'Filter Species'
L.LoadTeam = 'Load Team'
L.MissingPets = 'Missing Pets'
L.MissingRares = 'Missing Rares'
L.Ninja = 'Ninja'
L.NoHistory = 'PetTracker has never seen you\nfight this adversary'
L.NoneCollected = 'None Collected'
L.Rivals = 'Rivals'
L.ShowJournal = 'Show in Journal'
L.ShowPets = 'Show Battle Pets'
L.ShowStables = 'Show Stables'
L.Species = 'Species'
L.StableTip = '|cffffd200Come here to heal your|npets for a small fee.|r'
L.TellMore = 'Tell me more about yourself.'
L.UpgradeAlert = 'Wild upgrades have appeared!'
L.TotalRivals = 'Total Rivals'
L.ZoneTracker = 'Zone Tracker'

-- automatic. do not translate unless necessary
L.Maximized = WINDOWED_MAXIMIZED
L.Defeat = PVP_MATCH_DEFEAT:lower():gsub('^.', strupper)
L.Victory = PVP_MATCH_VICTORY:lower():gsub('^.', strupper)
L.EnemyTeam = PET_BATTLE_COMBAT_LOG_ENEMY_TEAM:gsub('%s.', strupper)
L.TrackPets = C_Spell.GetSpellInfo(122026).name

for i = 1, C_PetJournal.GetNumPetSources() do
	L['Source' .. i] = _G['BATTLE_PET_SOURCE_' .. i]
end

-- options
L.AlertUpgrades = 'Alert for Upgrades'
L.AlertUpgradesTip = 'If disabled, an upgrades alert box will not be shown in combat, but upgrades will still be marked with a symbol (|TInterface/GossipFrame/AvailableQuestIcon:0:0:-1:-2|t).'
L.Forfeit = 'Prompt for Forfeit'
L.ForfeitTip = 'If enabled, will ask whether to forfeit a wild battle when no upgrades are available.'
L.OptionsDescription = 'These options allow you to toggle PetTracker general features on and off. Gotta catch them all!'
L.RivalPortraits = 'Rival Portraits'
L.RivalPortraitsTip = 'If enabled, rivals will be marked by their portraits when shown in the world and battle map.'
L.SpecieIcons = 'Specie Icons'
L.SpecieIconsTip = 'If enabled, pets will be marked by their species icon instead of type when shown in the world and battle map.'
L.Switcher = 'Switcher'
L.SwitcherTip = 'If enabled, the default UI for switching pets in combat will be replaced by an improved one.'
L.ZoneTrackerTip = 'If enabled, a list of pet capture progress in the current zone will be displayed next to the quest objectives.|n|n|cff20ff20You can also toggle this option from the Pet Journal.|r'

-- help
L.PatronsDescription = 'PetTracker is distributed for free and supported trough donations. A massive thank you to all the supporters on Patreon and Paypal who keep development alive. You can become a patron too at |cFFF96854patreon.com/jaliborc|r.'
L.HelpDescription = 'Here we provide answers to the most frequently asked questions. We also recommend following the ingame tutorial. If neither solve your problem, you might consider asking for help on the PetTracker user community on discord.'

L.FAQ = {
	'How to show/hide all pets on the map?',
	'Click on the "Filters" button at the top right corner of the world map. Click on "Species" under "Pets".',

	'How to make the map display specific pets only?',
	'Click on the "Filters" button at the top right corner of the world map. There is a search box under "Species". You can type queries like "missing" or "< rare"; see the tutorial for more examples.',

	'How to show/hide the progress in the current zone?',
	'Open the Pet Journal and click "Zone Tracker" at the bottom right corner.',

	'How to configure the zone tracker?',
	'Click on the "Pets" header of the tracker and options will appear.',

	'In pet combat, how to move the enemy action bar?',
	'Hold the shift key and drag the bar.',
}

L.Tutorial = {
[[Welcome! You are now using |cffffd200PetTracker|r, by |cffffd200Jaliborc|r.

This optional tutorial will help you get started. Then you can get back to do what is truly important: to catch... ahem... capture them all!]],
[[The |cffffd200Zone Tracker|r displays which pets you are missing in your current zone, their origin, and the rarity of the ones you have captured.

|A:NPE_LeftClick:14:14|a Click on the header |cffffd200"Pets"|r for additional options.]],
[[Open the |cffffd200World Map|r to see what PetTracker can do for your exploration.]],
[[PetTracker displays the possible sources of pets on the world map. It also shows stables and extra information about tamers.

To filter or hide these locations, |A:NPE_LeftClick:14:14|a open the |cffffd200"Map Filter"|r menu.]],
[[You can filter which pets are displayed by typing on the |cffffd200"Filter Species"|r box. Here are some examples:

• |cffffd200Cat|r for cats.
• |cffffd200Missing|r for species you do not own.
• |cffffd200Aquatic|r for aquatic species.
• |cffffd200Quest|r for pets obtainable through questing.
• |cffffd200Forest|r for species that inhabit forests.

Math operators also work:
• |cffffd200< Rare|r for species missing a rare quality pet.
• |cffffd200< 15|r for species with only pets below level 15.]],

[[Open the |cffffd200Pet Journal|r to see what PetTracker can do for your browsing.]],
[[This checkbox allows you to toggle the |cffffd200Zone Tracker|r. It is especially useful if you have hidden the tracker previously.]],
[[Open the |cffffd200Rivals|r tab to learn more about it.]],
[[The |cffffd200Rivals|r tab provides information about existing battle pet encounters, such as:

• Enemy pets and their abilities.
• Daily quests and rewards.
• Encounter location.]],
[[You can filter which pets are displayed by typing on the search box. Here are some examples:

• |cffffd200Aki|r for Aki the Chosen.
• |cffffd200Valor|r for rivals that award valor.
• |cffffd200Draenor|r for rivals located on Draenor.
• |cffffd200Epic|r for rivals with epic rarity teams.
• |cffffd200> 20|r for rivals over level 20.]],
[[PetTracker records the fights you have with each rival. Select a fight and click on |cffffd200Load Team|r to quickly reload the pets you used against them.]]
}