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

local _, Addon = ...
local L, Journal = Addon.Locals, Addon.Journal
local Search = LibStub('CustomSearch-1.0')
local Filters = {}

function Addon:Filter(target, search)
	return Search(target, search, Filters)
end


--[[ Parsers ]]--

Filters.abstract = {
	canSearch = function(self, operator, search)
		return not operator and search
	end,

	match = function(self, target, _, search)
		return Search:Find(search, target:GetAbstract())
	end
}

Filters.level = {
	canSearch = function(self, operator, search)
		return tonumber(search)
	end,

	match = function(self, target, operator, level)
		return Search:Compare(operator, target:GetLevel(), level)
	end
}

Filters.abilities = {
	canSearch = function(self, operator, search, target)
		return not operator and target.GetAbilities and search
	end,

	match = function(self, target, _, search)
		for i, id in ipairs(target:GetAbilities()) do
			local _, name = C_PetBattles.GetAbilityInfoByID(id)
			if Search:Find(search, name) then
				return true
			end
		end
	end
}

do
	local qualities = {[L.Maximized] = 4, [ADDON_MISSING] = 0, [NONE] = 0}
	for i = 1, #ITEM_QUALITY_COLORS-2 do
		qualities[_G['BATTLE_PET_BREED_QUALITY'..i]] = i
	end

	Filters.quality = {
		canSearch = function(self, _, search)
			for name, i in pairs(qualities) do
			  if Search:Find(search, name) then
				return i
			  end
			end
		end,

		match = function(self, target, operator, quality)
			return Search:Compare(operator, target:GetQuality(), quality)
		end,
	}
end
