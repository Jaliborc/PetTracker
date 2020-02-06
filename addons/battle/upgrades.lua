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

local Addon = PetTracker
local Upgrade = Addon:NewModule('Upgrades', SushiGlowBox(PetBattleFrame))
local Bangs = {}

local EnemyIcon = PetBattleFrame.ActiveEnemy.Icon
local L, Battle = Addon.Locals, Addon.Battle

StaticPopupDialogs['PetTracker: Forfeit'] = {
    text = L.AskForfeit,
    button1 = QUIT,
    button2 = NO,
    OnAccept = C_PetBattles.ForfeitGame,
    timeout = 0, exclusive = 1,
    whileDead = false, showAlert = true,
    hideOnEscape = 1, preferredIndex = 3
}


--[[ Startup ]]--

function Upgrade:Startup()
	self:SetPoint('TOP', EnemyIcon, 'BOTTOM', 0, -20)
	self:SetText(L.UpgradeAlert)
	self:SetFrameStrata('HIGH')
	self:SetDirection('TOP')
	
	self:RegisterEvent('PET_BATTLE_CLOSE')
	self:SetScript('OnEvent', self.Reset)
	self:Reset()

	self:SetHook('PetBattleFrame_Display', 'ToggleAll')
	self:SetHook('PetBattleUnitFrame_UpdateDisplay', 'ToggleBang')
	self:SetCall('OnClose', function()
		self.canShow = nil
	end)

	LibStub('LibPetJournal-2.0').RegisterCallback(self, 'PetsUpdated', 'ToggleAll')
end

function Upgrade:AddOptions(panel)
	panel:Create('CheckButton', 'AlertUpgrades')
	panel:Create('CheckButton', 'PromptForfeit')
end

function Upgrade:SetHook(target, method)
	hooksecurefunc(target, self[method])
end

function Upgrade:Reset()
	self.canShow, self.canPopup = true, true
end


--[[ Display ]]--

function Upgrade:ToggleAll()
	local any = Battle:AnyUpgrade()
	Upgrade:SetShown(any and Upgrade.canShow and Addon.Sets.AlertUpgrades)

	for frame in pairs(Bangs) do
		PetBattleUnitFrame_UpdateDisplay(frame)
	end

	if not any and Upgrade.canPopup and Addon.Sets.PromptForfeit and Battle:IsWildBattle() then
		Upgrade.canPopup = nil
		StaticPopup_Show('PetTracker: Forfeit')
	end
end

function Upgrade:ToggleBang()
	local pet = Battle:Get(self.petOwner, self.petIndex)
	Upgrade.GetBang(self):SetShown(not pet:IsAlly() and pet:IsUpgrade())
end

function Upgrade:GetBang()
	return Bangs[self] or Upgrade.CreateBang(self)
end

function Upgrade:CreateBang()
	local size = max(self.Icon:GetHeight() / 2.5, 18)
	local bang = self:CreateTexture(nil, 'OVERLAY')
	bang:SetTexture('Interface/GossipFrame/AvailableQuestIcon')
	bang:SetPoint('TOP', self.Icon, 'TOPRIGHT', -2, -10)
	bang:SetSize(size, size)
	
	Bangs[self] = bang
	return bang
end