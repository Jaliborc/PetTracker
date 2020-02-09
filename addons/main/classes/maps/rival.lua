--[[
	rival.lua
		Pin marking a rival location
--]]

local ADDON, Addon = ...
local Pin = Addon.Pin:NewClass('RivalPin', nil, 'EncounterJournalPinTemplate')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

function Pin:Construct()
	local b = self:Super(Pin):Construct()
	b:SetScript('OnClick', b:GetClass().OnClick)
	b.FrameLevel = 'PIN_FRAME_LEVEL_ENCOUNTER'
	return b
end

function Pin:New(frame, index, x,y, rival)
	local b = self:Super(Pin):New(frame, index, x,y)
  SetPortraitTextureFromCreatureDisplayID(b.Background, rival.model)
	b.Background:SetDesaturated(IsQuestFlaggedCompleted(rival.quest))
  b.Rival = rival
	return b
end

function Pin:OnClick()
	self.Rival:Display()
end

function Pin:OnTooltip(tip)
	tip:AddHeader(self.Rival:GetName())
	tip:AddLine(L.PetBattle)

	for i, pet in ipairs(self.Rival) do
		local icon = format('|T%s:16:16:-3:0:128:256:60:100:130:170:255:255:255|t', pet:GetTypeIcon())
		local r,g,b = pet:GetColor()

		tip:AddLine(icon .. pet:GetName() .. ' (' .. pet:GetLevel() .. ')', r,g,b)
	end
end
