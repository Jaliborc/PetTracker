--[[
	Spanish Localization by (EU) Krovikan-Minahonda
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'esES') or LibStub('AceLocale-3.0'):NewLocale(ADDON, 'esMX')
if not L then return end

-- main
L.AddWaypoint = 'Añadir Punto de Destino'
L.AskForfeit = 'No aparecieron mejoras. ¿Rendirse?'
L.AvailableBreeds = 'Variedades Disponibles'
L.Breed = 'Variedad'
L.BreedExplanation = 'Determinar cómo se distribuyen los atributos recibidos en cada nivel.'
L.CapturedPets = 'Mostrar Capturadas'
L.CommonSearches = 'Búsquedas Comunes'
L.FilterSpecies = 'Filtrar Mascotas'
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
	'Haz click en el botón de la lupa en la esquina superior derecha del mapa. Click en "Especies" en la sección "Mascotas".',

	'¿Cómo puedo hacer que el mapa muestre sólo unas mascotas específicas',
	'Hay un caja de filtros en la esquina superior derecha del mapa del mundo. Mira el tutorial para ejemplos comunes de búsqueda.',

	'¿Cómo puedo mostrar mi progreso de capturas para los objetivos nuevos?',
	'Abre el Diario de Mascotas y haz click en "Rastrear Mascotas" en la esquina inferior derecha.',

	'¿Cómo puedo mostrar las mascotas que he capturado en los objetivos de la zona?',
	'Haz click en el título "Mascotas" del rastreador y activa "Mostrar Capturadas".',

	'¿Cómo puedo mover la barra de acción del enemigo?',
	'Mantén pulsada la tecla mayúsculas y arrastra la barra.',
}

L.Tutorial = {
[[¡Bienvenido! Estás usando |cffffd200PetTracker|r, creado por |cffffd200Jaliborc|r.

Este tutorial opcional te ayudará a comenzar. Luego podrás volver a hacer lo que realmente importa: ¡atraparlos... ejem... capturarlos a todos!]],

[[El |cffffd200Rastreador de Zona|r muestra qué mascotas te faltan en tu zona actual, su origen, y la rareza de las que has capturado.

|A:NPE_LeftClick:14:14|a Haz clic en el encabezado |cffffd200"Mascotas"|r para opciones adicionales.]],

[[Abre el |cffffd200Mapa del Mundo|r para ver en lo que te puede ayudar PetTracker en tu exploración.]],

[[PetTracker muestra las posibles fuentes de mascotas en el mapa del mundo. También muestra los establos e información adicional sobre los rivales.

Para filtrar o ocultar estas ubicaciones, |A:NPE_LeftClick:14:14|a abre el menú |cffffd200"Filtro del Mapa"|r.]],

[[Puedes filtrar qué mascotas se muestran escribiendo en la caja de búsqueda |cffffd200"Filtrar Especies"|r. Aquí tienes algunos ejemplos:

• |cffffd200Gato|r para buscar gatos.
• |cffffd200Falta|r para especies que no posees.
• |cffffd200Acuático|r para especies acuáticas.
• |cffffd200Misión|r para mascotas obtenibles a través de misiones.
• |cffffd200Bosque|r para especies que habitan en bosques.

También funcionan los operadores matemáticos:
• |cffffd200< Raro|r para especies que te faltan en calidad rara.
• |cffffd200< 15|r para especies con mascotas por debajo del nivel 15.]],

[[Abre el |cffffd200Diario de Mascotas|r para ver lo que PetTracker puede hacer por ti mientras lo examinas.]],
[[Esta casilla te permite activar o desactivar el |cffffd200Rastreador de Zona|r. Es especialmente útil si ocultastes el rastreador alguna vez.]],
[[Abre la pestaña |cffffd200Rivales|r para aprender más sobre ellos.]],
[[La pestaña |cffffd200Rivales|r proporciona información sobre los encuentros de combates de mascotas existentes, como:

• Las mascotas del Rival y sus habilidades.
• Misiones diarias y recompensas.
• Localización del encuentro.]],
[[También puedes filtrar qué  mascotas son mostradas escribiendo en el cajón de búsqueda. Algunos ejemplos:

• |cffffd200Aki|r para Aki la Elegida.
• |cffffd200Talismán|r para rivales que otorgan Talismanes de recompensa.
• |cffffd200Draenor|r para rivales localizados en Draenor.
• |cffffd200Épico|r para rivales con equipos de rareza épica.
• |cffffd200> 20|r para rivales de nivel superior a 20.]],
[[PetTracker graba los combates que has tenido con cada rival. Selecciona una lucha y haz click en |cffffd200Cargar Equipo|r para recargar rápidamente las mascotas que usastes contra ellos.]]
}
