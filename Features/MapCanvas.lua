--[[
Copyright 2012-2019 João Cardoso
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
local Journal, Rival = Addon.Journal, Addon.Rival
local MapCanvas = Addon:NewModule('MapCanvas')
MapCanvas.pins = {}

hooksecurefunc(MapCanvasMixin, 'OnMapChanged', function(frame)
	MapCanvas:Init(frame)
	MapCanvas:Redraw(frame)
end)


--[[ Events ]]--

function MapCanvas:Startup()
	self:TrackingChanged()
	self.tip = Addon.MapTip()
	self.tip:SetScript('OnUpdate', function() self:AnchorTip() end)
end

function MapCanvas:AddOptions(panel)
	panel:Create('CheckButton', 'HideRivals')
end

function MapCanvas:TrackingChanged()
	for frame in pairs(self.pins) do
		if frame:IsVisible() then
			self:Redraw(frame)
		end
	end
end


--[[ API ]]--

function MapCanvas:Init(frame)
	if self.pins[frame] then
		return
	else
		self.pins[frame] = {}
	end

	hooksecurefunc(frame, 'OnCanvasScaleChanged', function(f) self:Scale(f) end)
	frame:HookScript('OnShow', function(f) self:Draw(f) end)
	frame:HookScript('OnUpdate', function(f) self:AnchorTip(f) end)
	frame:HookScript('OnHide', function(f) self:Clear(f) end)
end

function MapCanvas:Redraw(frame)
		self:Clear(frame)
		self:Draw(frame)
		self:Scale(frame)
end

function MapCanvas:Clear(frame)
	for _, pin in ipairs(self.pins[frame]) do
		pin:Release()
	end
	wipe(self.pins[frame])
end

function MapCanvas:Validate(frame)
	for provider in pairs(frame.dataProviders) do
		if provider.RefreshAllData == PetTamerDataProviderMixin.RefreshAllData then
			return true
		end
	end
end

function MapCanvas:Draw(frame)
	if Addon.Sets and self:Validate(frame) then
		local mapID = frame:GetMapID()
		local index = 1

		if not Addon.Sets.HideSpecies then
			local species = Journal.GetSpeciesIn(mapID)
			for specie, spots in pairs(species) do
				local specie = Addon.Specie:Get(specie)

				if Addon:Filter(specie, Addon.Sets.MapFilter) then
					local icon = specie:GetTypeIcon()

					for x, y in gmatch(spots, '(%w%w)(%w%w)') do
						local pin = Addon.SpeciePin()
						pin:PlaceEncoded(frame, index, x, y)
						pin.icon:SetTexture(icon)
						pin.specie = specie

						tinsert(self.pins[frame], pin)
					end
				end
			end
		end

		if not Addon.Sets.HideRivals and GetCVarBool('showTamers') then
			local rivals = Journal.GetRivalsIn(mapID)
			for rival, spot in pairs(rivals) do
					local rival = Addon.Rival:Get(rival)
					local pin = Addon.RivalPin()
					pin:PlaceEncoded(frame, index, spot:match('(%w%w)(%w%w)'))
					pin:Display(rival)

					index = index + 1
					tinsert(self.pins[frame], pin)
			end
		end

		if not Addon.Sets.HideStables then
			local stables = Journal.GetStablesIn(mapID)
			for x, y in gmatch(stables, '(%w%w)(%w%w)') do
				tinsert(self.pins[frame], Addon.StablePin():PlaceEncoded(frame, index, x, y))
			end
		end
	end
end

function MapCanvas:Scale(frame)
	local scale = frame:GetGlobalPinScale() / frame:GetCanvasScale()
	for _, pin in ipairs(self.pins[frame]) do
			pin.icon:SetScale(scale)
	end
end

function MapCanvas:AnchorTip()
	if GameTooltip:IsVisible() then
		self.tip:Hide()
	else
		self.tip:Anchor(UIParent, 'ANCHOR_CURSOR')

		for frame, pins in pairs(self.pins) do
			if frame:IsVisible() then
				for _, pin in ipairs(pins) do
					local focus = pin:IsMouseOver()
					if focus then
						pin:OnTooltip(self.tip)
					end
				end
			end
		end

		self.tip:Display()
	end
end
