--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local MODULE =  ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local Toggle = Addon:NewModule('TrackToggle', CreateFrame('CheckButton', ADDON .. 'TrackToggle', PetJournal, 'InterfaceOptionsCheckButtonTemplate'))

function Toggle:OnLoad()
	self:Update()
	self:SetScript('OnClick', self.OnClick)
	self:RegisterSignal('OPTIONS_CHANGED', 'Update')
	self.Text:SetText(LibStub('AceLocale-3.0'):GetLocale(ADDON).ZoneTracker)
	self:SetPoint('RIGHT', CollectMeOpen2Button or PetJournalFindBattle, 'LEFT', -self.Text:GetWidth() - 15, -1)
end

function Toggle:OnClick()
	Addon.sets.zoneTracker = self:GetChecked()
	Addon:SendSignal('OPTIONS_CHANGED')
end

function Toggle:Update()
	self:SetChecked(Addon.sets.zoneTracker)
end
