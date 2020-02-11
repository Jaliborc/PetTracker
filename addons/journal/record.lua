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

local MODULE =  ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local Record = Addon.Base:NewClass('BattleRecord', 'Button', true)
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

local ID_MATCH = strrep('%w', 12)
local SPELLS_MATCH = strrep('(%w%w%w)', 3)
local PET_MATCH = '(%w)' .. SPELLS_MATCH .. '(' .. ID_MATCH .. ')'

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
	local winner, date, petData = entry:match('^(%d)(%w%w%w)(.+)$')

	self.won = tonumber(winner) == LE_BATTLE_PET_ALLY
	self.day, self.month, self.year = self:UnpackDate(date)
	self.pets = {}

	for health, spell1, spell2, spell3, id in petData:gmatch(PET_MATCH) do
		tinsert(self.pets, {
			id = 'BattlePet-0-' .. id,
			health = tonumber(health, 16) / 15,
			abilities = {tonumber(spell1, 16), tonumber(spell2, 16), tonumber(spell3, 16)}
		})
	end
end

function Record:UnpackDate(date)
	local yearDate = tonumber(date, 16) % (31*12)
	return yearDate % 31 + 1,
		   floor(yearDate / 31) + 1,
		   floor(date / 31 / 12) + 2014
end
