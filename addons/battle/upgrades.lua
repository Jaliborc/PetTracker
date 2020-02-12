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
if true then return end
local MODULE =  ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local Upgrade = Addon:NewModule('Upgrades', LibStub('Sushi-3.1').Glowbox(PetBattleFrame))
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)


--[[ Startup ]]--

function Upgrade:OnEnable()
	self:SetPoint('TOP', PetBattleFrame.ActiveEnemy.Icon, 'BOTTOM', 0, -20)
	self:SetText(L.UpgradeAlert)
	self:SetFrameStrata('HIGH')
	self:SetDirection('TOP')
  self.Bangs = {}

	self:RegisterEvent('PET_BATTLE_CLOSE', 'Reset')
	self:RegisterSignal('COLLECTION_CHANGED', 'UpdateAll')
	self:SetCall('OnClose', function() self.canShow = nil end)
  self:Reset()

	hooksecurefunc('PetBattleUnitFrame_UpdateDisplay', function(p) self:UpdateBang(p) end)
	hooksecurefunc('PetBattleFrame_Display', function() self:UpdateAll() end)
end

function Upgrade:Reset()
	self.canShow, self.canPopup = true, true
end


--[[ Update ]]--

function Upgrade:UpdateAll()
	local upgrades = Addon.Battle:AnyUpgrade()
	for parent in pairs(self.Bangs) do
    self:UpdateBang(parent)
	end

	if not upgrades and self.canPopup and Addon.sets.promptForfeit and Addon.Battle:IsWildBattle() then
		self.canPopup = nil
		LibStub('Sushi-3.1').Popup {
        text = L.AskForfeit,
        button1 = QUIT, button2 = NO,
        OnAccept = C_PetBattles.ForfeitGame,
        timeout = 0, exclusive = 1, hideOnEscape = 1,
        whileDead = false, showAlert = true,
    }
	end

  self:SetShown(upgrades and self.canShow and Addon.sets.alertUpgrades)
end

function Upgrade:UpdateBang(parent)
	local pet = Addon.Battle(parent.petOwner, parent.petIndex)
  local bang = self.Bangs[parent]
	if bang then
    bang:SetShown(not pet:IsAlly() and pet:IsUpgrade())
  end
end

function Upgrade:GetBang(parent)
	return self.Bangs[parent] or self:NewBang(parent)
end

function Upgrade:NewBang(parent)
	local size = max(parent.Icon:GetHeight() / 2.5, 18)
	local bang = parent:CreateTexture(nil, 'OVERLAY')
	bang:SetTexture('Interface/GossipFrame/AvailableQuestIcon')
	bang:SetPoint('TOP', parent.Icon, 'TOPRIGHT', -2, -10)
	bang:SetSize(size, size)

	self.Bangs[parent] = bang
	return bang
end
