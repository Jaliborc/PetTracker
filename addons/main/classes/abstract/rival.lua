--[[
Copyright 2012-2020 João Cardoso
PetTracker is distributed under the terms of the GNU General Public License (Version 3).
As a special exception, the copyright holders of this addon do not give permission to
redistribute and/or modify it.

This addon is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the addon. If not, see <http://www.gnu.org/licenses/gpl-3.0.txt>.

This file is part of PetTracker.
--]]

local ADDON, Addon = ...
local Rival = Addon.Entity:NewClass('Rival')


--[[ Construct ]]--

function Rival:New(id)
	local data = Addon.RivalInfo[id]
	if data then
		local name, model, map, quest, gold, items, currencies, pets = data:match('^([^:]+):(%w%w%w%w)(%w%w)(%w%w%w)(%w)([^:]*):([^:]*):(.*)$')
		local rival = self:Bind {
			name = name, items = items, currencies = currencies,
			gold = tonumber(gold, 36),
			quest = tonumber(quest, 36),
			model = tonumber(model, 36),
			map = tonumber(map, 36),
			id = id
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


--[[ Quest ]]--

function Rival:GetCompleteState()
	return self.quest ~= 0 and (self:IsCompleted() and COMPLETE or AVAILABLE) or ''
end

function Rival:IsCompleted()
	return IsQuestFlaggedCompleted(self.quest)
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


--[[ Overrides ]]--

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
