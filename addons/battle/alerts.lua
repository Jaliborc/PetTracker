--[[
Copyright 2012-2026 João Cardoso
All Rights Reserved
--]]

local Addon = _G[(...):match('[^_]+')]
local L = LibStub('AceLocale-3.0'):GetLocale('PetTracker')
local Alerts = Addon:NewModule('Alerts', LibStub('Sushi-3.2').Glowbox(PetBattleFrame, L.UpgradeAlert, 'TOP'))

function Alerts:OnLoad()
	self:RegisterEvent('PET_BATTLE_CLOSE', 'Reset')
	self:RegisterSignal('BATTLE_STARTED', 'Verify')
	self:RegisterSignal('COLLECTION_CHANGED', 'Verify')
	self:SetPoint('TOP', PetBattleFrame.ActiveEnemy.Icon, 'BOTTOM', 0, -20)
	self:SetFrameStrata('HIGH')
	self:SetCall('OnClose', function()
		PlaySound(SOUNDKIT.IG_MAINMENU_CLOSE)
		self.shown = true
	end)
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
