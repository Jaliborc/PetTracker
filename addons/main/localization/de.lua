--[[
	German Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'deDE')
if not L then return end

-- main
L.AddWaypoint = 'Wegpunkt hinzuf\195\188gen'
L.AskForfeit = 'Keine Upgrades verf\195\188gbar. Kampf beenden?'
L.AvailableBreeds = 'Verf\195\188gbare Z\195\188chtungen'
L.Breed = 'Z\195\188chtung'
L.BreedExplanation = 'Legt fest, wie die pro Stufenaufstieg gewonnenen Werte verteilt werden.'
L.CapturedPets = 'Zeige gefangene Haustiere'
L.CommonSearches = 'H\195\164ufige Suchbegriffe'
L.FilterPets = 'Haustiere filtern'
L.LoadTeam = 'Team laden'
L.Ninja = 'Ninja'
L.NoHistory = 'PetTracker hat dich noch nie gegen diesen Rivalen k\195\164mpfen sehen'
L.NoneCollected = 'Nicht gesammelt'
L.Rivals = 'Rivalen'
L.ShowJournal = 'Im Wildtierf\195\188hrer anzeigen'
L.ShowPets = 'Kampfhaustiere anzeigen'
L.ShowStables = 'Stallmeister anzeigen'
L.Species = 'Art'
L.StableTip = '|cffffd200Hier k\195\182nnen Haustiere gegen eine|nkleine Geb\195\188hr geheilt werden.|r'
L.TellMore = 'Erz\195\164hle mir mehr über unsere Vergangenheit.'
L.UpgradeAlert = 'Besseres Kampfhaustier entdeckt!'
L.TotalRivals = 'Alle Rivalen'

-- options
L.AlertUpgrades = 'Hinweis bei Upgrades'
L.AlertUpgradesTip = 'Wenn deaktiviert, wird die Upgrade-Hinweismeldung nicht im Kampf gezeigt, aber Upgrades werden immer noch mit einem Symbol gekennzeichnet (|TInterface\\GossipFrame\\AvailableQuestIcon:0:0:-1:-2|t).'
L.Forfeit = 'Aufforderung zum Aufgeben'
L.ForfeitTip = 'Wenn aktiviert, wirst Du aufgefordert, einen Kampf aufzugeben, wenn keine Upgrades verf\195\188gbar sind.'
L.FAQDescription = 'Dies sind die am h\195\164ufigsten gestellten Fragen. Um das Tutorial erneut zu betrachten, setze die Einstellungen zur\195\188ck, indem du den "Standard"-Knopf in der unteren linken Ecke benutzt.'

L.FAQ = {
	'Wie kann ich alle Haustiere auf der Karte ein- und ausblenden?',
	'Klicke auf die Lupe in der oberen rechten Ecke der Karte. Klicke auf "Kampfhaustiere anzeigen".',

	'Wie zeige ich nur bestimmte Haustiere auf der Karte?',
	'In der rechten oberen Ecke der Karte befindet sich eine Filterbox. Im Tutorial finden sich Suchbeispiele.',

	'Wie kann ich den Zonen-Tracker wieder anzeigen?',
	'Öffne den Wildtierführer und klicke in der rechten unteren Ecke auf "Zonen-Tracker".',

	'Wie kann ich die Haustiere, die ich im Zonen-Tracker erfasst habe, anzeigen lassen?',
	'Klicke auf "Haustiere" im Tracker und aktiviere "Zeige gefangene Haustiere".',
}

L.Tutorial = {
[[Herzlich willkommen! Du benutzt jetzt |cFFF96854Jaliborcs|r |cffffd200PetTracker|r.

Seit Pandaria hat sich viel verändert. Dieses Tutorial hilft dir loszulegen, damit du dich schnell wieder dem wirklich Wichtigen widmen kannst: Sie dir alle zu schnappen... ähm... alle Haustiere einzufangen!]],

[[PetTracker hilft dir, deinen Fortschritt in der Zone, in der du dich befindest, zu überwachen.

Der |cffffd200Zonen-Tracker|r zeigt dir noch fehlende Haustiere sowie ihren Ursprung an, dazu die Seltenheit derjenigen, die du gefangen hast.]],

[[Klicke auf |cffffd200Begleiter|r, um den Tracker zu deaktivieren oder um zusätzliche Optionen zu aktivieren.]],

[[Öffne die |cffffd200Weltkarte|r, um zu sehen, wie dir PetTracker beim Sammeln helfen kann.]],

[[PetTracker zeigt möglichen Quellen von Haustieren auf der Weltkarte an, vom Spawnpunkt bis zum Händler. Es zeigt auch Stallmeister und zusätzliche Informationen über Zähmer an.

Um diese Orte auszublenden, öffne das Tracking-Menü und deaktiviere |cffffd200Kampfhaustiere anzeigen|r.']],

[[Durch Eingabe im Suchfeld wird gefiltert, welche Haustiere angezeigt werden. Hier sind einige Beispiele:

• |cffffd200Katze|r für Katzen.
• |cffffd200Fehlt|r für nicht gesammelte Arten.
• |cffffd200Aquatisch|r für aquatische Arten.
• |cffffd200Quest|r für Arten, die als Questbelohnung erhalten werden.
• |cffffd200Wald|r für Arten, die Wälder bewohnen.]],

[[Öffne den |cffffd200Wildtierführer|r, um zu sehen, wie PetTracker dir in deiner Sammlung hilft.]],
[[Dieses Kästchen ermöglicht es, den |cffffd200Zonen-Tracker|r zu aktivieren. Besonders nützlich, wenn er zuvor versteckt wurde.]],
[[Öffne den |cffffd200Rivalen|r-Reiter, um mehr darüber zu erfahren.]],
[[Der |cffffd200Rivalen|r-Reiter liefert Informationen über vorhandene Haustierkampfbegegnungen, wie z.B.:

• Gegnerische Haustiere und ihre Fähigkeiten.
• Tägliche Quests und ihre Belohnungen.
• Den jeweiligen Ort.]],
[[Durch Eingabe im Suchfeld wird gefiltert, welche Haustiere angezeigt werden. Hier sind einige Beispiele:

• |cffffd200Aki|r für Aki the Chosen.
• |cffffd200Draenor|r für Rivalen in Draenor.
• |cffffd200Episch|r für Rivalen mit Teams von epischer Qualität.
• |cffffd200> 20|r für Rivalen über Level 20.]],
[[PetTracker zeichnet alle Kämpfe mit Rivalen auf. Wähle einen Kampf und klicke auf |cffffd200Team laden|r, um die Haustiere, die du damals benutzt hast, zu laden.]],
}
