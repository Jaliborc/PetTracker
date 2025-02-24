--[[
  Copyright 2012-2025 João Cardoso
  All Rights Reserved
--]]

local ADDON, Addon = ...
local Tooltips = Addon:NewModule('Tooltips')

function Tooltips:OnLoad()
	hooksecurefunc('BattlePetTooltipTemplate_SetBattlePet', self.OnBattlePet)
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, self.OnUnit)
end

function Tooltips.OnUnit(tip)
	local name = TooltipUtil.GetDisplayedUnit(tip)
	local specie = name and C_PetJournal.FindPetIDByName(name)
	if specie then
		local owned = Addon.Specie(specie):GetOwnedText()
		if owned then
			for i = 1, tip:NumLines() do
				local line = _G[tip:GetName() .. 'TextLeft' .. i]
				local text = line:GetText()

				if text and text:find('^' .. COLLECTED) then
					line:SetText(DIM_GREEN_FONT_COLOR:WrapTextInColorCode(owned))
					return
				end
			end
		end
	end
end

function Tooltips.OnBattlePet(tip, data)
	if data and data.speciesID then
		tip.specie = Addon.Specie(data.speciesID)
		tip.breed = Addon.Predict:Breed(data.speciesID, data.level, data.breedQuality + 1, data.maxHealth, data.power, data.speed)

		if not tip.Source then
			tip.Source = tip:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightLeft')
			tip.Source:SetPoint('BOTTOMLEFT', tip, 11, 8)
			tip.Source:SetSize(tip:GetWidth() - 20, 0)

			hooksecurefunc(tip, 'Show', function(tip)
				tip.Owned:SetText(NORMAL_FONT_COLOR:WrapTextInColorCode(tip.specie:GetOwnedText() or ''))
				tip.Name:SetText((tip.Name:GetText() or '') .. Addon.Breeds:Icon(tip.breed, .8, 5,0))
				tip.Source:SetText(select(5, tip.specie:GetInfo()) or '')

				tip:SetHeight(tip:GetHeight() + tip.Source:GetHeight())
			end)
		end
	end
end
