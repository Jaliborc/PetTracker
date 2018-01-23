local _, Addon = ...
local Pet = setmetatable(Addon:NewModule('TamerPet'), Addon.Specie)
local Tamer = Addon:NewModule('Tamer')

Tamer.__index = Tamer
Pet.__index = Pet


--[[ Constructors ]]--

function Tamer:At(landmark)
	return self:Get(Addon.TamerLandmarks[landmark])
end

function Tamer:Get(id)
	local data = Addon.Tamers[id]
	if data then
		local name, model, zone, quest, gold, items, currencies, pets = data:match('^([^:]+):(%w%w%w%w)(%w%w)(%w%w%w)(%w)([^:]*):([^:]*):(.*)$')
		local tamer = setmetatable({
			name = name, items = items, currencies = currencies,
			gold = tonumber(gold, 36),
			quest = tonumber(quest, 36),
			model = tonumber(model, 36),
			zone = tonumber(zone, 36),
			id = id
		}, self)

		for name, model, specie, level, quality in pets:gmatch('([^:]+):(%w%w%w%w)(%w%w%w)(%w)(%w)') do
			tinsert(tamer, setmetatable({
				Name = name,
				Model = tonumber(model, 36),
				Specie = tonumber(specie, 36),
				Level = tonumber(level, 36),
				Quality = tonumber(quality, 36)
			}, Pet))
		end

		return tamer
	end
end


--[[ API ]]--

function Tamer:Display()
	if GetAddOnEnableState(UnitName('player'), 'PetTracker_Journal') >= 2 then
		CollectionsJournal_LoadUI()
		ShowUIPanel(CollectionsJournal) -- this here causes taint for sure
		PetTrackerTamerJournal.PanelTab:GetScript('OnClick')(PetTrackerTamerJournal.PanelTab)
		PetTrackerTamerJournal:SetTamer(self)
	end
end

function Tamer:GetZoneTitle()
	local name = GetMapNameByID(self:GetZone()) or UNKNOWN
	local continent = Addon.ContinentByZone[name]
	if continent == 'Draenor' and self:GetLevel() < 25 then
		continent = 'Outland'
	end

	return name .. (continent and (', ' .. continent) or '')
end

function Tamer:GetZone()
	return self.zone == 971 and UnitFactionGroup('player') == 'Horde' and 976 or self.zone
end

function Tamer:GetCompleteState()
	return self.quest ~= 0 and (self:IsCompleted() and COMPLETE or AVAILABLE) or ''
end

function Tamer:IsCompleted()
	return IsQuestFlaggedCompleted(self.quest)
end

function Tamer:GetType()
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

function Tamer:GetRewards()
	local rewards = {}

	for item, count in self.items:gmatch('(%w%w%w%w)(%w)') do
		local id = tonumber(item, 36)

		tinsert(rewards, {
			icon = GetItemIcon(id),
			link = select(2, GetItemInfo(id)),
			count = tonumber(count, 36)
		})
	end

	for currency, count in self.currencies:gmatch('(%w%w)(%w)') do
		local id = tonumber(currency, 36)

		tinsert(rewards, {
			link = GetCurrencyLink(id),
			icon = select(3, GetCurrencyInfo(id)),
			count = tonumber(count, 36)
		})
	end

	return rewards
end

function Tamer:GetAbstract()
	local text = self.name .. ' ' .. self:GetZoneTitle() .. ' ' .. self:GetCompleteState()

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
	Tamer['Get' .. key] = function(self)
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