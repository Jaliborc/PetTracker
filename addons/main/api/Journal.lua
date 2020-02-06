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
local Journal = Addon:NewModule('Journal')
local Cache = LibStub('LibPetJournal-2.0')
local Server = C_PetJournal
local L = Addon.Locals


--[[ Actions ]]--

function Journal:Display(specie)
	CollectionsJournal_LoadUI()
	ShowUIPanel(CollectionsJournal)
	CollectionsJournal_SetTab(CollectionsJournal, 2)
	PetJournal_SelectSpecies(PetJournal, specie)
end


--[[ Progress ]]--

function Journal:GetCurrentProgress()
	return self:GetProgressIn(C_Map.GetBestMapForUnit('player'))
end

function Journal:GetProgressIn(map)
	local progress = {total = 0}
	for i = 0, Addon.MaxQuality do
		progress[i] = {total = 0}
	end

	local species = self.GetSpeciesIn(map)
	for specie in pairs(species) do
		local pet, quality, level = self:GetBestOwned(specie)
		local quality = progress[quality]

		progress.total = progress.total + 1
		quality.total = quality.total + 1

		quality[level] = quality[level] or {}
		tinsert(quality[level], specie)
	end

	return progress
end

function Journal:GetBestOwned(specie)
	local quality, level, best = 0, 0

	for i, pet in pairs(self:GetOwned(specie)) do
		local q = self:GetQuality(pet)
		local l = self:GetLevel(pet)

		if q > quality or (q == quality and l > level) then
			quality, level = q, l
			best = pet
		end
	end

	return best, quality, level
end

function Journal:GetOwnedText(specie)
	local owned = self:GetOwned(specie)
	if #owned > 0 then
		local collected = NORMAL_FONT_COLOR_CODE .. COLLECTED .. ':' .. FONT_COLOR_CODE_CLOSE

		for i, pet in ipairs(owned) do
			local quality, level = Journal:GetQuality(pet), Journal:GetLevel(pet)
			local breed, confidence = Journal:GetBreed(pet)

			local color = select(4, Addon.GetQualityColor(quality))
			local icon = Addon:GetBreedIcon(breed, .8, -2)

			collected = collected .. format('  %s|c%s%d|r', icon, color, level)
		end

		return collected
	end
end

function Journal:GetOwned(specie)
	local list = {}
	for _, pet in Cache:IteratePetIDs() do
		if self:GetSpecie(pet) == specie then
			tinsert(list, pet)
		end
	end

	return list
end


--[[ Info ]]--

function Journal:GetType(specie)
	return select(3, self:GetInfo(specie))
end

function Journal:GetSource(specie)
	local source = select(5, self:GetInfo(specie))

	for i = 1, Server.GetNumPetSources() do
		if source:find('^|c%w+' .. L['Source' .. i]) then
			return i, name
		end
	end
end

function Journal:GetAbility(specie, i)
	return self:GetAbilities(specie)[i]
end

function Journal:GetAbilities(specie)
	return Server.GetPetAbilityList(specie)
end

function Journal:GetInfo(specie)
	return Server.GetPetInfoBySpeciesID(specie)
end


--[[ Display ]]--

function Journal:GetAvailableBreeds(specie)
	local breeds =  NORMAL_FONT_COLOR_CODE .. L.AvailableBreeds .. FONT_COLOR_CODE_CLOSE
	for _, breed in pairs(Addon.Breeds[specie] or {}) do
		breeds  = breeds .. ' ' .. Addon:GetBreedIcon(breed, .75)
	end

	return breeds
end

function Journal:GetTypeName(specie)
	return Addon.GetTypeName(self:GetType(specie))
end

function Journal:GetTypeIcon(specie)
	return Addon.GetTypeIcon(self:GetType(specie))
end

function Journal:GetSourceIcon(specie)
	return Addon.SourceIcons[self:GetSource(specie)]
end


--[[ Stats ]]--

function Journal:GetBreed(pet)
	local specie, _, level = Server.GetPetInfoByPetID(pet)
	local _, health, power, speed, quality = Server.GetPetStats(pet)
	return Addon.Predict:Breed(specie, level, quality, health, power, speed)
end

function Journal:GetQuality(pet)
	return select(5, Server.GetPetStats(pet))
end

function Journal:GetLevel(pet)
	return select(3, Server.GetPetInfoByPetID(pet))
end

function Journal:GetSpecie(pet)
	return Server.GetPetInfoByPetID(pet)
end


--[[ Locations ]]--

function Journal.GetSpeciesIn(map)
	return Addon.Species[map] or {}
end

function Journal.GetRivalsIn(map)
	return Addon.Rivals[map] or {}
end

function Journal.GetStablesIn(map)
	map = Addon.Stables[map]
	return map or ''
end
