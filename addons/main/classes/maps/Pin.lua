--[[
	pin.lua
		Class that defines common pin behavior
--]]

local ADDON, Addon = ...
local Pin = Addon.Base:NewClass('Pin', 'Button')

function Pin:New(...)
	local b = self:Super(Pin):New(...)
	b:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
	b.FrameLevel = 'PIN_FRAME_LEVEL_DIG_SITE'
	b.Icon = self:CreateTexture(nil, 'ARTWORK')
	b.Icon:SetPoint('CENTER')
	return b
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
	self:SetFrameLevel(levelmanager:GetValidFrameLevel(self.FrameLevel)+index)
	return self
end

function Pin:Reset()
	self:Super(Pin):Reset()
	self:Hide()
end
