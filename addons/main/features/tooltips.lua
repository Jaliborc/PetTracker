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
local Tooltips = Addon:NewModule('Tooltips')

function Tooltips:OnEnable()
  self.data = {}

  hooksecurefunc('BattlePetTooltipTemplate_SetBattlePet', function(tip, data)
    if data.speciesID and not tip.Source then
      self:Init(tip)
    end

    self.data[tip] = data
  end)
end

function Tooltips:Init(tip)
  local source = tip:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightLeft')
  source:SetPoint('TOPLEFT', tip.Owned, 'BOTTOMLEFT', 0,-2)
  source:SetSize(tip:GetWidth(), 0)
  tip.Source = source

  hooksecurefunc(tip, 'Show', function()
    local data = self.data[tip]
    local breed = Addon.Predict:Breed(data.speciesID, data.level, data.breedQuality + 1, data.maxHealth, data.power, data.speed)
    local _,_,_,_, source = Addon.Journal:GetInfo(data.speciesID)

    tip.Source:SetText(source)
    tip.Name:SetText((tip.Name:GetText() or '') .. Addon:GetBreedIcon(breed, .8, 5, 0))
    tip.Owned:SetText(Addon.Journal:GetOwnedText(data.speciesID) or tip.Owned:GetText())
    tip:SetHeight(tip:GetHeight() + tip.Source:GetHeight() + 4)
  end)
end
