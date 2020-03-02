--[[
	Spanish Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'esES', true) or LibStub('AceLocale-3.0'):NewLocale(ADDON, 'esMX')
if not L then return end

-- main
L.AddWaypoint = 'Añadir Punto de Destino'
L.AskForfeit = 'No aparecieron mejoras. ¿Rendirse?'
L.AvailableBreeds = 'Variedades Disponibles'
L.Breed = 'Variedad'
L.BreedExplanation = 'Determinar cómo se distribuyen los atributos recibidos en cada nivel.'
L.CapturedPets = 'Mostrar Capturadas'
L.CommonSearches = 'Búsquedas Comunes'
L.FilterPets = 'Filtrar Mascotas'
L.LoadTeam = 'Cargar Equipo'
L.Ninja = 'Ninja'
L.NoHistory = 'PetTracker no te ha visto nunca\nluchar contra este rival'
L.NoneCollected = 'Ninguna Recogida'
L.Rivals = 'Rivales'
L.ShowJournal = 'Mostrar en el Diario'
L.ShowPets = 'Mostrar Combates de Mascotas'
L.ShowStables = 'Mostrar Establos'
L.Species = 'Especies'
L.StableTip = '|cffffd200Venir aquí parar curar tus|nmascotas por un pequeño precio.|r'
L.TellMore = 'Cuéntame algo más sobre ti.'
L.UpgradeAlert = '¡Aparecieron mejoras salvajes!'
L.TotalRivals = 'Rivales Totales'

-- automatic. do not translate unless necessary
L.TrackPets = GetSpellInfo(122026)
L.Maximized = WINDOWED_MAXIMIZED
L.Defeat = PVP_MATCH_DEFEAT:lower():gsub('^.', strupper)
L.Victory = PVP_MATCH_VICTORY:lower():gsub('^.', strupper)
L.EnemyTeam = PET_BATTLE_COMBAT_LOG_ENEMY_TEAM:gsub('%s.', strupper)

for i = 1, C_PetJournal.GetNumPetSources() do
	L['Source' .. i] = _G['BATTLE_PET_SOURCE_' .. i]
end

-- options
L.AlertUpgrades = 'Aviso de Mejoras'
L.AlertUpgradesTip = 'Si está desactivado, el mensaje de alerta de mejoras no se mostrará, pero seguirán estando marcadas con una exclamación (|TInterface/GossipFrame/AvailableQuestIcon:0:0:-1:-2|t).'
L.FAQDescription = 'Estas son las preguntas que más veces se hacen. Para ver de nuevo los tutoriales, reinicializa las opciones del addon clickando el botón "Predeterminado" en la esquina inferior izquierda.'
L.Forfeit = 'Preguntar por la Rendición'
L.ForfeitTip = 'Si está activado, se preguntará por la rendición cuando no hayan mejoras disponibles en un combate salvaje de mascotas.'
L.OptionsDescription = 'Estas opciones te permiten activar o desactivar las características generales de PetTracker. ¡Hazte con todas!'
L.RivalPortraits = 'Retratos de Rivales'
L.RivalPortraitsTip = 'Si está activado, los rivales serán mostrados con sus retratos en el mapa del mundo y en el de rivales.'
L.SpecieIcons = 'Iconos de Especies'
L.SpecieIconsTip = 'Si está desactivado, las mascotas serán marcadas por su tipo en lugar de su especie cuando se muestren en el mapa del mundo y en el de rivales.'
L.Switcher = 'Cambiador'
L.SwitcherTip = 'Si está activado, la interfaz por defecto para intercambiar mascotas en un combate será reemplazada por una mejorada.'
L.TrackPetsTip = 'Si está activado, se mostrará una lista del progreso de mascotas capturadas en la zona actual junto a los objetivos de las misiones.'

L.FAQ = {
	'¿Cómo puedo mostrar o esconder todas las mascotas en el mapa?',
	'Haz click en el botón de la lupa en la esquina superior derecha del mapa. Click en "Especies" en la opción "Mascotas".',

	'¿Cómo puedo hacer que el mapa muestre sólo unas mascotas específicas',
	'Hay un caja de filtros en la esquina superior derecha del mapa del mundo. Mira el tutorial para ejemplos comunes de búsqueda.',

	'¿Cómo puedo mostrar mi progreso de capturas en los objetivos de nuevo?',
	'Abre el Diario de Mascotas y haz click en "Rastrear Mascotas" en la esquina inferior derecha.',

	'¿Cómo puedo mostrar las mascotas que he capturado en los objetivos de la zona?',
	('Click on the "%s" header of the tracker y activa "Mostrar Capturadas".'):format(PETS),

	'¿Cómo puedo mover la barra de acción del enemigo?',
	'Mante pulsada la tecla mayúsculas y arrastra la barra.',
}

L.Tutorial = {
[[Welcome! You are now using |cffffd200PetTracker|r, by |cffffd200Jaliborc|r.
This tutorial will help you to quickly get started. Then you can get back to do what is truly important: to catch... ahem... capture them all!]],

[[PetTracker will help you to monitor your progress in the zone you are in.
The |cffffd200Zone Tracker|r displays which pets you are missing, their origin, and the rarity of the ones you have captured.]],

[[Click on |cffffd200Pets|r to toggle the tracker or additional options.]],

[[Open the |cffffd200World Map|r to see what PetTracker can do for your exploration.]],

[[PetTracker displays the possible sources of pets on the world map, from spawn points to vendors. It also displays stables and extra information about tamers.
To hide these locations, open the tracking menu and disable |cffffd200Show Battle Pets|r.]],

[[You can also filter which pets are displayed by typing on the search box. Here are some examples:
• |cffffd200Cat|r for cats.
• |cffffd200Missing|r for species you do not own.
• |cffffd200Aquatic|r for aquatic species.
• |cffffd200Quest|r for species obtainable through questing.
• |cffffd200Forest|r for species that inhabit forests.]],

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
[[PetTracker records the fights you have with each rival. Select a fight and click on |cffffd200Load Team|r to quickly reload the pets you used against them.]]
}
