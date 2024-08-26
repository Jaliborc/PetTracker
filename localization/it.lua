--[[
	Italian Localization
]]--

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'itIT')
if not L then return end

-- main
L.AddWaypoint = 'Aggiungi Waypoint'
L.AskForfeit = 'Nessun miglioramento disponibile. Abbandona il match?'
L.AvailableBreeds = 'Available Breeds'
L.Breed = 'Breed'
L.BreedExplanation = 'Determina come sono distribuite le statistiche guadagnate ogni livello.'
L.CapturedPets = 'Mostra i Catturati'
L.CommonSearches = 'Ricerche comuni'
L.FilterSpecies = 'Filtra Mascotte'
L.ShowJournal = 'Mostra nel Giornale'
L.Ninja = 'Ninja'
L.NoHistory = 'PetTracker non ti ha mai visto\ncombattere questo avversario'
L.NoneCollected = 'Nessuno Collezionato'
L.Rivals = 'Rivali'
L.ShowPets = 'Mostra Mascotte da Battaglia'
L.ShowStables = 'Mostra Stalle'
L.StableTip = '|cffffd200Vieni qui per curare le tue|nmascotte ad un piccolo costo.|r'
L.TellMore = 'Parlami di più di Te.'
L.UpgradeAlert = 'Sono apparsi Miglioramenti selvatici!'

-- options
L.AlertUpgrades = 'Allarme per Miglioramenti'
L.AlertUpgradesTip = 'Se disabilitato, il box di allarme per un miglioramento selvatico non verrà mostrato in combattimento, ma i miglioramenti verranno comunque contrassegnati da un simbolo (|TInterface\\GossipFrame\\AvailableQuestIcon:0:0:-1:-2|t).'
L.Forfeit = 'Chiedi per Abbandono'
L.ForfeitTip = 'Se abilitato, ti verrà chiesto se vuoi abbandonare il match se non sono presenti miglioramenti.'

L.FAQ = {
	'Come posso mostrare/nascondere tutti le Mascotte sulla mappa?',
	'Clicca sul bottone con lente di ingrandimento in alto a destra della mappa. Clicca su "Mostra Mascotte da Battaglia".',

	'Come posso mostrare sulla mappa specifiche Mascotte?',
	'È presente un box filtro ina alto a destra della mappa del mondo. Guarda il tutorial per alcuni esempi comuni.',

	'Come posso far mostrare la Zone Tracker di nuovo?',
	'Apri il Giornale delle Mascotte e clicca "Zone Tracker" in basso a destra.',

	'Come posso mostrare le Mascotte che ho catturato nello Zone Tracker?',
	('Clicca su "%s" nel tracker e abilita "Mostra i Catturati"'):format(PETS),
}

L.Tutorial = {
[[Benvenuto! Stai ora utilizzando |cffffd200PetTracker|r, di |cffffd200Jaliborc|r.

Questo tutorial opzionale ti aiuterà ad iniziare. Dopodiché potrai tornare a fare ciò che è davvero importante: acchiappar... ehm... catturarli tutti!]],

[[Lo |cffffd200Zone Tracker|r mostra le mascotte che ti mancano nella tua zona attuale, la loro origine e la rarità di quelle che hai catturato.

|A:NPE_LeftClick:14:14|a Clicca sull'intestazione |cffffd200"Mascotte"|r per opzioni aggiuntive.]],

[[Apri la |cffffd200Mappa del Mondo|r per vedere cosa può fare PetTracker per la tua esplorazione.]],

[[PetTracker mostra le possibili fonti delle mascotte sulla mappa del mondo. Mostra anche le stalle e informazioni extra riguardo gli allenatori.

Per filtrare o nascondere questi luoghi, |A:NPE_LeftClick:14:14|a apri il menu |cffffd200"Filtro Mappa"|r.]],

[[Puoi filtrare quali mascotte mostrare scrivendo nel box di ricerca |cffffd200"Filtra Specie"|r. Ecco alcuni esempi:

• |cffffd200Gatto|r per gatti.
• |cffffd200Mancante|r per specie che non possiedi.
• |cffffd200Acquatico|r per specie acquatiche.
• |cffffd200Missioni|r per specie ottenibili attraverso le missioni.
• |cffffd200Foresta|r per specie che abitano nelle foreste.

Funzionano anche gli operatori matematici:
• |cffffd200< Raro|r per specie mancanti di una mascotte di qualità rara.
• |cffffd200< 15|r per specie con mascotte sotto il livello 15.]],

[[Apri il |cffffd200Giornale delle Mascotte|r per vedere cosa può fare PetTracker per la tua ricerca.]],

[[Questo checkbox ti permette di attivare lo |cffffd200Zone Tracker|r. È particolarmente utile se hai disattivato il tracker precedentemente.]],

[[Apri il tab |cffffd200Rivali|r per imparare di più al riguardo.]],

[[Il tab |cffffd200Rivali|r fornisce informazioni sugli incontri di combattimento delle mascotte esistenti, come:

• Mascotte nemiche e le loro abilità.
• Missioni giornaliere e le loro ricompense.
• Luoghi degli incontri.]],

[[Puoi filtrare quali mascotte sono visualizzate scrivendo nel box di ricerca. Ecco alcuni esempi:

• |cffffd200Aki|r per Aki la Prescelta.
• |cffffd200Valore|r per rivali che ti ricompensano con punti valore.
• |cffffd200Draenor|r per rivali localizzati su Draenor.
• |cffffd200Epica|r per rivali con squadre di rarità epica.
• |cffffd200> 20|r per rivali superiori al livello 20.]],

[[PetTracker registra i combattimenti che hai disputato con ogni rivale. Seleziona un combattimento e clicca su |cffffd200Carica Squadra|r per ricaricare velocemente le mascotte che hai usato precedentemente.]]
}