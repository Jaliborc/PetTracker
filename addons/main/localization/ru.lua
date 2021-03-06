--[[
	Russian Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'ruRU')
if not L then return end

-- main
L.AddWaypoint = 'Добавить точку'
L.AskForfeit = 'Обновлений нет. Покинуть бой?'
L.AvailableBreeds = 'Доступные породы'
L.Breed = 'Порода'
L.BreedExplanation = 'Определяет, как распределяются характеристики, полученные на каждом уровне'
L.CapturedPets = 'Пойманные питомцы'
L.CommonSearches = 'Частые запросы'
L.FilterSpecies = 'Фильтр питомцев'
L.ShowJournal = 'Показать в журнале'
L.Ninja = 'Ниндзя'
L.NoHistory = 'PetTracker не видел, чтобы вы\nсражались с этим противником'
L.NoneCollected = 'Не в коллекции'
L.Rivals = 'Соперники'
L.ShowJournal = 'Показать в журнале'
L.ShowPets = 'Показать боевых питомцев'
L.ShowStables = 'Показать смотрителей'
L.Species = 'Виды'
L.StableTip = '|cffffd200Приходите сюда, чтобы исцелить ваших питомцев за небольшую плату|r'
L.TellMore = 'Расскажите подробнее о себе.'
L.TotalRivals = 'Всего соперников'
L.UpgradeAlert = 'Присутствуют обновления!'

-- automatic
L.EnemyTeam = 'Команда противника'
L.Maximized = 'макс. уровень'
L.Source1 = 'Источник'
L.Source5 = 'Битвы питомцев'

-- options
L.AlertUpgrades = 'Предупреждение об обновлении'
L.AlertUpgradesTip = 'Если этот параметр отключен, окно предупреждения об обновлении не будет отображаться в бою, но улучшения все равно будут отмечены символом (|TInterface\\GossipFrame\\AvailableQuestIcon:0:0:-1:-2|t).'
L.Forfeit = 'Запрос на отступление'
L.ForfeitTip = 'Если включено, вам будет предложено покинуть бой при отсутствии обновлений.'
L.OptionsDescription = 'Эти параметры позволяют включать и выключать общие функции PetTracker. Поймай их всех!'
L.RivalPortraits = 'Портреты соперников'
L.RivalPortraitsTip = 'Если этот параметр включен, соперники будут отмечены своими портретами при отображении на карте.'
L.SpecieIcons = 'Иконки видов'
L.SpecieIconsTip = 'Если этот параметр отключен, питомцы будут отмечены значками семейств, а не видов при отображении на карте.'
L.Switcher = 'Переключатель питомцев'
L.SwitcherTip = 'Если этот параметр включен, стандартный интерфейс переключения питомцев в бою будет заменен улучшенным.'
L.TrackPetsTip = 'Если этот параметр включен, под целями заданий будет отображаться список прогресса поимки питомцев в текущей зоне.'

L.FAQ = {
	'Как показать/скрыть всех питомцев на карте?',
	'Нажмите на кнопку с лупой в правом верхнем углу карты. Нажмите на "Виды" в разделе "Питомцы".',

	'Как сделать, чтобы только определенные питомцы отображались на карте?',
	'Существует окно фильтров в правом верхнем углу карты. Смотрите руководство для примеров поиска.',

	'Как отобразить список прогресса поимки питомцев в зоне?',
	'Откройте Атлас питомцев и нажмите "Выслеживание питомцев" в правом нижнем углу.',

	'Как отобразить питомцев, которых я уже поймал в зоне?',
	'Нажмите на "Питомцы" в списке прогресса и включите "Пойманные питомцы"',

	'Как переместить панель умений противника?',
	'Удерживайте Shift и перетащите панель.',
}

L.Tutorial = {
[[Добро пожаловать! Теперь вы используете |cffffd200PetTracker|r, |cffffd200Jaliborc'а|r.

Это краткое руководство поможет вам быстро приступить к работе с аддоном, чтобы вы делали то, что действительно важно: поймали их всех!]],

[[PetTracker поможет следить за вашим прогрессом в зоне, где вы находитесь.

|cffffd200Выслеживание питомцев|r отображает питомцев, которых вам не хватает, их семейства, и редкость тех, что вы уже поймали.]],

[[Нажмите на |cffffd200Питомцы|r для отключения отслеживания или дополнительных опций.]],

[[Откройте |cffffd200Карту|r чтобы посмотреть, что PetTracker может сделать для ваших исследований.]],

[[PetTracker отображает возможные источники питомцев на карте мира, от точек появления до продавцов. Он также отображает стойла и дополнительную информацию об укротителях.

Чтобы скрыть их местоположения, откройте меню отслеживания и отключите опции в разделе |cffffd200Питомцы|r.]],

[[Можно также отфильтровать питомцев путем ввода в поле поиска. Вот несколько примеров:

• |cffffd200Кошки|r для кошек.
• |cffffd200отсутствующие|r для видов, которыми вы не владеете.
• |cffffd200Водные|r для водных видов.
• |cffffd200Задание|r для видов, получаемых через квесты.
• |cffffd200Лесной|r для видов, которые населяют леса.]],

[[Откройте |cffffd200Атлас питомцев|r чтобы посмотреть, что PetTracker может сделать для вас.]],
[[Этот флажок позволяет включить |cffffd200Выслеживание питомцев|r. Это особенно полезно, если вы скрыли эту функцию ранее.]],
[[Откройте вкладку |cffffd200Соперников|r чтобы узнать о них больше.]],
[[Вкладка |cffffd200Соперников|r предостовляет такую информацию о сражениях как:

• Вражеские питомцы и их способности.
• Ежедневные задания и награды.
• Расположения соперников.]],
[[Можно также отфильтровать отображаемых соперников путем ввода в поле поиска. Вот несколько примеров:

• |cffffd200Aki|r чтобы выбрать Aki.
• |cffffd200Доблесть|r для соперников, которые награждаются доблестью.
• |cffffd200Дренор|r для соперников, расположенных на Дреноре.
• |cffffd200Эпические|r для соперников с эпической редкостью команд.
• |cffffd200> 20|r для соперников, уровень которых меньше 20.]],
[[PetTracker записывает ваши бои с каждым соперником. Выберите сражение и нажмите |cffffd200Загрузить команду|r, чтобы быстро выставить питомцев, которых вы использовали.]]
}
