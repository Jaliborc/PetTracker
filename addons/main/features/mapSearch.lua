--[[
Copyright 2012-2021 João Cardoso
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
	local box = CreateFrame('EditBox', ADDON .. 'MapSearchBox', UIParent, 'SearchBoxTemplate')
	box.Instructions:SetText(L.FilterSpecies)
	box:SetScript('OnTextChanged', function() self:SetText(box:GetText()) end)
	box:HookScript('OnEditFocusGained', function() self:ShowSuggestions(box) end)
	box:HookScript('OnEditFocusLost', function() self:HideSuggestions() end)
	box.top, box.bottom, box.left, box.right, box.Release = 2, 6, 20, 15, false
	box:SetSize(128, 20)
	box:Hide()

	self.Frames = {}
	self.Editbox = box
	self.Suggestions = {LibStub('CustomSearch-1.0').NOT .. ' ' .. L.Maximized, '< ' .. BATTLE_PET_BREED_QUALITY3, ADDON_MISSING}
	self:RegisterSignal('OPTIONS_CHANGED', 'UpdateEditbox')
	self:UpdateEditbox()

	hooksecurefunc(MapCanvasMixin, 'OnMapChanged', function(frame)
		self:Init(frame)
	end)
end

function MapSearch:Init(frame)
  if not self.Frames[frame] then
	  for i, overlay in ipairs(frame.overlayFrames or {}) do
			if overlay.Icon and overlay.Icon.GetTexture and overlay.Icon:GetTexture() == 'Interface\\Minimap\\Tracking\\None' then
	    	overlay:SetScript('OnMouseDown', function()
					overlay.Icon:SetPoint('TOPLEFT', 8, -8)
					overlay.IconOverlay:Show()

					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
					self:ToggleTrackingTypes(overlay)
				end)
				self.Frames[frame] = overlay
	    end
	  end
	 end
end

function MapSearch:UpdateFrames()
  for frame in pairs(self.Frames) do
		if frame:IsVisible() then
    	frame:OnMapChanged()
		end
  end
end


--[[ Tracking Dropdown ]]--

function MapSearch:ToggleTrackingTypes(parent)
	local drop = LibStub('Sushi-3.1').Dropdown:Toggle(parent)
	if drop then
		drop:SetPoint('TOPLEFT', parent, 'BOTTOMLEFT', 0, -15)
		drop:SetCall('OnReset', function() self.Editbox:Hide() end)
		drop:SetChildren(function(drop)
			local map = WorldMapFrame:GetMapID()
			local bounties = map and MapUtil.MapHasEmissaries(map)
			local prof1, prof2, arch, fish, cook, firstAid = GetProfessions()

			local function addLine(info)
				info.checked = info.set and not Addon.sets[info.set] or info.var and GetCVarBool(info.var)
				info.keepShownOnClick, info.isNotRadio = true, true
				info.notCheckable = info.isTitle
				info.func = self.OnLineClick
				drop:Add(info)
			end

			addLine {text = SHOW, isTitle = true}
			addLine {text = SHOW_QUEST_OBJECTIVES_ON_MAP_TEXT, var = 'questPOI'}
			addLine {text = SHOW_DUNGEON_ENTRACES_ON_MAP_TEXT, var = 'showDungeonEntrancesOnMap'}

			if arch then
				addLine {text = ARCHAEOLOGY_SHOW_DIG_SITES, var = 'digSites'}
			end

			if bounties then
				if prof1 or prof2 then
					addLine {text = SHOW_PRIMARY_PROFESSION_ON_MAP_TEXT, var = 'primaryProfessionsFilter'}
				end

				if fish or cook or firstAid then
					addLine {text = SHOW_SECONDARY_PROFESSION_ON_MAP_TEXT, var = 'secondaryProfessionsFilter'}
				end
			end

			addLine {text = PETS, isTitle = true}
			addLine {text = L.Species, set = 'hideSpecies'}

			self.Editbox:SetShown(not Addon.sets.hideSpecies)
			if not Addon.sets.hideSpecies then
				drop:Add(self.Editbox)
			end

			addLine {text = L.Rivals, var = 'showTamers'}
			addLine {text = STABLES, set = 'hideStables'}

			if bounties then
				addLine {text = WORLD_QUEST_REWARD_FILTERS_TITLE, isTitle = true}
				addLine {text = WORLD_QUEST_REWARD_FILTERS_RESOURCES, var = 'worldQuestFilterResources'}
				addLine {text = WORLD_QUEST_REWARD_FILTERS_ARTIFACT_POWER, var = 'worldQuestFilterArtifactPower'}
				addLine {text = WORLD_QUEST_REWARD_FILTERS_PROFESSION_MATERIALS, var = 'worldQuestFilterProfessionMaterials'}
				addLine {text = WORLD_QUEST_REWARD_FILTERS_GOLD, var = 'worldQuestFilterGold'}
				addLine {text = WORLD_QUEST_REWARD_FILTERS_EQUIPMENT, var = 'worldQuestFilterEquipment'}
				addLine {text = WORLD_QUEST_REWARD_FILTERS_REPUTATION, var = 'worldQuestFilterReputation'}
			end

			for i, addon in pairs(WORLDMAP_TRACKING_BUTTON_ADDONS or {}) do
				addon(drop)
			end
		end)
	end
end

function MapSearch.OnLineClick(info)
	if info.set then
		Addon.sets[info.set] = not info.checked or nil
	end
	if info.var then
		SetCVar(info.var, info.checked and '1' or '0')
	end

	MapSearch:UpdateFrames()
end


--[[ Search Box ]]--

function MapSearch:SetText(text)
  if Addon.sets.mapSearch ~= text then
    Addon.sets.mapSearch = text
    Addon:SendSignal('OPTIONS_CHANGED')
  end
end

function MapSearch:UpdateEditbox()
  local text = Addon.sets.mapSearch or ''
  self.Editbox.Instructions:SetShown(text == '')
  self.Editbox:SetText(text)
end


--[[ Search Suggestions ]]--

function MapSearch:ShowSuggestions(parent)
	local drop = LibStub('Sushi-3.1').Dropdown(parent, nil, true)
	drop:SetPoint('TOP', parent, 'BOTTOM', 0, -15)
	drop:SetChildren(function(drop)
		drop:Add {
			text = L.CommonSearches,
			isTitle = true, notCheckable = true}

		for i, text in ipairs(self.Suggestions) do
			drop:Add {
			  func = function() self:SetText(text) end,
				text = text, notCheckable = true}
		end
	end)

	self.SuggestionsDrop = drop
end

function MapSearch:HideSuggestions(parent)
	if not self.SuggestionsDrop:IsMouseOver() and self.SuggestionsDrop:IsActive() then
		self.SuggestionsDrop:Release()
	end
end
