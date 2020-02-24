--[[
  Portuguese Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'ptBR')
if not L then return end

-- main
L.AddWaypoint = 'Adicionar Ponto de Destino'
L.AskForfeit = 'Não apareceram melhorias. Desistir do combate?'
L.AvailableBreeds = 'Raças Disponíveis'
L.Breed = 'Raça'
L.BreedExplanation = 'Determina como os atributos ganhos em cada nível são distribuídos.'
L.CapturedPets = 'Mostrar Capturados'
L.CommonSearches = 'Procuras Comuns'
L.FilterPets = 'Filtrar Mascotes'
L.ShowJournal = 'Mostrar no Diário'
L.NoHistory = 'O PetTracker nunca o viu lutar\ncontra este adversário'
L.NoneCollected = 'Nenhum Capturado'
L.Rivals = 'Rivais'
L.ShowPets = 'Mostrar Mascotes'
L.ShowStables = 'Mostrar Estábulos'
L.StableTip = '|cffffd200Aqui poderá pagar para|ncurar as suas mascotes.|r'
L.TellMore = 'Conte-me mais sobre si.'
L.UpgradeAlert = 'Apareceram melhorias!'

-- options
L.AlertUpgrades = 'Aviso de Melhorias'
L.AlertUpgradesTip = 'Se desligado, a caixa de aviso de melhorias não aparecerá em combate, mas mascotes serão ainda assim marcadas com o símbolo (|TInterface\\GossipFrame\\AvailableQuestIcon:0:0:-1:-2|t).'
L.Forfeit = 'Sugerir Desistir'
L.ForfeitTip = 'Se ligado, será sugerido desistir do combate quando não existirem melhorias.'

L.FAQ = {
	'Como escondo/mostro todas as mascotes no mapa?',
	'Clique na lupa no canto superior direito do mapa. Clique em Mostrar Mascotes.',

	'Como faço o mapa mostrar só algumas mascotes?',
	'Há uma caixa de pesquisa no canto superior direito do mapa, junto à lupa. Veja o tutorial para alguns exemplos.',

	'Como mostro o Rastreador de Zona de novo?',
	'Abra o Diário de Mascotes e clique em Rastreador de Zona no canto inferior direito.',

	'Como mostro as mascotes que já capturei no Rastreador de Zona?',
	'Clique em Mascotes no Rastreador e ligue a opção Mostrar Capturados'
}
