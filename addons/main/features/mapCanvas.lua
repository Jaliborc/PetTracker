--[[
	Copyright 2012-2026 João Cardoso
	All Rights Reserved
--]]

local ADDON, Addon = ...
local MapCanvas = Addon:NewModule('MapCanvas', 'MutexDelay-1.0')


--[[ Startup ]]--

function MapCanvas:OnLoad()
	self.Tip, self.Pins = Addon.MultiTip(UIParent), {}
	self.Tip:SetScript('OnUpdate', function() self:AnchorTip() end)
	self:RegisterEvent('TOOLTIP_DATA_UPDATE', 'Delay', 0, 'UpdateAll')
	self:RegisterSignal('COLLECTION_CHANGED', 'UpdateAll')
	self:RegisterSignal('OPTIONS_CHANGED', 'UpdateAll')
	self:RegisterEvent('CVAR_UPDATE', 'OnCVar')

	hooksecurefunc(MapCanvasMixin, 'OnMapChanged', function(frame)
		self:Init(frame)
		self:Redraw(frame)
	end)
end

function MapCanvas:OnCVar(var)
	if var == 'showTamers' then
		self:UpdateAll()
	end
end


--[[ Global API ]]--

function MapCanvas:UpdateAll()
	for frame in pairs(self.Pins) do
		if frame:IsVisible() then
			self:Redraw(frame)
		end
	end
end


function MapCanvas:AnchorTip()
	if GameTooltip:IsVisible() then
		self.Tip:Hide()
	else
		self.Tip:SetOwner(UIParent, 'ANCHOR_CURSOR')

		for frame, pins in pairs(self.Pins) do
			if frame:IsVisible() then
				for _, pin in ipairs(pins) do
					if pin:IsMouseOver() then
						pin:OnTooltip(self.Tip)
					end
				end
			end
		end

		self.Tip:Show()
	end
end


--[[ Frames API ]]--

function MapCanvas:Init(frame)
	if self.Pins[frame] then
		return
	end

	hooksecurefunc(frame, 'OnCanvasScaleChanged', function(f) self:Scale(f) end)
	frame:HookScript('OnShow', function(f) self:Draw(f) end)
	frame:HookScript('OnUpdate', function(f) self:AnchorTip(f) end)
	frame:HookScript('OnHide', function(f) self:Clear(f) end)
	self.Pins[frame] = {}
end

function MapCanvas:Redraw(frame)
	self:Clear(frame)
	self:Draw(frame)
	self:Scale(frame)
end

function MapCanvas:Clear(frame)
	for _, pin in ipairs(self.Pins[frame]) do
		pin:Release()
	end
	wipe(self.Pins[frame])
end

function MapCanvas:Draw(frame)
	if Addon.sets and self:Validate(frame) then
		local mapID = frame:GetMapID()
		local index = 1

		if Addon.sets.showSpecies then
			local species = Addon.Maps:GetSpeciesIn(mapID)
			for specie, spots in pairs(species) do
				local specie = Addon.Specie(specie)

				if Addon:Search(specie, Addon.sets.mapSearch) then
					for x, y in gmatch(spots, '(%w%w)(%w%w)') do
						tinsert(self.Pins[frame], Addon.SpeciePin(frame, index, x,y, specie))
						index = index + 1
					end
				end
			end
		end

		if Addon.sets.showStables then
			local stables = Addon.Maps:GetStablesIn(mapID)
			for x, y in gmatch(stables, '(%w%w)(%w%w)') do
				tinsert(self.Pins[frame], Addon.StablePin(frame, index, x,y))
			end
		end

		if Addon.sets.rivalPortraits and GetCVarBool('showTamers') then
			local rivals = Addon.Maps:GetRivalsIn(mapID)
			for rival, spot in pairs(rivals) do
					local rival = Addon.Rival(rival)
					local x, y = spot:match('(%w%w)(%w%w)')

					tinsert(self.Pins[frame], Addon.RivalPin(frame, index, x,y, rival))
					index = index + 1
			end
		end
	end
end

function MapCanvas:Scale(frame)
	local scale = frame:GetGlobalPinScale() / frame:GetCanvasScale()
	for _, pin in ipairs(self.Pins[frame]) do
		pin:SetCanvasScale(scale)
	end
end


--[[ Client-Specific ]]--

if LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_DRAGONFLIGHT then
	function MapCanvas:Validate(frame)
		for provider in pairs(frame.dataProviders) do
			if provider.RefreshAllData == PetTamerDataProviderMixin.RefreshAllData then
				return true
			end
		end
	end
else
	function MapCanvas:Validate(frame) return frame == WorldMapFrame end
end