if GetLocale() ~= 'frFR' then return end
local _, Addon = ...
local L = Addon.Locals

L.AddWaypoint = 'Ajouter un repère'
L.AlertUpgrades = 'Alerter pour les Améliorations'
L.AlertUpgradesTip = 'Si desactivé, l\'alerte des améliorations sauvages ne sera pas affichée en combat, mais celles-ci seront toujours marquées avec un symbole (|TInterface\\GossipFrame\\AvailableQuestIcon:0:0:-1:-2|t).'
L.AskForfeit = 'Aucune amélioration n\'est disponible. Quitter le combat?'
L.AvailableBreeds = '\nRaces disponibles:'
L.PromptForfeit = 'Déclarer forfait'
L.PromptForfeitTip = 'Si activé, Il vous sera proposé de déclarer forfait en combat si aucunes améliorations n\'est disponibles.'
L.Breed = 'Races'
L.BreedExplanation = 'Determine comment les stats gagnées à chaque niveau sont attibuées.'
L.CapturedPets = 'Afficher les capturées'
L.CommonSearches = 'Recherche'
L.EnemyTeam = 'Équipe ennemie'
L.FilterPets = 'Filtrer Mascottes'
L.ShowJournal = 'Afficher dans le Codex des mascottes'
L.Maximized = 'Agrandi'
L.NoHistory = 'PetTracker ne vous a jamais vu\ncombattre cet adversaire'
L.NoneCollected = 'Non Collectée'
L.Rivals = 'Dresseurs'
L.ShowPets = 'Afficher Mascottes'
L.ShowStables = 'Afficher Écurie'
L.StableTip = '|cffffd200Venez ici pour soigner vos|nmascotte pour un faible prix.|r'
L.TrackPets = 'Pister mascottes'
L.TellMore = 'Dîtes moi en plus à propos de vous.'
L.UnlockActions = 'Dévérrouiller les actions ennemies'
L.UnlockActionsTip = 'Si activé, la barre d\'action ennemie pourra être déplacée n\'importe où à l\'écran.'
L.UpgradeAlert = 'Des améliorations sauvages sont apparues!'
L.ZoneTracker = 'Zone de Pistage'
L.Victory = 'Victoire'
L.Defeat = 'Défaite'

L.FAQ = {
	'Comment puis-je afficher/masquer toutes les mascotte sur la carte?',
	'Cliquez sur le bouton dans l\'angle en haut à droite de la carte. Cliquez sur Afficher les Mascottes.',

	'Comment puis-je afficher sur la carte des mascottes particulières uniquement?',
	'Il y a un champs pour filtrer une recherche dans l\'angle en haut à droite de la carte du monde. Consultez le tutoriel pour afficher des exemples de recherches.',

	'Comment puis-je de nouveau afficher la Zone de Pistage?',
	'Ouvrez le Codex des mascottes et cliquez sur la Zone de Pistage en bas à droite.',

	'Comment puis-je afficher dans la Zone de Pistage les mascottes que je viens de capturer?',
	'Cliquez sur Mascottes dans le suivi des objectifs et activez Mascottes Capturées',

	'Comment puis-je desactiver toutes les alertes d\'améliorations?',
	'Allez au Menu Principal, ouvrez la liste des addons et desactivez PetTracker Upgrades.',

	'Comment puis-je revoir le tutoriel?',
	'Cliquez sur le bouton à votre droite.'
}

L.Tutorial = {
[[Bienvenue! Vous utilisez dès à présent |cffffd200PetTracker|r, de |cffffd200Jaliborc|r.

Beaucoup de choses ont changé depuis Pandaria, celà va rapidement vous aider à commencer. Vous allez pouvoir revenir à ce qui est le plus important: Attraper... et... tous les capturer!]],

[[PetTracker vous aidera à suivre votre progression dans la zone où vous vous trouvez.

La |cffffd200Zone de Pistage|r vous affichera les mascottes qui vous manquent, leurs origines, et la rareté de celle que vous avez capturé.]],

[[Cliquez sur |cffffd200Mascottes|r pour afficher le suivi ou les options additionnelles.]],

[[Ouvrez la |cffffd200Carte de Monde|r pour voir ce que PetTracker peut faire pour votre exploration.]],

[[PetTracker affiche les sources possibles des mascottes sur la carte du monde, des points d'apparitions aux vendeurs. Il peut aussi afficher les écuries ainsi que d'autres informations à propos des dompteurs.

Pour masquer ces lieux, ouvrez le menu de suivi et desactivez |cffffd200Afficher les Mascottes|r.]],

[[Vous pouvez aussi filtrer quelles mascottes sont affichées en tapant dans la zone de recherche. Voici quelques exemples:

• |cffffd200Chat|r pour les chats.
• |cffffd200Manquant|r pour ceux que vous ne possédez pas.
• |cffffd200Aquatique|r pour les aquatiques.
• |cffffd200Quête|r pour celles obtenables par des quêtes.
• |cffffd200Forêt|r pour ceux que habite dans la forêt.]]
}

L.JournalTutorial = {
[[Ouvrez le |cffffd200Codex des mascottes|r pour voir ce que PetTracker peut faire pour votre recherche.]],
[[Cette case à cocher vous permet d'afficher la |cffffd200Zone de Pistage|r. Celà est particulièrement utile si vous avez masqué le suivi précédemment.]],
[[Ouvrez l'onglet des |cffffd200Dresseurs|r pour en apprendre plus sur eux.]],
[[L'onglet des |cffffd200Dresseurs|r vous informe sur leurs mascotttes, tels que:

• Leurs capacitées.
• Les quêtes journalières et les récompenses.
• Le lieu de rencontre.]],
[[Vous pouvez aussi filtrer quelles mascottes sont affichées en tapant dans la recherche. Voici quelques exemples:

• |cffffd200Aki|r pour Aki l’Élue.
• |cffffd200Draenor|r pour les dresseurs se trouvant en Draenor.
• |cffffd200Épique|r pour les dresseurs avec une équipe composée de mascottes épiques.
• |cffffd200> 20|r pour les dresseurs supérieur au niveau 20.]],
[[PetTracker enregistre les combats que vous avez fait contre chaque dresseurs. Sélectionner un combat et cliquez sur |cffffd200Charger l'équipe|r pour recharger rapidement les mascottes utilisées lors de ce combat.]]
}
