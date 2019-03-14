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
local Pin = Addon:NewClass('Button', 'Pin')

function Pin:OnCreate()
	self:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
	self.framelevel = 'PIN_FRAME_LEVEL_DIG_SITE'
	self.icon = self:CreateTexture(nil, 'ARTWORK')
	self.icon:SetPoint('CENTER')
end

function Pin:PlaceEncoded(frame, index, x, y)
	return self:Place(frame, index, tonumber(x, 36) / 1000, tonumber(y, 36) / 1000)
end

function Pin:Place(frame, index, x, y)
	local canvas = frame:GetCanvas()
	local levelmanager = frame:GetPinFrameLevelsManager()

	self:Show()
	self:SetParent(canvas)
	self:SetPoint('CENTER', canvas, 'TOPLEFT', canvas:GetWidth() * x, -canvas:GetHeight() * y)
	self:SetFrameLevel(levelmanager:GetValidFrameLevel(self.framelevel)+index)

	return self
end

function Pin:OnRelease()
	self:Hide()
end
