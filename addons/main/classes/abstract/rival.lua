--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local Rival = Addon.Entity:NewClass('Rival')
local C = LibStub('C_Everywhere')


--[[ Construct ]]--

function Rival:New(id)
	local data = Addon.RivalInfo[id]
	if data then
		local name, model, map, quest, gold, items, currencies, pets = data:match('^([^:]+):(%w%w%w%w)(%w%w)(%w%w%w)(%w)([^:]*):([^:]*):(.*)$')
		local tooltip = C.TooltipInfo.GetHyperlink(('unit:Creature-0-0-0-0-%d'):format(id))
		local rival = self:Bind {
			id = id, items = items, currencies = currencies,
			name = tooltip and tooltip.lines[1] and tooltip.lines[1].leftText or name,
			gold = tonumber(gold, 36),
			quest = tonumber(quest, 36),
			model = tonumber(model, 36),
			map = tonumber(map, 36)
		}

		for name, model, specie, level, quality in pets:gmatch('([^:]+):(%w%w%w%w)(%w%w%w)(%w)(%w)') do
			tinsert(rival, Addon.Enemy {
				name = name,
				specie = tonumber(specie, 36),
				model = tonumber(model, 36),
				level = tonumber(level, 36),
				quality = tonumber(quality, 36)
			})
		end

		return rival
	end
end

function Rival:Display()
	self:Super(Rival):Display()

	if Addon.RivalsJournal then
		Addon.RivalsJournal:SetRival(self)
	end
end


--[[ Location ]]--

function Rival:GetMapName()
	local map = self:GetMap()
	if map then
		local info = C.Map.GetMapInfo(map)
		local parent = C.Map.GetMapInfo(info.parentMapID)
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


--[[ Quest ]]--

function Rival:GetCompleteState()
	return self.quest ~= 0 and (self:IsCompleted() and COMPLETE or AVAILABLE) or ''
end

function Rival:IsCompleted()
	return C.QuestLog.IsQuestFlaggedCompleted(self.quest)
end

function Rival:GetRewards()
	local rewards = {}

	for id, count in self.items:gmatch('(%w%w%w%w)(%w)') do
		id = tonumber(id, 36)

		tinsert(rewards, {
			icon = C.Item.GetItemIconByID(id),
			link = select(2, C.Item.GetItemInfo(id)),
			count = tonumber(count, 36)
		})
	end

	for id, count in self.currencies:gmatch('(%w%w)(%w)') do
		id = tonumber(id, 36)
		count = tonumber(count, 36)

		tinsert(rewards, {
			link = C.CurrencyInfo.GetCurrencyLink(id, count),
			icon = C.CurrencyInfo.GetCurrencyInfo(id).iconFileID,
			count = count
		})
	end

	return rewards
end


--[[ Overrides ]]--

function Rival:GetAbstract()
	local parts = {self.name, self:GetMapName(), self:GetCompleteState()}

	for i, pet in ipairs(self) do
		tinsert(parts, pet:GetName())
		tinsert(parts, pet:GetTypeName())
	end

	for id in self.items:gmatch('(%w%w%w%w)%w') do
		local name = C.Item.GetItemInfo(tonumber(id, 36))
		if name then
			tinsert(parts, name)
		end
	end

	for id in self.currencies:gmatch('(%w%w)%w') do
		local currency = C.CurrencyInfo.GetCurrencyInfo(tonumber(id, 36))
		if currency.name then
			tinsert(parts, currency.name)
		end
	end

	return table.concat(parts, ' ')
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

for _, key in pairs {'Level', 'Quality'} do
	Rival['Get' .. key] = function(self)
		local value = 0
		for i, pet in ipairs(self) do
			value = value + pet['Get' .. key](pet)
		end

		return floor(value / #self + .5)
	end
end
