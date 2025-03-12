--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local MODULE =  ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local Alerts = Addon:NewModule('Alerts', LibStub('Sushi-3.2').Glowbox(PetBattleFrame))
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

function Alerts:OnLoad()
	self:RegisterEvent('PET_BATTLE_CLOSE', 'Reset')
	self:RegisterSignal('BATTLE_STARTED', 'Verify')
	self:RegisterSignal('COLLECTION_CHANGED', 'Verify')
	self:SetPoint('TOP', PetBattleFrame.ActiveEnemy.Icon, 'BOTTOM', 0, -20)
	self:SetCall('OnClose', function() self.shown = true end)
	self:SetText(L.UpgradeAlert)
	self:SetFrameStrata('HIGH')
	self:SetDirection('TOP')
end

function Alerts:Verify()
	local upgrades = Addon.Battle:AnyUpgrade()
	if not upgrades and Addon.Battle:IsWildBattle() and not self.popped and Addon.sets.forfeit then
		self.popped = true

		LibStub('Sushi-3.2').Popup {
			text = L.AskForfeit, button1 = QUIT, button2 = NO,
			OnAccept = C_PetBattles.ForfeitGame
    	}
	end

	self:SetShown(upgrades and not self.shown and Addon.sets.alertUpgrades)
end

function Alerts:Reset()
	self.shown, self.popped = nil
end
