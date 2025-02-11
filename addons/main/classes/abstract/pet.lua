--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local Pet = Addon.Entity:NewClass('Pet')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)


--[[ Construct ]]--

function Pet:New(id)
  return self:Bind{id = id}
end

function Pet:Display()
  self:Super(Pet):Display()
	CollectionsJournal_SetTab(CollectionsJournal, 2)

  if self:GetID() then
    PetJournal_SelectPet(PetJournal, self:GetID())
  elseif self:GetSpecie() then
    PetJournal_SelectSpecies(PetJournal, self:GetSpecie())
  end
end


--[[ Progress ]]--

function Pet:GetBestOwned()
	local quality, level, best = 0,0

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

function Pet:GetOwnedText()
	local owned = self:GetOwned()
	if #owned > 0 then
		local text = COLLECTED .. ':'
		for i, pet in ipairs(owned) do
			text = text .. format('  %s%s%d|r', pet:GetBreedIcon(.8, -2,0), pet:GetColor():GenerateHexColorMarkup(), pet:GetLevel())
		end

		return text
	end
end

function Pet:GetOwned()
	local owned = {}
	for _, pet in LibStub('LibPetJournal-2.0'):IteratePetIDs() do
		if C_PetJournal.GetPetInfoByPetID(pet) == self:GetSpecie() then
			tinsert(owned, Pet(pet))
		end
	end

	return owned
end


--[[ Display Text ]]--

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

function Pet:GetIcon()
	return select(2, self:GetInfo())
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
