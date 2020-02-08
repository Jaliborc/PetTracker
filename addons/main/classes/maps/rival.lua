--[[
	rival.lua
		Pin marking a rival location
--]]

local ADDON, Addon = ...
local Pin = Addon.Pin:NewClass('RivalPin', nil, 'EncounterJournalPinTemplate')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

function Pin:New(...)
	local b = self:Super(Pin):New(...)
	b:SetScript('OnClick', b:GetClass().OnClick)
	b.FrameLevel = 'PIN_FRAME_LEVEL_ENCOUNTER'
	return b
end

function Pin:Display(rival)
  SetPortraitTextureFromCreatureDisplayID(self.Background, rival.model)
	self.Background:SetDesaturated(IsQuestFlaggedCompleted(rival.quest))
  self.rival = rival
end

function Pin:OnClick()
	self.rival:Display()
end

function Pin:OnTooltip(tip)
	tip:AddHeader(self.rival.name)
	tip:AddLine(L.PetBattle)

	for i, pet in ipairs(self.rival) do
		local icon = format('|T%s:16:16:-3:0:128:256:60:100:130:170:255:255:255|t', pet:GetTypeIcon())
		local r,g,b = pet:GetColor()

		tip:AddLine(icon .. pet:GetName() .. ' (' .. pet:GetLevel() .. ')', r,g,b)
	end
end
