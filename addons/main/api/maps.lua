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
