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
local MapSearch = Addon:NewModule('MapSearch')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)


--[[ Startup ]]--

function MapSearch:OnEnable()
	self.Frames = {}
	self.Suggestions = {LibStub('CustomSearch-1.0').NOT .. ' ' .. L.Maximized, '< ' .. BATTLE_PET_BREED_QUALITY3, ADDON_MISSING}
	self:RegisterSignal('OPTIONS_CHANGED', 'UpdateBoxes')

	hooksecurefunc(MapCanvasMixin, 'OnMapChanged', function(frame)
		self:Init(frame)
	end)
end

function MapSearch:UpdateFrames()
  for frame in pairs(self.Frames) do
		if frame:IsVisible() then
    	frame:OnMapChanged()
		end
  end

  self:UpdateBoxes()
end

function MapSearch:UpdateBoxes()
  for frame, search in pairs(self.Frames) do
    if search ~= 1 then
      self:UpdateBox(frame)
    end
  end
end


--[[ Search Box ]]--

function MapSearch:Init(frame)
  if self.Frames[frame] then
    return
  end

  for i, overlay in ipairs(frame.overlayFrames or {}) do
    if overlay.OnClick == WorldMapTrackingOptionsButtonMixin.OnClick and overlay:IsObjectType('Button') then
      local search = CreateFrame('EditBox', '$parent'.. ADDON .. 'Search', overlay, 'SearchBoxTemplate')
			search.Instructions:SetText(L.FilterPets)
      search:SetScript('OnTextChanged', function() self:SetTextFilter(search:GetText()) end)
      search:HookScript('OnEditFocusGained', function() self:ShowSuggestions(search) end)
  		search:HookScript('OnEditFocusLost', function() self:HideSuggestions() end)
			search:SetPoint('RIGHT', overlay, 'LEFT', 0, 1)
			search:SetSize(128, 20)

      overlay:SetScript('OnMouseDown', function() self:ToggleTrackingTypes(overlay) end)

      self.Frames[frame] = search
      self:UpdateBox(frame)
    end
  end
end

function MapSearch:UpdateBox(frame)
  local text = Addon.sets.mapSearch or ''
  local search = self.Frames[frame]
  search.Instructions:SetShown(text == '')
  search:SetShown(not Addon.sets.hideSpecies)
  search:SetText(text)
end

function MapSearch:SetTextFilter(text)
  if Addon.sets.mapSearch ~= text then
    Addon.sets.mapSearch = text
    Addon:SendSignal('OPTIONS_CHANGED')
  end
end


--[[ Dropdopwns ]]--

function MapSearch:ShowSuggestions(parent)
	local drop = LibStub('Sushi-3.1').Dropdown(parent, nil, true)
	drop:SetPoint('TOP', parent, 'BOTTOM', 0, -15)
	drop:SetChildren(function(drop)
		drop:Add {
			text = L.CommonSearches,
			isTitle = true, notCheckable = true
		}

		for i, text in ipairs(self.Suggestions) do
			drop:Add {
			  func = function() self:SetTextFilter(text) end,
				text = text, notCheckable = true,
			}
		end
	end)

	self.SuggestionsDrop = drop
end

function MapSearch:HideSuggestions(parent)
	if not MouseIsOver(self.SuggestionsDrop) and self.SuggestionsDrop:IsActive() then
		self.SuggestionsDrop:Release()
	end
end

function MapSearch:ToggleTrackingTypes(parent)
	local drop = LibStub('Sushi-3.1').Dropdown:Toggle(parent)
	if drop then
		drop:SetPoint('TOPLEFT', parent, 'BOTTOMLEFT', 0, -15)
		drop:SetChildren(function(drop)
	    local map = WorldMapFrame:GetMapID()
	    local bounties = map and MapUtil.MapHasEmissaries(map)
	    local prof1, prof2, arch, fish, cook, firstAid = GetProfessions()
	    local types = {
	      {SHOW, true, title = true},
	      {SHOW_QUEST_OBJECTIVES_ON_MAP_TEXT, true, var = 'questPOI'},
				{SHOW_DUNGEON_ENTRACES_ON_MAP_TEXT, true, var = 'showDungeonEntrancesOnMap'},
	      {ARCHAEOLOGY_SHOW_DIG_SITES, arch, var = 'digSites'},
	      {SHOW_PRIMARY_PROFESSION_ON_MAP_TEXT, bounties and (prof1 or prof2), var = 'primaryProfessionsFilter'},
	      {SHOW_SECONDARY_PROFESSION_ON_MAP_TEXT, bounties and (fish or cook or firstAid), var = 'secondaryProfessionsFilter'},

	      {PETS, true, title = true},
	      {L.Species, true, set = 'hideSpecies'},
				{L.Rivals, true, var = 'showTamers'},
				{STABLES, true, set = 'hideStables'},

	      {WORLD_QUEST_REWARD_FILTERS_TITLE, bounties, title = true},
	      {WORLD_QUEST_REWARD_FILTERS_RESOURCES, bounties, var = 'worldQuestFilterResources'},
	      {WORLD_QUEST_REWARD_FILTERS_ARTIFACT_POWER, bounties, var = 'worldQuestFilterArtifactPower'},
	      {WORLD_QUEST_REWARD_FILTERS_PROFESSION_MATERIALS, bounties, var = 'worldQuestFilterProfessionMaterials'},
	      {WORLD_QUEST_REWARD_FILTERS_GOLD, bounties, var = 'worldQuestFilterGold'},
	      {WORLD_QUEST_REWARD_FILTERS_EQUIPMENT, bounties, var = 'worldQuestFilterEquipment'},
				{WORLD_QUEST_REWARD_FILTERS_REPUTATION, bounties, var = 'worldQuestFilterReputation'},
	    }

	    for i, entry in ipairs(types) do
	      local text, shown = entry[1], entry[2]
	      if shown then
	        local checked = entry.set and not Addon.sets[entry.set] or entry.var and GetCVarBool(entry.var)

	        drop:Add {
	          text = text,
						checked = checked,
	          isTitle = entry.title, notCheckable = entry.title,
	          keepShownOnClick = true, isNotRadio = true,
	          func = function()
	            if entry.set then
	              Addon.sets[entry.set] = checked and true or nil
	            end

							if entry.var then
	              SetCVar(entry.var, checked and '0' or '1')
	            end

	            PlaySound(checked and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	            self:UpdateFrames()
	          end,
	        }
	      end
	    end
		end)
	end
end
