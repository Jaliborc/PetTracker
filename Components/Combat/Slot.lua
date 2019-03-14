--[[
Copyright 2012-2019 João Cardoso
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

local ADDON, Addon = 'PetTracker', PetTracker
local Slot = LibStub('Poncho-1.0')('Button')

local Ability, Journal = Addon.AbilityButton, Addon.Journal
local PetTooltip = PetBattlePrimaryUnitTooltip
local NumPets = NUM_BATTLE_PETS_IN_BATTLE

BattleSlot = Addon:NewClass(nil, 'BattleSlot', ADDON .. 'BattleSlot', Slot)
JournalSlot = Addon:NewClass(nil, 'JournalSlot', ADDON .. 'JournalSlot', Slot)


--[[ Create ]]--

function Slot:CreateLine(point, parent, x, y)
	local slots = {}
	for i = 1, NumPets do
		slots[i] = self(parent)
		slots[i]:SetPoint(point, parent, x, y - i*107)
	end

	return slots
end

function Slot:OnCreate()
	self.Type:SetScript('OnEnter', Ability.OnEnter)
	self.Type:SetScript('OnLeave', Ability.OnLeave)
	self.Ability = {}

	for i = 1, 6 do
		self.Ability[i] = Ability(self)
		self.Ability[i]:SetPoint('CENTER', -196 + i * 42, 20)
	end

	for i = 1, 3 do
		self.Ability[i]:SetPoint('CENTER', -70 + i * 42, -15)
	end
end


--[[ Update ]]--

function Slot:Display(pet, target)
	if pet then
		local specie, icon, type = pet:GetInfo()
		local r,g,b = Addon.GetQualityColor(pet:GetQuality())
		local health, power, speed = pet:GetStats()
		local name = pet:GetName()

		self.Name:SetText(name)
		self.SubName:SetText(specie ~= name and specie)

		self.Name:SetTextColor(r, g, b)
		self.Quality:SetVertexColor(r, g, b)

		self.Icon:SetTexture(icon)
		self.Power:SetText(power)
		self.Speed:SetText(speed)

		self.Type.Icon:SetTexture(Addon.GetTypeIcon(type))
		self.Type.id = PET_BATTLE_PET_TYPE_PASSIVES[type]
		self.Type.pet = pet

		self.Model:SetDisplayInfo(pet:GetModel())
		self.Level:SetText(pet:GetLevel())

		if self.Xp then
			local current = pet:GetHealth()

			self.IsDead:SetShown(current == 0)
			self:UpdateBar('Health', current, health)
			self:UpdateBar('Xp', pet:GetXP())
		else
			self.Health:SetText(health)
		end

		for i = 1, 6 do
			self.Ability[i]:Display(pet, i, target)
		end
	end

	self.IsEmpty:SetShown(not pet)
	self.pet = pet
end

function Slot:UpdateBar(bar, value, max)
	local bar = self[bar]
	bar.Text:SetText(format('%d/%d', value, max))
	bar:SetMinMaxValues(0, max)
	bar:SetValue(value)
end
