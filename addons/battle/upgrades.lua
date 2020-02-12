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
local Upgrade = Addon:NewModule('Upgrades', LibStub('Sushi-3.1').Glowbox(PetBattleFrame))
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)


--[[ Startup ]]--

function Upgrade:OnEnable()
	self.BreedIcons, self.Bangs = {}, {}
	self:SetCall('OnClose', function() self.shown = true end)
	self:SetPoint('TOP', PetBattleFrame.ActiveEnemy.Icon, 'BOTTOM', 0, -20)
	self:SetText(L.UpgradeAlert)
	self:SetFrameStrata('HIGH')
	self:SetDirection('TOP')

	self:RegisterSignal('COLLECTION_CHANGED', 'Update')
	self:RegisterEvent('PET_BATTLE_CLOSE', 'Reset')
  self:Update()

	hooksecurefunc('PetBattleUnitTooltip_UpdateForUnit', function(...) self:UpdateTip(...) end)
	hooksecurefunc('PetBattleUnitFrame_UpdateDisplay', function(...) self:UpdateUnit(...) end)
	hooksecurefunc('PetBattleFrame_Display', function() self:Update() end)
end

function Upgrade:Reset()
	self.shown, self.popped = nil
end


--[[ Update ]]--

function Upgrade:Update()
	local upgrades = Addon.Battle:AnyUpgrade()
	if not upgrades and not self.popped and Addon.sets.promptForfeit and Addon.Battle:IsWildBattle() then
		self.popped = true

		LibStub('Sushi-3.1').Popup {
        text = L.AskForfeit,
        button1 = QUIT, button2 = NO,
        OnAccept = C_PetBattles.ForfeitGame,
        timeout = 0, exclusive = 1, hideOnEscape = 1,
        whileDead = false, showAlert = true,
    }
	end

	for unit in pairs(self.Bangs) do
		self:UpdateUnit(unit)
	end

  self:SetShown(upgrades and not self.shown and Addon.sets.alertUpgrades)
end

function Upgrade:UpdateUnit(unit)
	local pet = Addon.Battle(unit.petOwner, unit.petIndex)
	local better = pet:IsUpgrade()
	if better or self.Bangs[unit] then
    self:GetBang(unit):SetShown()
  end

	if unit.Name and not (unit:GetName() or ''):find('Tooltip') then
		unit.Name:SetText((unit.Name:GetText() or '') .. ' ' .. pet:GetBreedIcon(.8))
	end
end

function Upgrade:UpdateTip(tip, ...)
	local pet = Addon.Battle(...)
	local icon = self.BreedIcons[tip] or tip:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	icon:SetPoint('CENTER', tip.Icon, 'TOPLEFT', 3, -2)
	icon:SetText(pet:GetBreedIcon(.9))

	tip.CollectedText:SetText(pet:GetOwnedText() or NORMAL_FONT_COLOR_CODE .. L.NoneCollected .. FONT_COLOR_CODE_CLOSE)
	self.BreedIcons[tip] = icon
end


--[[ Bangs ]]--

function Upgrade:GetBang(frame)
	return self.Bangs[frame] or self:NewBang(frame)
end

function Upgrade:NewBang(frame)
	local size = max(frame.Icon:GetHeight() / 2.5, 18)
	local bang = frame:CreateTexture(nil, 'OVERLAY')
	bang:SetTexture('Interface/GossipFrame/AvailableQuestIcon')
	bang:SetPoint('TOP', frame.Icon, 'TOPRIGHT', -2, -10)
	bang:SetSize(size, size)

	self.Bangs[frame] = bang
	return bang
end
