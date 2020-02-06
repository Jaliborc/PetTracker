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
local Static = Addon:NewModule('Static')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)


--[[ Constants ]]--

Static.MaxLevel = 25
Static.MaxQuality = LE_ITEM_QUALITY_RARE + 1
Static.SourceIcons = {
	'Interface/WorldMap/TreasureChest_64',
	'Interface/GossipFrame/AvailableQuestIcon',
	'Interface/Minimap/Tracking/Banker',
	'Interface/Archeology/Arch-Icon-Marker',
	'Interface/Icons/Tracking_WildPet',
	'Interface/AchievementFrame/UI-Achievement-TinyShield',
	'Interface/GossipFrame/DailyQuestIcon'
}

Static.BreedNames = {
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

Static.BreedIcons = {
	[3] = {'|TInterface/PetBattles/PetBattle-StatIcons:%d:%d:%d:%d:32:32:16:32:0:16|t', 22, 22},
	[4] = {'|TInterface/WorldStateFrame/CombatSwords:%d:%d:%d:%d:64:64:0:32:0:32|t', 19, 19},
	[5] = {'|TInterface/Addons/PetTracker/art/breeds:%d:%d:%d:%d:64:64:40:64:22:39|t', 17 * .9, 24 * .9},
	[6] = {'|TInterface/Addons/PetTracker/art/breeds:%d:%d:%d:%d:64:64:34:64:0:21|t', 21 * .8, 30 * .8},
	[7] = {'|TInterface/Addons/PetTracker/art/breeds:%d:%d:%d:%d:64:64:2:26:0:17|t', 17, 24},
	[8] = {'|TInterface/Addons/PetTracker/art/breeds:%d:%d:%d:%d:64:64:2:26:17:34|t', 17, 24},
	[9] = {'|TInterface/Addons/PetTracker/art/breeds:%d:%d:%d:%d:64:64:0:26:34:51|t', 17, 26},
	[10] = {'|TInterface/PetBattles/PetBattle-StatIcons:%d:%d:%d:%d:32:32:0:16:0:16|t', 17, 17},
	[12] = {'|TInterface/PetBattles/PetBattle-StatIcons:%d:%d:%d:%d:32:32:16:32:16:32|t', 17, 17},
	[11] = {'|TInterface/PetBattles/PetBattle-StatIcons:%d:%d:%d:%d:32:32:0:16:16:32|t', 17, 17}
}


--[[ Values ]]--

function Static:GetQualityColor(quality)
	if quality > 0 then
		return GetItemQualityColor(quality - 1)
	end

	return RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, RED_FONT_COLOR_CODE:sub(3)
end

function Static:GetMapTypeName(type)
	for name, id in pairs(Enum.UIMapType) do
		if type == id then
			return name
		end
	end
end

function Static:GetTypeName(type)
	return _G['BATTLE_PET_NAME_' .. type]
end

function Static:GetTypeIcon(type)
	return type and 'Interface/PetBattles/PetIcon-' .. PET_TYPE_SUFFIX[type]
end

function Static:GetBreedName(breed)
	return breed and self.BreedNames[breed] or ''
end

function Static:GetBreedIcon(breed, scale, x, y)
	local icon = breed and self.BreedIcons[breed]
	return icon and icon[1]:format(scale * icon[2], scale * icon[3], x or 0, y or 0) or ''
end


--[[ Utilities ]]--

function Static:KeepShort(text)
	if not text:find('|n') and strlen(text) > 100 then
		return text:sub(0, 97) .. '...'
	end
	return text
end

function Static:UnpackDate(date)
	local yearDate = date % (31*12)
	return yearDate % 31 + 1,
		   floor(yearDate / 31) + 1,
		   floor(date / 31 / 12) + 2014
end

function Static:GetDate()
	local date = C_Calendar.GetDate()
	return (date.year-2014) * 31*12 + (date.month-1) * 31 + date.monthDay-1
end
