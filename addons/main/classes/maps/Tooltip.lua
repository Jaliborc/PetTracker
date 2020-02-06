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
local Tooltip = Addon:NewClass('GameTooltip', 'MapTip', 'GameTooltipTemplate')


--[[ Constructor ]]--

function Tooltip:OnAcquire()
	self.Strokes = {}
end


--[[ API ]]--

function Tooltip:Anchor(...)
	self:SetOwner(...)
	self.NumStrokes = 0

	for i, stroke in pairs(self.Strokes) do
		stroke:Hide()
	end
end

function Tooltip:AddHeader(header)
	self:AddLine(header, 1,1,1, true)
end

function Tooltip:AddLine(text, r,g,b, isHeader)
	self.__type.AddLine(self, text, r,g,b, not isHeader)

	local i = self:NumLines()
	if i > 1 then
		local previous = self:GetLine(i - 1)
		local line = self:GetLine(i)
		line:SetPoint('TOPLEFT', previous, 'BOTTOMLEFT', 0, isHeader and -10 or -2)
		line:SetFontObject(isHeader and GameTooltipHeaderText or GameTooltipText)

		if isHeader then
			self:GetStroke(i):Show()
			self.NumStrokes = self.NumStrokes + 1
		end
	end
end

function Tooltip:Display()
	self:SetShown(self:NumLines() > 0)
	if self:IsShown() then
		local parent = self:GetParent()

		self:SetHeight(self:GetHeight() + self.NumStrokes * 8)
		self:SetScale(parent and (1 / parent:GetScale()) or UIParent:GetScale())
		self:SetFrameStrata('FULLSCREEN_DIALOG')
	end
end


--[[ Children ]]--

function Tooltip:GetLine(i)
	return _G[self:GetName() .. 'TextLeft' .. i]
end

function Tooltip:GetStroke(i)
	return self.Strokes[i] or self:CreateStroke(i)
end

function Tooltip:CreateStroke(i)
	local line = self:GetLine(i - 1)
	local stroke = self:CreateTexture()
	stroke:SetPoint('TOPLEFT', line, 'BOTTOMLEFT', -5, -3)
	stroke:SetPoint('TOPRIGHT', line, 'BOTTOMRIGHT', 5, -3)
	stroke:SetColorTexture(.3, .3, .3)
	stroke:SetHeight(1)

	self.Strokes[i] = stroke
	return stroke
end
