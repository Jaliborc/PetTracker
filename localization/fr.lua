--[[
	French Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'frFR')
if not L then return end

-- main
L.AddWaypoint = 'Ajouter un repère'
L.AskForfeit = 'Aucune amélioration n\'est disponible. Quitter le combat?'
L.AvailableBreeds = 'Races disponibles'
L.Breed = 'Races'
L.BreedExplanation = 'Determine comment les stats gagnées à chaque niveau sont attibuées.'
L.CapturedPets = 'Afficher les capturées'
L.CommonSearches = 'Recherche'
L.FilterSpecies = 'Filtrer Mascottes'
L.ShowJournal = 'Afficher dans le Codex des mascottes'
L.Maximized = 'Agrandi'
L.NoHistory = 'PetTracker ne vous a jamais vu\ncombattre cet adversaire'
L.NoneCollected = 'Non Collectée'
L.Rivals = 'Dresseurs'
L.ShowPets = 'Afficher Mascottes'
L.ShowStables = 'Afficher Écurie'
L.StableTip = '|cffffd200Venez ici pour soigner vos|nmascotte pour un faible prix.|r'
L.TellMore = 'Dîtes moi en plus à propos de vous.'
L.UpgradeAlert = 'Des améliorations sauvages sont apparues!'

-- options
L.AlertUpgrades = 'Alerter pour les Améliorations'
L.AlertUpgradesTip = 'Si desactivé, l\'alerte des améliorations sauvages ne sera pas affichée en combat, mais celles-ci seront toujours marquées avec un symbole (|TInterface\\GossipFrame\\AvailableQuestIcon:0:0:-1:-2|t).'
L.Forfeit = 'Déclarer forfait'
L.ForfeitTip = 'Si activé, Il vous sera proposé de déclarer forfait en combat si aucunes améliorations n\'est disponibles.'

L.FAQ = {
	'Comment puis-je afficher/masquer toutes les mascotte sur la carte?',
	'Cliquez sur le bouton dans l\'angle en haut à droite de la carte. Cliquez sur "Afficher Mascottes".',

	'Comment puis-je afficher sur la carte des mascottes particulières uniquement?',
	'Il y a un champs pour filtrer une recherche dans l\'angle en haut à droite de la carte du monde. Consultez le tutoriel pour afficher des exemples de recherches.',

	'Comment puis-je de nouveau afficher la Zone de Pistage?',
	'Ouvrez le Codex des mascottes et cliquez sur la "Zone de Pistage" en bas à droite.',

	'Comment puis-je afficher dans la Zone de Pistage les mascottes que je viens de capturer?',
	'Cliquez sur "Animaux" dans le suivi des objectifs et activez "Afficher les capturées"',
}

L.Tutorial = {
[[Bienvenue! Vous utilisez dès à présent |cffffd200PetTracker|r, de |cffffd200Jaliborc|r.

Ce tutoriel optionnel vous aidera à commencer. Vous pourrez ensuite revenir à ce qui est vraiment important: Attraper... euh... tous les capturer!]],

[[Le |cffffd200Suivi de Zone|r affiche les mascottes qui vous manquent dans votre zone actuelle, leur origine, et la rareté de celles que vous avez capturées.

|A:NPE_LeftClick:14:14|a Cliquez sur l'en-tête |cffffd200"Mascottes"|r pour des options supplémentaires.]],

[[Ouvrez la |cffffd200Carte du Monde|r pour voir ce que PetTracker peut faire pour votre exploration.]],

[[PetTracker affiche les sources possibles des mascottes sur la carte du monde. Il peut aussi afficher les écuries ainsi que d'autres informations à propos des dompteurs.

Pour filtrer ou masquer ces lieux, |A:NPE_LeftClick:14:14|a ouvrez le menu |cffffd200"Filtre de la Carte"|r.]],

[[Vous pouvez filtrer quelles mascottes sont affichées en tapant dans la zone de recherche |cffffd200"Filtrer Espèces"|r. Voici quelques exemples:

• |cffffd200Chat|r pour les chats.
• |cffffd200Manquant|r pour ceux que vous ne possédez pas.
• |cffffd200Aquatique|r pour les aquatiques.
• |cffffd200Quête|r pour celles obtenables par des quêtes.
• |cffffd200Forêt|r pour celles qui habitent dans la forêt.

Les opérateurs mathématiques fonctionnent aussi:
• |cffffd200< Rare|r pour les espèces dont vous n'avez pas de mascotte de qualité rare.
• |cffffd200< 15|r pour les espèces avec des mascottes en dessous du niveau 15.]],

[[Ouvrez le |cffffd200Codex des mascottes|r pour voir ce que PetTracker peut faire pour votre recherche.]],

[[Cette case à cocher vous permet d'afficher le |cffffd200Suivi de Zone|r. C'est particulièrement utile si vous avez masqué le suivi précédemment.]],

[[Ouvrez l'onglet des |cffffd200Dresseurs|r pour en apprendre plus sur eux.]],

[[L'onglet des |cffffd200Dresseurs|r vous informe sur les rencontres de combats de mascottes existantes, tels que:

• Les mascottes ennemies et leurs capacités.
• Les quêtes journalières et les récompenses.
• Le lieu de rencontre.]],

[[Vous pouvez filtrer quelles mascottes sont affichées en tapant dans la zone de recherche. Voici quelques exemples:

• |cffffd200Aki|r pour Aki l’Élue.
• |cffffd200Valor|r pour les dresseurs qui octroient de la vaillance.
• |cffffd200Draenor|r pour les dresseurs se trouvant en Draenor.
• |cffffd200Épique|r pour les dresseurs avec une équipe composée de mascottes épiques.
• |cffffd200> 20|r pour les dresseurs supérieurs au niveau 20.]],

[[PetTracker enregistre les combats que vous avez fait contre chaque dresseur. Sélectionnez un combat et cliquez sur |cffffd200Charger l'équipe|r pour recharger rapidement les mascottes utilisées lors de ce combat.]]
}	