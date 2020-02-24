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
local Entity = Addon.Base:NewClass('Entity')

Entity.SourceIcons = {
	'Interface/WorldMap/TreasureChest_64',
	'Interface/GossipFrame/AvailableQuestIcon',
	'Interface/Minimap/Tracking/Banker',
	'Interface/Archeology/Arch-Icon-Marker',
	'Interface/Icons/Tracking_WildPet',
	'Interface/AchievementFrame/UI-Achievement-TinyShield',
	'Interface/GossipFrame/DailyQuestIcon'
}

function Entity:Display()
	CollectionsJournal_LoadUI()
	HideUIPanel(WorldMapFrame)
	ShowUIPanel(CollectionsJournal)
end

function Entity:GetTypeName()
	return _G['BATTLE_PET_NAME_' .. self:GetType()]
end

function Entity:GetTypeIcon()
	return self:GetType() and 'Interface/PetBattles/PetIcon-' .. PET_TYPE_SUFFIX[self:GetType()]
end

function Entity:GetSourceIcon()
	return self.SourceIcons[self:GetSource()]
end

function Entity:GetBreedName()
	return Addon.Breeds:Name(self:GetBreed())
end

function Entity:GetBreedIcon(...)
	return Addon.Breeds:Icon(self:GetBreed(), ...)
end

function Entity:GetColor()
	return Addon:GetColor(self:GetQuality())
end
