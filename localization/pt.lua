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
L.FilterSpecies = 'Filtrar Mascotes'
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

L.Tutorial = {
[[Bem-vindo! Agora está a utilizar o |cffffd200PetTracker|r, criado por |cffffd200Jaliborc|r.

Este tutorial opcional vai ajudá-lo a começar. Depois, pode voltar ao que é realmente importante: apanhar... hum... capturar todos!]],

[[O |cffffd200Rastreador de Zona|r mostra quais os mascotes que lhe faltam na sua zona atual, a sua origem, e a raridade dos que já capturou.

|A:NPE_LeftClick:14:14|a Clique no cabeçalho |cffffd200"Mascotes"|r para opções adicionais.]],

[[Abra o |cffffd200Mapa do Mundo|r para ver o que o PetTracker pode fazer pela sua exploração.]],

[[O PetTracker mostra as possíveis fontes de mascotes no mapa do mundo. Também mostra estábulos e informações adicionais sobre os domadores.

Para filtrar ou ocultar essas localizações, |A:NPE_LeftClick:14:14|a abra o menu |cffffd200"Filtro de Mapa"|r.]],

[[Pode filtrar quais os mascotes a mostrar escrevendo na caixa de |cffffd200"Filtrar Espécies"|r. Aqui estão alguns exemplos:

• |cffffd200Gato|r para gatos.
• |cffffd200Faltam|r para espécies que não possui.
• |cffffd200Aquático|r para espécies aquáticas.
• |cffffd200Missão|r para mascotes obtidos através de missões.
• |cffffd200Floresta|r para espécies que habitam florestas.

Operadores matemáticos também funcionam:
• |cffffd200< Raro|r para espécies que lhe faltam com qualidade rara.
• |cffffd200< 15|r para espécies com mascotes abaixo do nível 15.]],

[[Abra o |cffffd200Diário de Mascotes|r para ver o que o PetTracker pode fazer para a sua navegação.]],

[[Esta caixa de seleção permite-lhe ativar ou desativar o |cffffd200Rastreador de Zona|r. É especialmente útil se já escondeu o rastreador anteriormente.]],

[[Abra o separador |cffffd200Rivais|r para saber mais sobre ele.]],

[[O separador |cffffd200Rivais|r fornece informações sobre os encontros de batalha de mascotes existentes, como:

• Mascotes inimigos e as suas habilidades.
• Missões diárias e recompensas.
• Localização dos encontros.]],

[[Pode filtrar quais os rivais a mostrar escrevendo na caixa de pesquisa. Aqui estão alguns exemplos:

• |cffffd200Aki|r para Aki a Escolhida.
• |cffffd200Valor|r para rivais que concedem valor.
• |cffffd200Draenor|r para rivais localizados em Draenor.
• |cffffd200Épico|r para rivais com equipas de raridade épica.
• |cffffd200> 20|r para rivais com nível acima de 20.]],

[[O PetTracker regista as batalhas que teve com cada rival. Selecione uma batalha e clique em |cffffd200Carregar Equipa|r para recarregar rapidamente os mascotes que usou contra eles.]]
}