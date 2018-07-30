--[[
Copyright 2012-2018 João Cardoso
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
local L = Addon.Locals
local WorldMap = Addon:NewModule('WorldMap', CreateFrame('EditBox', ADDON..'MapFilter', WorldMapFrame.overlayFrames[2], 'SearchBoxTemplate'))
WorldMap.SUGGESTIONS = {LibStub('CustomSearch-1.0').NOT .. ' ' .. L.Maximized, '< ' .. BATTLE_PET_BREED_QUALITY3, ADDON_MISSING}

function WorldMap:Startup()
  self.Instructions:SetText(L.FilterPets)
  self.TrackButton = self:GetParent()
  self.TrackButton:SetScript('OnClick', self.ShowTrackingTypes)

  self:SetSize(128, 20)
  self:SetText(Addon.Sets.MapFilter or '')
  self:SetPoint('RIGHT', self.TrackButton, 'LEFT', 0, 1)
  self:SetScript('OnTextChanged', self.TextChanged)
  self:SetScript('OnEditFocusGained', self.FocusGained)
  self:SetScript('OnEditFocusLost', self.FocusLost)
end

function WorldMap:TextChanged()
    Addon.Sets.MapFilter = self:GetText()
    Addon:ForAllModules('TrackingChanged')
    self.Instructions:SetShown(self:GetText() == '')
end

function WorldMap:FocusGained()
  SushiDropFrame:Toggle('TOP', self, 'BOTTOM', 0, -15, true, WorldMap.ShowSuggestions)
end

function WorldMap:FocusLost()
    SearchBoxTemplate_OnEditFocusLost(self)
    SushiDropFrame:CloseAll()
end

function WorldMap:ShowSuggestions()
	self:AddLine {
		text = L.CommonSearches,
		isTitle = true,
		notCheckable = true
	}

  for i, text in ipairs(WorldMap.SUGGESTIONS) do
    self:AddLine {
      text = text,
      notCheckable = true,
      func = function()
        WorldMap:SetText(text)
        WorldMap:ClearFocus()
      end
    }
  end
end
