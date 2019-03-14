local _, Addon = ...
local L = {}

L.AddWaypoint = 'Add Waypoint'
L.AlertUpgrades = 'Alert for Upgrades'
L.AlertUpgradesTip = 'If disabled, the wild upgrades alert box will not be shown in combat, but upgrades will still be marked with a symbol (|TInterface\\GossipFrame\\AvailableQuestIcon:0:0:-1:-2|t).'
L.AskForfeit = 'No upgrades are available. Quit battle?'
L.AvailableBreeds = '\nAvailable Breeds:'
L.Battles = 'Battles'
L.Breed = 'Breed'
L.BreedExplanation = 'Determines how stats gained at each level are distributed.'
L.CapturedPets = 'Show Captured'
L.CommonSearches = 'Common Searches'
L.Defeat = 'Defeat'
L.EnemyTeam = 'Enemy Team'
L.FAQDescription = 'These are the most frequently asked questions. To see the tutorials again, reset the addon settings using the "Defaults" button at the lower left corner.'
L.FilterPets = 'Filter Pets'
L.HideRivals = 'Hide Rival Portraits'
L.HideRivalsTip = 'If enabled, rival portraits will not be shown in the world map, battle map or any other map.'
L.LoadTeam = 'Load Team'
L.Maximized = 'Maximized'
L.Ninja = 'Ninja'
L.NoHistory = 'PetTracker has never seen you\nfight this adversary'
L.NoneCollected = 'None Collected'
L.PetBattle = 'Pet Battle'
L.PromptForfeit = 'Prompt for Forfeit'
L.PromptForfeitTip = 'If enabled, you will be prompted to forfeit a battle when no upgrades are available.'
L.Rivals = 'Rivals'
L.ShowJournal = 'Show in Journal'
L.ShowPets = 'Show Battle Pets'
L.ShowStables = 'Show Stables'
L.Species = 'Species'
L.StableTip = '|cffffd200Come here to heal your|npets for a small fee.|r'
L.TrackPets = 'Track Pets'
L.TellMore = 'Tell me more about yourself.'
L.UnlockActions = 'Unlock Enemy Actions'
L.UnlockActionsTip = 'If enabled, the enemy actions bar can be dragged to anywhere on the screen.'
L.UpgradeAlert = 'Wild upgrades have appeared!'
L.TotalRivals = 'Total Rivals'
L.Victory = 'Victory'
L.ZoneTracker = 'Zone Tracker'

for i = 1, C_PetJournal.GetNumPetSources() do
	L['Source' .. i] = _G['BATTLE_PET_SOURCE_' .. i] -- do not translate. Automatic for most locales
end

L.FAQ = {
	'How do I show/hide all pets on the map?',
	'Click on the magnifying glass button at the top right corner of the map. Click on Show Battle Pets.',

	'How do I make the map display specific pets only?',
	'There is a filter box at the top right corner of the world map. See the tutorial for common search examples.',

	'How do I show the Zone Tracker again?',
	'Open the Pet Journal and click Zone Tracker at the bottom right corner.',

	'How do I display the pets I have captured in the Zone Tracker?',
	'Click on Battle Pets at the tracker and enable Captured Pets',

	'How do I disable all the upgrade alerts?',
	'Go to the Main Menu, open the addons list and disable PetTracker Upgrades.'
}

L.Tutorial = {
[[Welcome! You are now using |cffffd200PetTracker|r, by |cffffd200Jaliborc|r.

A lot has changed since Pandaria, so this will help you to quickly get started. Then you can get back to do what is truly important: to catch... ahem... capture them all!]],

[[PetTracker will help you to monitor your progress in the zone you are in.

The |cffffd200Zone Tracker|r displays which pets you are missing, their origin, and the rarity of the ones you have captured.]],

[[Click on |cffffd200Battle Pets|r to toggle the tracker or additional options.]],

[[Open the |cffffd200World Map|r to see what PetTracker can do for your exploration.]],

[[PetTracker displays the possible sources of pets on the world map, from spawn points to vendors. It also displays stables and extra information about tamers.

To hide these locations, open the tracking menu and disable |cffffd200Show Battle Pets|r.]],

[[You can also filter which pets are displayed by typing on the search box. Here are some examples:

• |cffffd200Cat|r for cats.
• |cffffd200Missing|r for species you do not own.
• |cffffd200Aquatic|r for aquatic species.
• |cffffd200Quest|r for species obtainable through questing.
• |cffffd200Forest|r for species that inhabit forests.]]
}

L.JournalTutorial = {
[[Open the |cffffd200Pet Journal|r to see what PetTracker can do for your browsing.]],
[[This checkbox allows you to toggle the |cffffd200Zone Tracker|r. It is especially useful if you have hidden the tracker previously.]],
[[Open the |cffffd200Rivals|r tab to learn more about it.]],
[[The |cffffd200Rivals|r tab provides information about existing battle pet encounters, such as:

• Enemy pets and their abilities.
• Daily quests and rewards.
• Encounter location.]],
[[You can also filter which pets are displayed by typing on the search box. Here are some examples:

• |cffffd200Aki|r for Aki the Chosen.
• |cffffd200Valor|r for rivals that award valor.
• |cffffd200Draenor|r for rivals located on Draenor.
• |cffffd200Epic|r for rivals with epic rarity teams.
• |cffffd200> 20|r for rivals over level 20.]],
[[PetTracker records the fights you have with each rival. Select a fight and click on |cffffd200Load Team|r to quickly reload the pets you used then.]]
}

Addon.Locals = L
