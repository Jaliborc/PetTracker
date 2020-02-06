local _, Addon = ...
local Pet = setmetatable(Addon:NewModule('RivalPet'), Addon.Specie)
local Rival = Addon:NewModule('Rival')

Rival.__index = Rival
Pet.__index = Pet


--[[ Constructors ]]--

function Rival:Get(id)
	local data = Addon.RivalInfo[id]
	if data then
		local name, model, map, quest, gold, items, currencies, pets = data:match('^([^:]+):(%w%w%w%w)(%w%w)(%w%w%w)(%w)([^:]*):([^:]*):(.*)$')
		local rival = setmetatable({
			name = name, items = items, currencies = currencies,
			gold = tonumber(gold, 36),
			quest = tonumber(quest, 36),
			model = tonumber(model, 36),
			map = tonumber(map, 36),
			id = id
		}, self)

		for name, model, specie, level, quality in pets:gmatch('([^:]+):(%w%w%w%w)(%w%w%w)(%w)(%w)') do
			tinsert(rival, setmetatable({
				Name = name,
				Model = tonumber(model, 36),
				Specie = tonumber(specie, 36),
				Level = tonumber(level, 36),
				Quality = tonumber(quality, 36)
			}, Pet))
		end

		return rival
	end
end


--[[ API ]]--

function Rival:Display()
	if GetAddOnEnableState(UnitName('player'), 'PetTracker_Journal') >= 2 then
		CollectionsJournal_LoadUI()
		HideUIPanel(WorldMapFrame)
		ShowUIPanel(CollectionsJournal) -- this here causes taint for sure
		PetTrackerRivalJournal.PanelTab:GetScript('OnClick')(PetTrackerRivalJournal.PanelTab)
		PetTrackerRivalJournal:SetRival(self)
	end
end

function Rival:GetMapName()
	local map = self:GetMap()
	if map then
		local info = C_Map.GetMapInfo(map)
		local parent = C_Map.GetMapInfo(info.parentMapID)
		return info.name .. ', ' .. parent.name
	else
		return UNKNOWN
	end
end

function Rival:GetLocation()
	local map = self:GetMap()
	if map then
		local position = Addon.Rivals[map][self.id]
		local x, y = position:match('(%w%w)(%w%w)')
		return tonumber(x, 36) / 1000, tonumber(y, 36) / 1000
	end
end

function Rival:GetMap()
	return self.map > 0 and self.map
end

function Rival:GetCompleteState()
	return self.quest ~= 0 and (self:IsCompleted() and COMPLETE or AVAILABLE) or ''
end

function Rival:IsCompleted()
	return IsQuestFlaggedCompleted(self.quest)
end

function Rival:GetType()
	if #self > 1 then
		local list = {}
		for i, pet in ipairs(self) do
			local family = pet:GetType()
			if list[family] then
				return family
			elseif family then
				list[family] = true
			end
		end
	else
		return self[1]:GetType()
	end
end

function Rival:GetRewards()
	local rewards = {}

	for id, count in self.items:gmatch('(%w%w%w%w)(%w)') do
		id = tonumber(id, 36)

		tinsert(rewards, {
			icon = GetItemIcon(id),
			link = select(2, GetItemInfo(id)),
			count = tonumber(count, 36)
		})
	end

	for id, count in self.currencies:gmatch('(%w%w)(%w)') do
		id = tonumber(id, 36)
		count = tonumber(count, 36)

		tinsert(rewards, {
			link = GetCurrencyLink(id, count),
			icon = select(3, GetCurrencyInfo(id)),
			count = count
		})
	end

	return rewards
end

function Rival:GetAbstract()
	local text = self.name .. ' ' .. self:GetMapName() .. ' ' .. self:GetCompleteState()

	for i, pet in ipairs(self) do
		text = text .. ' ' .. pet:GetName() .. ' ' .. pet:GetTypeName()
	end

	for id in self.items:gmatch('(%w%w%w%w)%w') do
		local name = GetItemInfo(tonumber(id, 36))
		if name then
			text = text .. ' ' .. name
		end
	end

	for id in self.currencies:gmatch('(%w%w)%w') do
		local name = GetCurrencyInfo(tonumber(id, 36))
		if name then
			text = text .. ' ' .. name
		end
	end

	return text
end

for _, key in pairs {'Level', 'Quality'} do
	Rival['Get' .. key] = function(self)
		local value = 0
		for i, pet in ipairs(self) do
			value = value + pet['Get' .. key](pet)
		end

		return floor(value / #self + .5)
	end
end


--[[ Pets ]]--

function Pet:GetStats()
	return Addon.Predict:Stats(self.Specie, self.Level, self.Quality, self:GetBreed())
end

function Pet:GetBreed()
	local breeds = Addon.Breeds[self.Specie]
	return breeds and breeds[1] or 3
end

function Pet:GetAbility(i)
	local ids = self:GetAbilities()
	for _, id in pairs(ids) do
		i = i - 1
		if i == 0 then
			return id, nil, nil, true
		end
	end
end

for _, key in pairs {'Name', 'Specie', 'Model', 'Level', 'Quality'} do
	Pet['Get' .. key] = function(self)
		return self[key]
	end
end
