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
local SourceStrings = {}

local function CreateString(tooltip)
  local string = tooltip:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightLeft')
  string:SetPoint('TOPLEFT', tooltip.Owned, 'BOTTOMLEFT', 0,-2)
  string:SetSize(tooltip:GetWidth(), 0)

  hooksecurefunc(tooltip, 'Show', function()
    tooltip:SetHeight(tooltip:GetHeight() + string:GetHeight() + 4)
  end)

  SourceStrings[tooltip] = string
  return string
end

hooksecurefunc('BattlePetTooltipTemplate_SetBattlePet', function(tooltip, data)
  if data.speciesID then
    local string = SourceStrings[tooltip] or CreateString(tooltip)
    local _,_,_,_, source = Addon.Journal:GetInfo(data.speciesID)

    string:SetText(source)
  end
end)
