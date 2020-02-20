--[[
Copyright 2012-2020 João Cardoso
PetTracker is distributed under the terms of the GNU General Public License (Version 3).
As a special exception, the copyright holders of this addon do not give permission to
redistribute and/or modify it.

This addon is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the addon. If not, see <http://www.gnu.org/licenses/gpl-3.0.txt>.

This file is part of PetTracker.
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
	local upgrades = Addon.Battle:AnyUpgrade()
	if not upgrades and Addon.Battle:IsWildBattle() and not self.popped and Addon.sets.forfeit then
		self.popped = true

		LibStub('Sushi-3.1').Popup {
				id = ADDON .. 'Alerts',
        text = L.AskForfeit, button1 = QUIT, button2 = NO,
        OnAccept = C_PetBattles.ForfeitGame,
				hideOnEscape = 1,
    }
	end

  self:SetShown(upgrades and not self.shown and Addon.sets.alertUpgrades)
end

function Alerts:Reset()
	self.shown, self.popped = nil
end
