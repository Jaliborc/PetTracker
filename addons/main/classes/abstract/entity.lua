--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
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
