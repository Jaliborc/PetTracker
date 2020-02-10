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
Pin.FrameLevel = 'PIN_FRAME_LEVEL_DIG_SITE'

function Pin:Construct()
	local b = self:Super(Pin):Construct()
	b:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
	b.Icon = b:CreateTexture(nil, 'ARTWORK')
	b.Icon:SetPoint('CENTER')
	return b
end

function Pin:New(frame, index, x,y)
	local canvas = frame:GetCanvas()
	local levelmanager = frame:GetPinFrameLevelsManager()
	local b = self:Super(Pin):New(canvas)
	b:SetPoint('CENTER', canvas, 'TOPLEFT', canvas:GetWidth() * self:ToNumber(x), -canvas:GetHeight() * self:ToNumber(y))
	b:SetFrameLevel(levelmanager:GetValidFrameLevel(self.FrameLevel)+index)
	return b
end

function Pin:ToNumber(value)
	return type(value) == 'string' and (tonumber(value, 36) / 1000) or value
end
