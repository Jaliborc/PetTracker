--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local Maps = Addon:NewModule('Maps')


--[[ Progress ]]--

function Maps:GetCurrentProgress()
	return self:GetProgressIn(C_Map.GetBestMapForUnit('player'))
end

function Maps:GetProgressIn(map)
	local progress = {total = 0}
	for i = 0, Addon.MaxQuality do
		progress[i] = {total = 0}
	end

	for id in pairs(self:GetSpeciesIn(map)) do
    local specie = Addon.Specie(id)
		local pet, quality, level = specie:GetBestOwned()
		local quality = progress[quality]

		progress.total = progress.total + 1
		quality.total = quality.total + 1

		quality[level] = quality[level] or {}
		tinsert(quality[level], specie)
	end

	return progress
end


--[[ Data ]]--

function Maps:GetSpeciesIn(map)
	return Addon.Species[map] or {}
end

function Maps:GetRivalsIn(map)
	return Addon.Rivals[map] or {}
end

function Maps:GetStablesIn(map)
	return Addon.Stables[map] or ''
end


--[[ Other ]]--

function Maps:TypeName(type)
	for name, id in pairs(Enum.UIMapType) do
		if type == id then
			return name
		end
	end
end
