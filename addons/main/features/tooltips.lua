--[[
Copyright 2012-2022 João Cardoso
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
local Tooltips = Addon:NewModule('Tooltips')

function Tooltips:OnEnable()
  hooksecurefunc('BattlePetTooltipTemplate_SetBattlePet', self.OnBattlePet)
  TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, self.OnUnit)
end

function Tooltips.OnUnit(tip)
  local specie = tip:GetOwner() ~= 'ANCHOR_NONE' and C_PetJournal.FindPetIDByName(TooltipUtil.GetDisplayedUnit(tip))
  if specie then
    local owned = Addon.Specie(specie):GetOwnedText()
    if owned then
      for i = 1, tip:NumLines() do
        local line = _G[tip:GetName() .. 'TextLeft' .. i]
        if line:GetText():find('^' .. COLLECTED) then
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