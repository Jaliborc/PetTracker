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
local Journal, Tamer = Addon.Journal, Addon.Tamer
local MapCanvas = Addon:NewModule('MapCanvas')
MapCanvas.pins, MapCanvas.tips = {}, {}

hooksecurefunc(MapCanvasMixin, 'OnMapChanged', function(frame)
	MapCanvas:Init(frame)

	if Addon.Sets then
		MapCanvas:Redraw(frame)
	end
end)


--[[ Events ]]--

function MapCanvas:Startup()
	self:TrackingChanged()
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
	end

	self.tips[frame] = Addon.MapTip(frame)
	self.pins[frame] = {}

	hooksecurefunc(frame, 'OnCanvasScaleChanged', function(f) self:Scale(f) end)
	frame:HookScript('OnShow', function(f) self:Draw(f) end)
	frame:HookScript('OnUpdate', function(f) self:DrawTip(f) end)
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

function MapCanvas:Draw(frame)
	local mapID = frame:GetMapID()
	local species = Journal.GetSpeciesIn(mapID)
	local stables = Journal.GetStablesIn(mapID)
	local canvas = frame:GetCanvas()

	for specie, spots in pairs(species) do
		local specie = Addon.Specie:Get(specie)

		if Addon:Filter(specie, Addon.Sets.MapFilter) then
			local icon = specie:GetTypeIcon()

			for x, y in gmatch(spots, '(%w%w)(%w%w)') do
				local pin = Addon.SpeciePin(canvas):Place(frame, x, y)
				pin.icon:SetTexture(icon)
				pin.specie = specie

				tinsert(self.pins[frame], pin)
			end
		end
	end

	for x, y in gmatch(stables, '(%w%w)(%w%w)') do
		tinsert(self.pins[frame], Addon.StablePin(canvas):Place(frame, x, y))
	end
end

function MapCanvas:DrawTip(frame)
	local tip = self.tips[frame]

	if GameTooltip:IsVisible() then
		tip:Hide()
	else
		tip:Anchor(frame:GetCanvas(), 'ANCHOR_CURSOR')

		for _, pin in ipairs(self.pins[frame]) do
			local focus = pin:IsMouseOver()
			if focus then
				local title, text = pin:GetTooltip()
				tip:AddHeader(title)
				tip:AddLine(text, 1,1,1)
			end
		end

		tip:Display()
	end
end

function MapCanvas:Scale(frame)
	local scale = max(frame:GetCanvasScale(), 0.5)
	for _, pin in ipairs(self.pins[frame]) do
			pin.icon:SetScale(1 / scale)
	end
end
