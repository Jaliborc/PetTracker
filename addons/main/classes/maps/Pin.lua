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
local Pin = Addon.Base:NewClass('Pin', 'Button')

function Pin:Construct()
	local b = self:Super(Pin):Construct()
	b:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
	b.FrameLevel = 'PIN_FRAME_LEVEL_DIG_SITE'
	b.Icon = b:CreateTexture(nil, 'ARTWORK')
	b.Icon:SetPoint('CENTER')
	return b
end

function Pin:New(frame, index, x,y)
	local canvas = frame:GetCanvas()
	local levelmanager = frame:GetPinFrameLevelsManager()
	local x, y = tonumber(x, 36) / 1000, tonumber(y, 36) / 1000

	local b = self:Super(Pin):New(canvas)
	b:SetPoint('CENTER', canvas, 'TOPLEFT', canvas:GetWidth() * x, -canvas:GetHeight() * y)
	b:SetFrameLevel(levelmanager:GetValidFrameLevel(self.FrameLevel)+index)
	return b
end
