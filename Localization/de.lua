if GetLocale() ~= 'deDE' then return end
local _, Addon = ...
local L = Addon.Locals

L.AddWaypoint = 'Wegpunkt hinzuf\195\188gen'
L.AlertUpgrades = 'Hinweis bei Upgrades'
L.AlertUpgradesTip = 'Wenn deaktiviert, wird die Upgrade-Hinweismeldung nicht im Kampf gezeigt, aber Upgrades werden immer noch mit einem Symbol gekennzeichnet (|TInterface\\GossipFrame\\AvailableQuestIcon:0:0:-1:-2|t).'
L.AskForfeit = 'Keine Upgrades verf\195\188gbar. Kampf beenden?'
L.AvailableBreeds = '\nVerf\195\188gbare Z\195\188chtungen:'
L.Battles = 'K\195\164mpfe'
L.Breed = 'Z\195\188chtung'
L.BreedExplanation = 'Legt fest, wie die pro Stufenaufstieg gewonnenen Werte verteilt werden.'
L.CapturedPets = 'Zeige gefangene Haustiere'
L.CommonSearches = 'H\195\164ufige Suchbegriffe'
L.Defeat = 'Niederlage'
L.EnemyTeam = 'Gegnerisches Team'
L.FAQDescription = 'Dies sind die am h\195\164ufigsten gestellten Fragen. Um das Tutorial erneut zu betrachten, setze die Einstellungen zur\195\188ck, indem du den "Standard"-Knopf in der unteren linken Ecke benutzt.'
L.FilterPets = 'Haustiere filtern'
L.LoadTeam = 'Team laden'
L.Maximized = 'Maximiert'
L.Ninja = 'Ninja'
L.NoHistory = 'PetTracker hat dich noch nie gegen diesen Rivalen k\195\164mpfen sehen'
L.NoneCollected = 'Nicht gesammelt'
L.PetBattle = 'Haustierkampf'
L.PromptForfeit = 'Aufforderung zum Aufgeben'
L.PromptForfeitTip = 'Wenn aktiviert, wirst Du aufgefordert, einen Kampf aufzugeben, wenn keine Upgrades verf\195\188gbar sind.'
L.Rivals = 'Rivalen'
L.ShowJournal = 'Im Wildtierf\195\188hrer anzeigen'
L.ShowPets = 'Kampfhaustiere anzeigen'
L.ShowStables = 'Stallmeister anzeigen'
L.Species = 'Art'
L.StableTip = '|cffffd200Hier k\195\182nnen Haustiere gegen eine|nkleine Geb\195\188hr geheilt werden.|r'
L.TrackPets = 'Haustiere verfolgen'
L.TellMore = 'Erz\195\164hle mir mehr über unsere Vergangenheit.'
L.UnlockActions = 'Entsperre gegnerische F\195\164higkeitsleiste'
L.UnlockActionsTip = 'Wenn aktiviert, kann die gegnerische F\195\164higkeitsleiste an eine beliebige Stelle auf dem Bildschirm gezogen werden.'
L.UpgradeAlert = 'Besseres Kampfhaustier entdeckt!'
L.TotalRivals = 'Alle Rivalen'
L.Victory = 'Sieg'
L.ZoneTracker = 'Zonen-Tracker'

for i = 1, C_PetJournal.GetNumPetSources() do
	L['Source' .. i] = _G['BATTLE_PET_SOURCE_' .. i] -- do not translate. Automatic for most locales
end

L.FAQ = {
	'Wie kann ich alle Haustiere auf der Karte ein- und ausblenden?',
	'Klicke auf die Lupe in der oberen rechten Ecke der Karte. Klicke auf "' .. L.ShowPets .. '".',

	'Wie zeige ich nur bestimmte Haustiere auf der Karte?',
	'In der rechten oberen Ecke der Karte befindet sich eine Filterbox. Im Tutorial finden sich Suchbeispiele.',

	'Wie kann ich den Zonen-Tracker wieder anzeigen?',
	'Öffne den Wildtierführer und klicke in der rechten unteren Ecke auf "' .. L.ZoneTracker .. '".',

	'Wie kann ich die Haustiere, die ich im Zonen-Tracker erfasst habe, anzeigen lassen?',
	'Klicke auf "Begleiter" im Tracker und aktiviere "' .. L.CapturedPets .. '".',

	'Wie kann ich alle Upgrade-Hinweise deaktivieren?',
	'Gehe ins Hauptmenü, öffne die Liste der Addons und deaktiviere unter PetTracker "' .. L.AlertUpgrades .. '."'
}

L.Tutorial = {
[[Herzlich willkommen! Du benutzt jetzt |cFFF96854Jaliborcs|r |cffffd200PetTracker|r.

Seit Pandaria hat sich viel verändert. Dieses Tutorial hilft dir loszulegen, damit du dich schnell wieder dem wirklich Wichtigen widmen kannst: Sie dir alle zu schnappen... ähm... alle Haustiere einzufangen!]],

string.format([[PetTracker hilft dir, deinen Fortschritt in der Zone, in der du dich befindest, zu überwachen.

Der |cffffd200%s|r zeigt dir noch fehlende Haustiere sowie ihren Ursprung an, dazu die Seltenheit derjenigen, die du gefangen hast.]], L.ZoneTracker),

[[Klicke auf |cffffd200Begleiter|r, um den Tracker zu deaktivieren oder um zusätzliche Optionen zu aktivieren.]],

[[Öffne die |cffffd200Weltkarte|r, um zu sehen, wie dir PetTracker beim Sammeln helfen kann.]],

string.format([[PetTracker zeigt möglichen Quellen von Haustieren auf der Weltkarte an, vom Spawnpunkt bis zum Händler. Es zeigt auch Stallmeister und zusätzliche Informationen über Zähmer an.

Um diese Orte auszublenden, öffne das Tracking-Menü und deaktiviere |cffffd200%s|r.']], L.ShowPets),

[[Durch Eingabe im Suchfeld wird gefiltert, welche Haustiere angezeigt werden. Hier sind einige Beispiele:

• |cffffd200Katze|r für Katzen.
• |cffffd200Fehlt|r für nicht gesammelte Arten.
• |cffffd200Aquatisch|r für aquatische Arten.
• |cffffd200Quest|r für Arten, die als Questbelohnung erhalten werden.
• |cffffd200Wald|r für Arten, die Wälder bewohnen.]]
}

L.JournalTutorial = {
[[Öffne den |cffffd200Wildtierführer|r, um zu sehen, wie PetTracker dir in deiner Sammlung hilft.]],
string.format([[Dieses Kästchen ermöglicht es, den |cffffd200%s|r zu aktivieren. Besonders nützlich, wenn er zuvor versteckt wurde.]], L.ZoneTracker),
string.format([[Öffne den |cffffd200%s|r-Reiter, um mehr darüber zu erfahren.]], L.Rivals),
string.format([[Der |cffffd200%s|r-Reiter liefert Informationen über vorhandene Haustierkampfbegegnungen, wie z.B.:

• Gegnerische Haustiere und ihre Fähigkeiten.
• Tägliche Quests und ihre Belohnungen.
• Den jeweiligen Ort.]], L.Rivals),
[[Durch Eingabe im Suchfeld wird gefiltert, welche Haustiere angezeigt werden. Hier sind einige Beispiele:

• |cffffd200Aki|r für Aki the Chosen.
• |cffffd200Draenor|r für Rivalen in Draenor.
• |cffffd200Episch|r für Rivalen mit Teams von epischer Qualität.
• |cffffd200> 20|r für Rivalen über Level 20.]],
string.format([[PetTracker zeichnet alle Kämpfe mit Rivalen auf. Wähle einen Kampf und klicke auf |cffffd200%s|r, um die Haustiere, die du damals benutzt hast, zu laden.]], L.LoadTeam),
}
