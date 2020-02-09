--[[
	pet.lua
		Abstract class that represents an owned pet
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

function Pet:GetBreed()
	local specie, _, level = C_PetJournal.GetPetInfoByPetID(self:GetID())
	local _, health, power, speed, quality = C_PetJournal.GetPetStats(self:GetID())
	return Addon.Predict:Breed(specie, level, quality, health, power, speed)
end


--[[ Basic Info ]]--

function Pet:GetAbility(i)
	return self:GetAbilities()[i]
end

function Pet:GetAbilities()
	return C_PetJournal.GetPetAbilityList(self:GetSpecie())
end

function Pet:GetType()
	return select(3, self:GetInfo())
end

function Pet:GetQuality()
	return select(5, C_PetJournal.GetPetStats(self:GetID()))
end

function Pet:GetLevel()
	return select(3, C_PetJournal.GetPetInfoByPetID(self:GetID()))
end

function Pet:GetInfo()
	return C_PetJournal.GetPetInfoBySpeciesID(self:GetSpecie())
end

function Pet:GetSpecie()
	return C_PetJournal.GetPetInfoByPetID(self:GetID())
end

function Pet:GetID()
	return self.id
end
