--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = (...):match('%w+'), _G[(...):match('%w+')]
local Record = Addon.Base:NewClass('BattleRecord', 'Button', true)
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

function Record:Display(entry)
	self:Unpack(entry)
	self.Content.When:SetFormattedText('%d/%d/%02d', self.day, self.month, self.year)
	self:SetNormalFontObject(self.won and GameFontGreen or GameFontRed)
	self:SetText(self.won and L.Victory or L.Defeat)
	self:Show()

	for i = 1, 3 do
		local pet = self.pets[i]
		local button = self.Content['Pet' .. i]
		button:SetShown(pet)

		if pet then
			local texture = select(9, C_PetJournal.GetPetInfoByPetID(pet.id))
			button:SetNormalTexture(texture or 'Interface/Icons/INV_Misc_QuestionMark')
			button.id = texture and pet.id

			local alive = pet.health > 0
			button.Health:SetWidth(pet.health * 36)
			button.Health:SetShown(alive)
			button.HealthBg:SetShown(alive)
			button.HealthBorder:SetShown(alive)
			button.Dead:SetShown(not alive)
		end
	end
end

function Record:Unpack(entry)
	local winner, date, petData = entry:match('^(%d):(%w+):(.+)$')

	self.won = tonumber(winner) == Enum.BattlePetOwner.Ally
	self.day, self.month, self.year = self:UnpackDate(date)
	self.pets = {}

	for health, spell1, spell2, spell3, id in petData:gmatch('(%w):(%w+):(%w+):(%w+):(%w+)') do
		tinsert(self.pets, {
			id = 'BattlePet-0-' .. id,
			health = tonumber(health, 16) / 15,
			abilities = {tonumber(spell1, 16), tonumber(spell2, 16), tonumber(spell3, 16)}
		})
	end
end

function Record:UnpackDate(date)
	local date = tonumber(date, 16)
	local yearDate = date % (31*12)
	return yearDate % 31 + 1,
		   floor(yearDate / 31) + 1,
		   floor(date / 31 / 12) + 2014
end
