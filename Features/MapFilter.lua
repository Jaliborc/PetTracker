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
local L = Addon.Locals
local MapFilter = Addon:NewModule('MapFilter')
MapFilter.suggestions = {LibStub('CustomSearch-1.0').NOT .. ' ' .. L.Maximized, '< ' .. BATTLE_PET_BREED_QUALITY3, ADDON_MISSING}
MapFilter.frames = {}

hooksecurefunc(MapCanvasMixin, 'OnMapChanged', function(frame)
	MapFilter:Init(frame)
end)


--[[ Search Box ]]--

function MapFilter:Init(frame)
  if self.frames[frame] then
    return
  else
    self.frames[frame] = 1
  end

  for i, overlay in ipairs(frame.overlayFrames or {}) do
    if overlay.OnClick == WorldMapTrackingOptionsButtonMixin.OnClick and overlay:IsObjectType('Button') then
      local search = CreateFrame('EditBox', '$parent'.. ADDON .. 'Filter', overlay, 'SearchBoxTemplate')
      search.Instructions:SetText(L.FilterPets)
      search:SetPoint('RIGHT', overlay, 'LEFT', 0, 1)
      search:SetSize(128, 20)
      search:SetScript('OnTextChanged', function(search, manual)
        self:SetTextFilter(search:GetText())
      end)

      search:HookScript('OnEditFocusGained', function()
        SushiDropFrame:Toggle('TOP', search, 'BOTTOM', 0, -15, true, self.ShowSuggestions)
      end)

      search:HookScript('OnEditFocusLost', function()
        SushiDropFrame:CloseAll()
      end)

      overlay:SetScript('OnMouseDown', function()
        SushiDropFrame:Toggle('TOPLEFT', overlay, 'BOTTOMLEFT', 0, -15, true, self.ShowTrackingTypes)
      end)

      self.frames[frame] = search
      self:UpdateSearch(frame)
    end
  end
end

function MapFilter:Startup()
	self:TrackingChanged()
end

function MapFilter:TrackingChanged()
  for frame, search in pairs(self.frames) do
    if search ~= 1 then
      self:UpdateSearch(frame)
    end
  end
end

function MapFilter:UpdateSearch(frame)
	if Addon.Sets then
	  local text = Addon.Sets.MapFilter or ''
	  local search = self.frames[frame]
	  search.Instructions:SetShown(text == '')
	  search:SetShown(not Addon.Sets.HideSpecies)
	  search:SetText(text)
	end
end

function MapFilter:UpdateFrames()
  for frame in pairs(self.frames) do
		if frame:IsVisible() then
    	frame:OnMapChanged()
		end
  end

  self:TrackingChanged()
end

function MapFilter:SetTextFilter(text)
  if Addon.Sets and Addon.Sets.MapFilter ~= text then
    Addon.Sets.MapFilter = text
    Addon:ForAllModules('TrackingChanged')
  end
end


--[[ Dropdopwns ]]--

function MapFilter:ShowSuggestions()
	self:AddLine {
		text = L.CommonSearches,
		isTitle = true,
		notCheckable = true
	}

  for i, text in ipairs(MapFilter.suggestions) do
    self:AddLine {
      text = text,
      notCheckable = true,
      func = function()
        MapFilter:SetTextFilter(text)
      end
    }
  end
end

function MapFilter:ShowTrackingTypes()
    local map = WorldMapFrame:GetMapID()
    local bounties = map and MapUtil.MapHasUnlockedBounties(map)
    local prof1, prof2, arch, fish, cook, firstAid = GetProfessions()
    local types = {
      {SHOW, true, title = true},
      {SHOW_QUEST_OBJECTIVES_ON_MAP_TEXT, true, var = 'questPOI'},
      {ARCHAEOLOGY_SHOW_DIG_SITES, arch, var = 'digSites'},
      {SHOW_PRIMARY_PROFESSION_ON_MAP_TEXT, bounties and (prof1 or prof2), var = 'primaryProfessionsFilter'},
      {SHOW_SECONDARY_PROFESSION_ON_MAP_TEXT, bounties and (fish or cook or firstAid), var = 'secondaryProfessionsFilter'},

      {PETS, true, title = true},
      {L.Species, true, set = 'HideSpecies'},
			{L.Battles, true, var = 'showTamers'},
			{STABLES, true, set = 'HideStables'},

      {WORLD_QUEST_REWARD_FILTERS_TITLE, bounties, title = true},
      {WORLD_QUEST_REWARD_FILTERS_RESOURCES, bounties, var = 'worldQuestFilterResources'},
      {WORLD_QUEST_REWARD_FILTERS_ARTIFACT_POWER, bounties, var = 'worldQuestFilterArtifactPower'},
      {WORLD_QUEST_REWARD_FILTERS_PROFESSION_MATERIALS, bounties, var = 'worldQuestFilterProfessionMaterials'},
      {WORLD_QUEST_REWARD_FILTERS_GOLD, bounties, var = 'worldQuestFilterGold'},
      {WORLD_QUEST_REWARD_FILTERS_EQUIPMENT, bounties, var = 'worldQuestFilterEquipment'},
    }

    for i, entry in ipairs(types) do
      local text, shown = entry[1], entry[2]
      if shown then
        local checked = entry.set and not Addon.Sets[entry.set] or entry.var and GetCVarBool(entry.var)

        self:AddLine {
          text = text,
          isTitle = entry.title,
          notCheckable = entry.title,
          checked = checked,
          keepShownOnClick = true,
          isNotRadio = true,
          func = function()
            if entry.set then
              Addon.Sets[entry.set] = checked and true or nil
            end

						if entry.var then
              SetCVar(entry.var, checked and '0' or '1')
            end

            PlaySound(checked and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
            MapFilter:UpdateFrames()
          end,
        }
      end
    end
end
