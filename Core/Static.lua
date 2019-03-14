--[[
Copyright 2012-2019 João Cardoso
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
local Missing = RED_FONT_COLOR
local L = Addon.Locals


--[[ Constants ]]--

Addon.MaxLevel = 25
Addon.MaxQuality = LE_ITEM_QUALITY_RARE + 1
Addon.QualityScale = {1,1.1,1.2,1.3,1.4,1.5}

Addon.SourceIcons = {
	'Interface\\WorldMap\\TreasureChest_64',
	'Interface\\GossipFrame\\AvailableQuestIcon',
	'Interface\\Minimap\\Tracking\\Banker',
	'Interface\\Archeology\\Arch-Icon-Marker',
	'Interface\\Icons\\Tracking_WildPet',
	'Interface\\AchievementFrame\\UI-Achievement-TinyShield',
	'Interface\\GossipFrame\\DailyQuestIcon'
}

Addon.BreedStats = {
	[3] = {.5,.5,.5},
	[4] = {0,2,0},
	[5] = {0,0,2},
	[6] = {2,0,0},
	[7] = {.9,.9,0},
	[8] = {0,.9,.9},
	[9] = {.9,0,.9},
	[10] = {.4,.9,.4},
	[11] = {.4,.4,.9},
	[12] = {.9,.4,.4}
}

Addon.BreedNames = {
	[3] = BALANCE,
	[4] = select(2, GetSpecializationInfoByID(267)),
	[5] = L.Ninja,
	[6] = select(2, GetSpecializationInfoByID(104)),
	[7] = PET_BATTLE_STAT_POWER .. ' & ' .. PET_BATTLE_STAT_HEALTH,
	[8] = PET_BATTLE_STAT_POWER .. ' & ' .. PET_BATTLE_STAT_SPEED,
	[9] = PET_BATTLE_STAT_HEALTH .. ' & ' .. PET_BATTLE_STAT_SPEED,
	[10] = PET_BATTLE_STAT_POWER,
	[11] = PET_BATTLE_STAT_SPEED,
	[12] = PET_BATTLE_STAT_HEALTH
}

Addon.BreedIcons = {
	[3] = {'|TInterface\\PetBattles\\PetBattle-StatIcons:%d:%d:%d:%d:32:32:16:32:0:16|t', 22, 22},
	[4] = {'|TInterface\\WorldStateFrame\\CombatSwords:%d:%d:%d:%d:64:64:0:32:0:32|t', 19, 19},
	[5] = {'|TInterface\\Addons\\PetTracker\\Art\\Breeds:%d:%d:%d:%d:64:64:40:64:22:39|t', 17 * .9, 24 * .9},
	[6] = {'|TInterface\\Addons\\PetTracker\\Art\\Breeds:%d:%d:%d:%d:64:64:34:64:0:21|t', 21 * .8, 30 * .8},
	[7] = {'|TInterface\\Addons\\PetTracker\\Art\\Breeds:%d:%d:%d:%d:64:64:2:26:0:17|t', 17, 24},
	[8] = {'|TInterface\\Addons\\PetTracker\\Art\\Breeds:%d:%d:%d:%d:64:64:2:26:17:34|t', 17, 24},
	[9] = {'|TInterface\\Addons\\PetTracker\\Art\\Breeds:%d:%d:%d:%d:64:64:0:26:34:51|t', 17, 26},
	[10] = {'|TInterface\\PetBattles\\PetBattle-StatIcons:%d:%d:%d:%d:32:32:0:16:0:16|t', 17, 17},
	[12] = {'|TInterface\\PetBattles\\PetBattle-StatIcons:%d:%d:%d:%d:32:32:16:32:16:32|t', 17, 17},
	[11] = {'|TInterface\\PetBattles\\PetBattle-StatIcons:%d:%d:%d:%d:32:32:0:16:16:32|t', 17, 17}
}


--[[ Static ]]--

function Addon.GetQualityColor(quality)
	if quality > 0 then
		return GetItemQualityColor(quality - 1)
	end

	return Missing.r, Missing.g, Missing.b, RED_FONT_COLOR_CODE:sub(3)
end

function Addon.GetMapTypeName(type)
	for name, id in pairs(Enum.UIMapType) do
		if type == id then
			return name
		end
	end
end

function Addon.GetTypeName(type)
	return _G['BATTLE_PET_NAME_' .. type]
end

function Addon.GetTypeIcon(type)
	return type and 'Interface\\PetBattles\\PetIcon-' .. PET_TYPE_SUFFIX[type]
end

function Addon:GetBreedName(breed)
	return breed and self.BreedNames[breed] or ''
end

function Addon:GetBreedIcon(breed, scale, x, y)
	local icon = breed and self.BreedIcons[breed]
	return icon and icon[1]:format(scale * icon[2], scale * icon[3], x or 0, y or 0) or ''
end


--[[ Utilities ]]--

function Addon.KeepShort(text)
	if not text:find('|n') and strlen(text) > 100 then
		return text:sub(0, 97) .. '...'
	end

	return text
end

function Addon.UnpackDate(date)
	local yearDate = date % (31*12)
	return yearDate % 31 + 1,
		   floor(yearDate / 31) + 1,
		   floor(date / 31 / 12) + 2014
end

function Addon.GetDate()
	local date = C_Calendar.GetDate()
	return (date.year-2014) * 31*12 + (date.month-1) * 31 + date.monthDay-1
end
