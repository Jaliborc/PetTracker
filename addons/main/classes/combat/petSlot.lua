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
local Slot = Addon.Base:NewClass('PetSlot')
Slot:NewClass('BattleSlot', 'Button', true)
Slot:NewClass('JournalSlot', 'Frame', true)


--[[ Construct ]]--

function Slot:NewSet(point, parent, x, y)
	local slots = {}
	for i = 1, NUM_BATTLE_PETS_IN_BATTLE do
		slots[i] = self(parent)
		slots[i]:SetPoint(point, parent, x, y - i*107)
	end

	return slots
end

function Slot:Construct()
	local f = self:Super(Slot):Construct()
	f.Type:SetScript('OnEnter', Addon.AbilityDisplay.OnEnter)
	f.Type:SetScript('OnLeave', Addon.AbilityDisplay.OnLeave)
	f.Abilities = {}

	for i = 1, 6 do
		f.Abilities[i] = Addon.AbilityDisplay(f)
	end
	return f
end


--[[ Update ]]--

function Slot:Display(pet, target)
	if pet then
		local specie, icon, type = pet:GetInfo()
		local health, power, speed = pet:GetStats()
		local r,g,b = pet:GetColor()
		local name = pet:GetName()

		self.Name:SetText(name)
		self.SubName:SetText(specie ~= name and specie)

		self.Name:SetTextColor(r, g, b)
		self.Quality:SetVertexColor(r, g, b)

		self.Icon:SetTexture(icon)
		self.Power:SetText(power)
		self.Speed:SetText(speed)

		self.Type.Icon:SetTexture(pet:GetTypeIcon())
		self.Type.ability = Addon.Ability(PET_BATTLE_PET_TYPE_PASSIVES[type], pet)

		self.Model:SetDisplayInfo(pet:GetModel())
		self.Level:SetText(pet:GetLevel())

		if self.Xp then
			self.IsDead:SetShown(pet:GetHealth() == 0)
			self:UpdateBar(self.Health, pet:GetHealth(), health)
			self:UpdateBar(self.Xp, pet:GetXP())
		else
			self.Health:SetText(health)
		end

		local doubled
		for i, button in pairs(self.Abilities) do
			button:Display(pet:GetAbility(i), target)
			doubled = doubled or (i > 3 and button:IsShown())
		end

		for i, button in pairs(self.Abilities) do
			local x = -75 + (((i-1) % 3) + 1) * 42
			local y = (i > 3 and 20 or -15) - (not self.Xp and doubled and 15 or 0)

			button:SetPoint('CENTER', x, y)
		end
	end

	self.IsEmpty:SetShown(not pet)
	self.pet = pet
end

function Slot:UpdateBar(bar, value, max)
	bar.Text:SetText(format('%d/%d', value, max))
	bar:SetMinMaxValues(0, max)
	bar:SetValue(value)
end
