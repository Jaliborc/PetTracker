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


--[[ Search Box ]]--

function WorldMap:Startup()
  self.Instructions:SetText(L.FilterPets)
  self.TrackButton = self:GetParent()
  self.TrackButton:SetScript('OnClick', function()
    SushiDropFrame:Toggle('TOPLEFT', self.TrackButton, 'BOTTOMLEFT', 0, -15, true, WorldMap.ShowTrackingTypes)
  end)

  self:UpdateShown()
  self:SetSize(128, 20)
  self:SetText(Addon.Sets.MapFilter or '')
  self:SetPoint('RIGHT', self.TrackButton, 'LEFT', 0, 1)
  self:SetScript('OnTextChanged', self.TextChanged)
  self:HookScript('OnEditFocusGained', self.FocusGained)
  self:HookScript('OnEditFocusLost', self.FocusLost)
end

function WorldMap:UpdateShown()
  self:SetShown(not Addon.Sets.HideSpecies)
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


--[[ Dropdopwns ]]--

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

function WorldMap:ShowTrackingTypes()
    local map = WorldMapFrame:GetMapID()
    local bounties = map and MapUtil.MapHasUnlockedBounties(map)
    local prof1, prof2, arch, fish, cook, firstAid = GetProfessions()
    local types = {
      {SHOW, '', true, title = true},
      {SHOW_QUEST_OBJECTIVES_ON_MAP_TEXT, 'questPOI', true},
      {ARCHAEOLOGY_SHOW_DIG_SITES, 'digSites', arch},
      {SHOW_PRIMARY_PROFESSION_ON_MAP_TEXT, 'primaryProfessionsFilter', bounties and (prof1 or prof2)},
      {SHOW_SECONDARY_PROFESSION_ON_MAP_TEXT, 'secondaryProfessionsFilter', bounties and (fish or cook or firstAid)},

      {PETS, '', true, title = true},
      {L.Species, 'HideSpecies', true, custom = true},
      {L.Battles, 'showTamers', CanTrackBattlePets()},
      {STABLES, 'HideStables', true, custom = true},

      {WORLD_QUEST_REWARD_FILTERS_TITLE, '', bounties, title = true},
      {WORLD_QUEST_REWARD_FILTERS_RESOURCES, 'worldQuestFilterResources', bounties},
      {WORLD_QUEST_REWARD_FILTERS_ARTIFACT_POWER, 'worldQuestFilterArtifactPower', bounties},
      {WORLD_QUEST_REWARD_FILTERS_PROFESSION_MATERIALS, 'worldQuestFilterProfessionMaterials', bounties},
      {WORLD_QUEST_REWARD_FILTERS_GOLD, 'worldQuestFilterGold', bounties},
      {WORLD_QUEST_REWARD_FILTERS_EQUIPMENT, 'worldQuestFilterEquipment', bounties},
    }

    for i, entry in ipairs(types) do
      local text, var, shown = entry[1], entry[2], entry[3]
      if shown then
        local checked
        if entry.custom then
          checked = not Addon.Sets[var]
        else
          checked = GetCVarBool(var)
        end

        self:AddLine {
          text = text,
          isTitle = entry.title,
          notCheckable = entry.title,
          checked = checked,
          keepShownOnClick = true,
          isNotRadio = true,
          func = function()
            if entry.custom then
              Addon.Sets[var] = checked and true or nil
            else
              SetCVar(var, checked and '0' or '1')
            end

            PlaySound(checked and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
            WorldMapFrame:OnMapChanged()
            WorldMap:UpdateShown()
          end,
        }
      end
    end
end
