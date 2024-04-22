--[[
Copyright 2012-2024 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local MapSearch = Addon:NewModule('MapSearch')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)


--[[ Startup ]]--

function MapSearch:OnEnable()
	local drop = LibStub('Sushi-3.2').Dropdown(UIParent)
	drop:Hide()
	drop:SetChildren(function() self:TrackingExtras(drop) end)
	drop:SetBackdrop('NONE')

	local box = CreateFrame('EditBox', ADDON .. 'MapSearchBox', UIParent, 'SearchBoxTemplate')
	box.Instructions:SetText(L.FilterSpecies)
	box:SetScript('OnTextChanged', function() self:SetText(box:GetText()) end)
	box:HookScript('OnEditFocusGained', function() self:ShowSuggestions(box) end)
	box:HookScript('OnEditFocusLost', function() self:HideSuggestions() end)
	box.top, box.bottom, box.left, box.right = 2, 6, 20, 15
	box:SetSize(128, 20)
	box:Hide()

	self.Frames = {}
	self.Dropdown, self.Editbox = drop, box
	self.Suggestions = {LibStub('CustomSearch-1.0').NOT .. ' ' .. L.Maximized, '< ' .. BATTLE_PET_BREED_QUALITY3, ADDON_MISSING}
	self:RegisterSignal('OPTIONS_CHANGED', 'UpdateEditbox')
	self:UpdateEditbox()

	hooksecurefunc(MapCanvasMixin, 'OnMapChanged', function(frame)
		self:Init(frame)
	end)
end

function MapSearch:Init(frame)
  if not self.Frames[frame] then
	for i, button in ipairs(frame.overlayFrames or {}) do
			if button.Icon and button.Icon.GetTexture and button.Icon:GetTexture() == GetFileIDFromPath('Interface/Minimap/Tracking/None') then
				LibStub('DropExtend-1.0'):Hook(button.DropDown, function(level)
					return level == 1 and self.Dropdown
				end)

				self.Frames[frame] = button
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


--[[ Tracking Extras ]]--

function MapSearch:TrackingExtras(drop)
	local function addLine(info)
		info.checked = info.set and not Addon.sets[info.set] or info.var and GetCVarBool(info.var)
		info.keepShownOnClick, info.isNotRadio = true, true
		info.notCheckable = info.isTitle
		info.func = self.OnLineClick
		drop:Add(info)
	end

	addLine {text = PETS..':', isTitle = true}
	addLine {text = L.Species, set = 'hideSpecies'}

	self.Editbox:SetShown(not Addon.sets.hideSpecies)
	if not Addon.sets.hideSpecies then
		drop:Add(self.Editbox)
	end

	addLine {text = L.Rivals, var = 'showTamers'}
	addLine {text = STABLES, set = 'hideStables'}
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
	if self.Editbox:GetText() ~= text then
		self.Editbox.Instructions:SetShown(text == '')
		self.Editbox:SetText(text)
	end
end


--[[ Search Suggestions ]]--

function MapSearch:ShowSuggestions(parent)
	local drop = LibStub('Sushi-3.2').Dropdown(parent, nil, true)
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
