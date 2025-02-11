--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local Pin = Addon.Base:NewClass('Pin', 'Button')
Pin.FrameLevel = 'PIN_FRAME_LEVEL_DIG_SITE'

function Pin:Construct()
	local b = self:Super(Pin):Construct()
	b:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
	return b
end

function Pin:New(frame, index, x,y)
	local canvas = frame:GetCanvas()
	local levelmanager = frame:GetPinFrameLevelsManager()
	local b = self:Super(Pin):New(canvas)
	b:SetFrameLevel(levelmanager:GetValidFrameLevel(self.FrameLevel) + index)
	b.y = -canvas:GetHeight() * self:ToNumber(y)
	b.x = canvas:GetWidth() * self:ToNumber(x)
	return b
end

function Pin:SetCanvasScale(scale)
	self:SetPoint('CENTER', self:GetParent(), 'TOPLEFT', self.x / scale, self.y / scale)
	self:SetScale(scale)
end

function Pin:ToNumber(value)
	return type(value) == 'string' and (tonumber(value, 36) / 1000) or value
end
