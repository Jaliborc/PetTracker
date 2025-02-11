--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
local Pin = Addon.Pin:NewClass('RivalPin', nil, 'EncounterJournalPinTemplate')
Pin.FrameLevel = 'PIN_FRAME_LEVEL_ENCOUNTER'


--[[ Overrides ]]--

function Pin:Construct()
	local b = self:Super(Pin):Construct()
	b.DefeatedOverlay:Hide()
	b:SetScript('OnClick', b:GetClass().OnClick)
	b:Show()
	return b
end

function Pin:New(frame, index, x,y, rival)
	local b = self:Super(Pin):New(frame, index, x,y)
  SetPortraitTextureFromCreatureDisplayID(b.Background, rival.model)
	b.Background:SetDesaturated(rival:IsCompleted())
  b.rival = rival
	return b
end

function Pin:SetCanvasScale(scale)
	self:Super(Pin):SetCanvasScale(scale * 0.8)
end


--[[ Interaction ]]--

function Pin:OnClick()
	self.rival:Display()
end

function Pin:OnTooltip(tip)
	tip:AddHeader(self.rival.name)
	tip:AddLine(L.Source5)

	for i, pet in ipairs(self.rival) do
		local icon = format('|T%s:16:16:-3:0:128:256:60:100:130:170:255:255:255|t', pet:GetTypeIcon())
		local r,g,b = pet:GetColor():GetRGB()

		tip:AddLine(icon .. pet:GetName() .. ' (' .. pet:GetLevel() .. ')', r,g,b)
	end
end
