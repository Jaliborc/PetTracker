--[[
Copyright 2012-2023 João Cardoso
All Rights Reserved
--]]

local MODULE =  ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local Alerts = Addon:NewModule('Alerts', LibStub('Sushi-3.1').Glowbox(PetBattleFrame))
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

function Alerts:OnEnable()
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
	local rareUpgrades = Addon.Battle:AnyRareUpgrade()
	if not rareUpgrades and Addon.Battle:IsWildBattle() and not self.popped and Addon.sets.forfeitNoRareUpgrades then
		self.popped = true

		LibStub('Sushi-3.1').Popup {
			id = ADDON .. 'Alerts',
        		text = L.AskForfeit, button1 = "Quit, No Rare Upgrades", button2 = "Stay",
			OnAccept = C_PetBattles.ForfeitGame,
			hideOnEscape = 1,
	    	}
	end
	
	local upgrades = Addon.Battle:AnyUpgrade()
	if not upgrades and Addon.Battle:IsWildBattle() and not self.popped and Addon.sets.forfeit then
		self.popped = true

		LibStub('Sushi-3.1').Popup {
			id = ADDON .. 'Alerts',
        		text = L.AskForfeit, button1 = "Quit, No Upgrades", button2 = "Stay",
        		OnAccept = C_PetBattles.ForfeitGame,
			hideOnEscape = 1,
    		}
	end

	self:SetShown(upgrades and not self.shown and Addon.sets.alertUpgrades)
end

function Alerts:Reset()
	self.shown, self.popped = nil
end
