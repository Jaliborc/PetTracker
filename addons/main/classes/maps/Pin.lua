--[[
	pin.lua
		Class that defines common pin behavior
--]]

local ADDON, Addon = ...
local Pin = Addon.Base:NewClass('Pin', 'Button')

function Pin:Construct()
	local b = self:Super(Pin):Construct()
	b:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
	b.FrameLevel = 'PIN_FRAME_LEVEL_DIG_SITE'
	b.Icon = self:CreateTexture(nil, 'ARTWORK')
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
