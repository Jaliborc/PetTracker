--[[
    Spanish Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'esES') or LibStub('AceLocale-3.0'):NewLocale(ADDON, 'esMX')
if not L then return end

-- main
L.AddWaypoint = 'Añadir Punto de Destino'
L.AskForfeit = 'No apareció mejoras. Rendirse del combate?'
L.AvailableBreeds = 'Raças Disponible'
L.Breed = 'Raça'
L.BreedExplanation = 'Determina cómo se distribuyen los atributos recebidos en cada nivel.'
L.CapturedPets = 'Mostrar Capturados'
L.CommonSearches = 'Búsquedas Comunes'
L.FilterPets = 'Filtrar Mascotas'
L.ShowJournal = 'Mostrar no Diario'
L.NoHistory = 'El PetTracker nunca lo has visto\npelear contra este oponente'
L.NoneCollected = 'Ninguno Capturado'
L.Rivals = 'Rivales'
L.ShowPets = 'Mostrar Mascotas'
L.ShowStables = 'Mostrar Estábulos'
L.StableTip = '|cffffd200Aqui podrá pagar para|ncurar sus mascotas.|r'
L.TellMore = 'Cuéntame más sobre ti mismo.'
L.UpgradeAlert = 'Aparecieron mejoras salvajes!'
L.Victory = 'Victoria'
L.Defeat = 'Derrota'

-- options
L.AlertUpgrades = 'Aviso de Mejoras'
L.AlertUpgradesTip = 'Se desligado, el cuadro de aviso de mejoras no aparece en combate, pero las mascotas seron marcadas con el símbolo. (|TInterface\\GossipFrame\\AvailableQuestIcon:0:0:-1:-2|t).'
L.Forfeit = 'Sugerir Rendirse'
L.ForfeitTip = 'Si activado, se propuso abandonar la lucha cuando no hay mejoras.'
