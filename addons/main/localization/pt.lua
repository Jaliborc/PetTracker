if GetLocale() ~= 'ptBR' then return end
local _, Addon = ...
local L = Addon.Locals

L.AddWaypoint = 'Adicionar Ponto de Destino'
L.AlertUpgrades = 'Aviso de Melhorias'
L.AlertUpgradesTip = 'Se desligado, a caixa de aviso de melhorias não aparecerá em combate, mas mascotes serão ainda assim marcadas com o símbolo (|TInterface\\GossipFrame\\AvailableQuestIcon:0:0:-1:-2|t).'
L.AskForfeit = 'Não apareceram melhorias. Desistir do combate?'
L.AvailableBreeds = '\nRaças Disponíveis:'
L.PromptForfeit = 'Sugerir Desistir'
L.PromptForfeitTip = 'Se ligado, será sugerido desistir do combate quando não existirem melhorias.'
L.Breed = 'Raça'
L.BreedExplanation = 'Determina como os atributos ganhos em cada nível são distribuídos.'
L.CapturedPets = 'Mostrar Capturados'
L.CommonSearches = 'Procuras Comuns'
L.EnemyTeam = 'Equipa Adversária'
L.FilterPets = 'Filtrar Mascotes'
L.ShowJournal = 'Mostrar no Diário'
L.Maximized = 'Maximizado'
L.NoHistory = 'O PetTracker nunca o viu lutar\ncontra este adversário'
L.NoneCollected = 'Nenhum Capturado'
L.Rivals = 'Rivais'
L.ShowPets = 'Mostrar Mascotes'
L.ShowStables = 'Mostrar Estábulos'
L.StableTip = '|cffffd200Aqui poderá pagar para|ncurar as suas mascotes.|r'
L.TrackPets = 'Listar Mascotes'
L.TellMore = 'Conte-me mais sobre si.'
L.UpgradeAlert = 'Apareceram melhorias!'
L.ZoneTracker = 'Rastreador de Zona'
L.Victory = 'Vitória'
L.Defeat = 'Derrota'

L.FAQ = {
	'Como escondo/mostro todas as mascotes no mapa?',
	'Clique na lupa no canto superior direito do mapa. Clique em Mostrar Mascotes.',

	'Como faço o mapa mostrar só algumas mascotes?',
	'Há uma caixa de pesquisa no canto superior direito do mapa, junto à lupa. Veja o tutorial para alguns exemplos.',

	'Como mostro o Rastreador de Zona de novo?',
	'Abra o Diário de Mascotes e clique em Rastreador de Zona no canto inferior direito.',

	'Como mostro as mascotes que já capturei no Rastreador de Zona?',
	'Clique em Mascotes no Rastreador e ligue a opção Mostrar Capturados',

	'Como desligo todos os avisos de melhorias?',
	'Vá ao MAIN MENU, abra a lista de addons e desligue PetTracker Upgrades.',

	'Como posso ver o tutorial de novo?',
	'Clique no botão à sua direita.'
}
