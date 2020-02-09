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
local Specie = Addon.Pet:NewClass('Specie')


--[[ Overrides ]]--

function Specie:New(specie)
	return self:Bind{specie = specie}
end

function Specie:Display()
	CollectionsJournal_LoadUI()
	HideUIPanel(WorldMapFrame)
	ShowUIPanel(CollectionsJournal)
	CollectionsJournal_SetTab(CollectionsJournal, 2)

	local best = self:GetBestOwned()
	if best then
		PetJournal_SelectPet(PetJournal, best:GetID())
	else
		PetJournal_SelectSpecies(PetJournal, self:GetSpecie())
	end
end

function Specie:GetQuality()
	return select(2, self:GetBestOwned())
end

function Specie:GetLevel()
	return select(3, self:GetBestOwned())
end

function Specie:GetSpecie()
	return self.specie
end


--[[ Progress ]]--

function Specie:GetBestOwned()
	local quality, level, best = 0, 0

	for i, pet in pairs(self:GetOwned()) do
		local q = pet:GetQuality()
		local l = pet:GetLevel()

		if q > quality or (q == quality and l > level) then
			quality, level = q, l
			best = pet
		end
	end

	return best, quality, level
end

function Specie:GetOwnedText()
	local owned = self:GetOwned()
	if #owned > 0 then
		local text = NORMAL_FONT_COLOR_CODE .. COLLECTED .. ':' .. FONT_COLOR_CODE_CLOSE

		for i, pet in ipairs(owned) do
			local icon = Addon.Breeds:GetIcon(pet:GetBreed(), .8, -2)
			local _,_,_, color = pet:GetColor()

			text = text .. format('  %s|c%s%d|r', icon, color, pet:GetLevel())
		end

		return text
	end
end

function Specie:GetOwned()
	local owned = {}
	for _, pet in LibStub('LibPetJournal-2.0'):IteratePetIDs() do
		if C_PetJournal.GetPetInfoByPetID(pet) == self:GetSpecie() then
			tinsert(owned, Addon.Pet(pet))
		end
	end

	return owned
end
