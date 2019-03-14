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

local Addon = PetTracker
local Tooltip = Addon.MapTip()
local Icons = {}

local L, Journal, Battle = Addon.Locals, Addon.Journal, Addon.Battle
local NoneCollected = NORMAL_FONT_COLOR_CODE .. L.NoneCollected .. FONT_COLOR_CODE_CLOSE
local Stats = {PET_BATTLE_STAT_HEALTH, PET_BATTLE_STAT_POWER, PET_BATTLE_STAT_SPEED}


--[[ Combat ]]--

hooksecurefunc('PetBattleUnitTooltip_UpdateForUnit', function(self, ...)
	local pet = Battle:Get(...)
	local icon = Icons[self] or self:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	icon:SetPoint('CENTER', self.Icon, 'TOPLEFT', 3, -2)
	icon:SetText(Addon:GetBreedIcon(pet:GetBreed(), .9))
	Icons[self] = icon

	self.CollectedText:SetText(pet:GetOwnedText() or NoneCollected)
end)

hooksecurefunc("PetBattleUnitFrame_UpdateDisplay", function(self)
	local frame = self:GetName() or ''
	local breed = Battle:Get(self.petOwner, self.petIndex):GetBreed()

	if self.Name and not frame:find('Tooltip') then
		self.Name:SetText((self.Name:GetText() or '') .. ' ' .. Addon:GetBreedIcon(breed, .8))
	end
end)


--[[ Journal ]]--

do
	local function Journal_OnEnter(self)
		Tooltip:Anchor(self, 'ANCHOR_RIGHT', -54, 0)
		Tooltip:AddHeader(PET_BATTLE_STAT_QUALITY)
		Tooltip:AddLine(PET_BATTLE_TOOLTIP_RARITY)
		Tooltip:AddHeader(L.Breed)
		Tooltip:AddLine(L.BreedExplanation)
		Tooltip:AddLine('\n' .. Addon:GetBreedName(self.breed), 1,1,1)

		for stat, bonus in ipairs(Addon.BreedStats[self.breed] or {}) do
			if bonus > 0 then
				Tooltip:AddLine(format('+ %d%% %s', bonus*50, Stats[stat]))
			end
		end

		Tooltip:Display()
	end

	local function Journal_OnLeave()
		Tooltip:Hide()
	end

	local function HookJournal()
		hooksecurefunc('PetJournal_UpdatePetCard', function(self)
			local frame = self.QualityFrame
			if frame:IsShown() then
				local breed, confidence = Journal:GetBreed(self.petID)
				local text = frame.quality

				text:SetText(Addon:GetBreedIcon(breed, .75, -3, -1) .. text:GetText() .. ' ' .. Addon:GetBreedName(breed))
				text:SetPoint('LEFT', 4, 0)

				frame:SetWidth(150)
				frame:GetRegions():Hide()
				frame:SetScript('OnEnter', Journal_OnEnter)
				frame:SetScript('OnLeave', Journal_OnLeave)
				frame.breed = breed

				self.PetInfo.sourceText = self.PetInfo.sourceText .. Journal:GetAvailableBreeds(self.speciesID)
			end
		end)

		hooksecurefunc('PetJournal_UpdatePetLoadOut', function()
			for i = 1, NUM_BATTLE_PETS_IN_BATTLE do
				local slot = PetJournal.Loadout['Pet'..i]
				if slot.petID then
					local breed = Journal:GetBreed(slot.petID)
					local text = slot.name

					text:SetText((text:GetText() or '') .. Addon:GetBreedIcon(breed, .75, 3, -1))
				end
			end
		end)

		HookJournal = function() end
	end

	if PetJournal then
		HookJournal()
	else
		hooksecurefunc('LoadAddOn', function(addon)
			if addon == 'Blizzard_Collections' then
				HookJournal()
			end
		end)
	end
end


--[[ Tooltips ]]--

local owned = {}

hooksecurefunc('BattlePetTooltipTemplate_SetBattlePet', function(tooltip, data)
	local breed = Addon.Predict:Breed(data.speciesID, data.level, data.breedQuality + 1, data.maxHealth, data.power, data.speed)
	local string = tooltip.Owned

	if not string.__SetText then
		string.__SetText = string.SetText

		function string:SetText(text)
			if owned[string] then
				string:__SetText(owned[self])
				owned[self] = nil
			else
				string:__SetText(text)
			end
		end
	end

	tooltip.Name:SetText((tooltip.Name:GetText() or '') .. Addon:GetBreedIcon(breed, .8, 5, -2))
	owned[string] = Journal:GetOwnedText(data.speciesID)
end)