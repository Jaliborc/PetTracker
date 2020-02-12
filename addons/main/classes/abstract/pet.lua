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
local Pet = Addon.Entity:NewClass('Pet')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)


--[[ Derivative Info ]]--

function Pet:New(id)
  return self:Bind{id = id}
end

function Pet:GetAbstract()
	local name, _,_,_, source, description = self:GetInfo()
	local family = self:GetTypeName()

	return strjoin(' ', name, family, source, description)
end

function Pet:GetAvailableBreeds()
  local breeds = Addon.SpecieBreeds[self:GetSpecie()] or {}
  if #breeds > 0 then
  	local text =  ''
  	for i, breed in ipairs(breeds) do
  		text = text .. Addon.Breeds:Icon(breed, .75) .. ' '
  	end

  	return text
  end
end

function Pet:GetSource()
	local _,_,_,_, source = self:GetInfo()

	for i = 1, C_PetJournal.GetNumPetSources() do
		if source:find('^|c%w+' .. L['Source' .. i]) then
			return i, name
		end
	end
end


--[[ Basic Info ]]--

function Pet:GetAbility(i)
	return Addon.Ability(self:GetAbilities()[i], self)
end

function Pet:GetAbilities()
	return C_PetJournal.GetPetAbilityList(self:GetSpecie())
end

function Pet:GetBreed()
	return Addon.Predict:Breed(self:GetSpecie(), self:GetLevel(), self:GetQuality(), self:GetStats())
end

function Pet:GetType()
	return select(3, self:GetInfo())
end

function Pet:GetInfo()
	return C_PetJournal.GetPetInfoBySpeciesID(self:GetSpecie())
end

function Pet:GetStats()
  return select(2, C_PetJournal.GetPetStats(self:GetID()))
end

function Pet:GetQuality()
	return select(5, C_PetJournal.GetPetStats(self:GetID()))
end

function Pet:GetLevel()
	return select(3, C_PetJournal.GetPetInfoByPetID(self:GetID()))
end

function Pet:GetSpecie()
	return C_PetJournal.GetPetInfoByPetID(self:GetID())
end

function Pet:GetID()
	return self.id
end
