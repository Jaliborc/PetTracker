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
L.FilterPets = 'Filtra Mascotte'
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

Molti sono stati i cambiamenti da Pandaria, perciò questo addon ti aiuterà ad iniziare velocemente. Dopodichè potrai tornare a fare quello che davvero è importante: di acchiappar... ahem... catturarli tutti!]],

[[PetTracker ti aiuterà a monitorare i tuoi progressi nella zona in cui ti trovi.

Lo |cffffd200Zone Tracker|r mostra le Mascotte che ti mancano, le loro origini, e la rarità di quelli che hai catturato.]],

[[Clicca su |cffffd200Mascotte da Battaglia|r per attivare il tracker o opzioni addizionali.]],

[[Apri la |cffffd200Mappa del Mondo|r per vedere cosa può fare PetTracker per la tua esplorazione.]],

[[PetTracker mostra le possibili fonti delle Mascotte sulla mappa del mondo, dai punti di apparizione ai venditori. Mostra anche le stalle ed informazioni extra riguardo gli allentori.

Per nascondere questi luoghi, apri il menu di tracking e disabilita |cffffd200Mostra Mascotte da Battaglia|r.]],

[[Puoi anche filtrare quali Mascotte mostrare scrivendo nel box di ricerca. Ecco alcuni esempi:

• |cffffd200Gatto|r per gatti.
• |cffffd200mancante|r per specie che non hai.
• |cffffd200Acquatico|r per specie acquatiche.
• |cffffd200Missioni|r per specie ottenibili attraverso le missioni.
• |cffffd200Foresta|r per specie che abitano nelle foreste.]],

[[Apri il |cffffd200Giornale delle Mascotte|r per vedere cosa può fare PetTracker per la tua ricerca.]],
[[Questo checkbox ti permette di attivare lo |cffffd200Zone Tracker|r. È utile specialmene se hai disattivato il tracker precedentemente.]],
[[Apri il tab |cffffd200Rivali|r per impare di più sul loro riguardo.]],
[[Il tab |cffffd200Rivali|r ti da ulteriori informazioni riguardo gli incontri esistenti delle Mascotte da battaglia, come:

• Mascotte nemiche e loro abilità.
• Missioni giornaliere e loro ricompense.
• Luoghi degli incontri.]],
[[Puoi anche filtrare quali Mascotte sono visualizzate scrivendo nel box di ricerca. Ecco alcuni esempi:

• |cffffd200Aki|r per Aki la Prescelta.
• |cffffd200Valore|r per rivali che ti ricompensano con punti valore.
• |cffffd200Draenor|r per rivali localizzati su Draenor.
• |cffffd200Epica|r per rivali con squadre di rarità epica.
• |cffffd200> 20|r per rivali superiori al livello 20.]],
[[PetTracker registra i combattimenti che hai disputato con ogni rivale. Seleziona un combattimento e clicca su |cffffd200Carica Squadra|r per ricaricare velocemte le Mascotte che tu hai usato precedentemente.]]
}
