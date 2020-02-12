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
local Bar = Addon:NewModule('EnemyBar', CreateFrame('CheckButton', ADDON .. 'EnemyBar', PetBattleFrame.BottomFrame))
Bar:SetPoint('BOTTOM', PetBattleFrame.BottomFrame, 'TOP', 0, 30)
Bar:SetMovable(true)


--[[ Startup ]]--

function Bar:OnEnable()
	self.buttons = {}
	for i = 1,6 do
		self.buttons[i] = self:NewButton(i)
	end

	self:RegisterEvent('PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE', 'Update')
	self:RegisterEvent('PET_BATTLE_PET_CHANGED', 'Update')
	self:RegisterSignal('OPTIONS_CHANGED', 'UpdateLock')
	self:SetScript('OnShow', self.Update)
	self:SetSize(110, 30)
	self:UpdateLock()
	self:Update()

	PetBattleFrame.BottomFrame.PetSelectionFrame:HookScript('OnShow', function() self:Hide() end)
	PetBattleFrame.BottomFrame.PetSelectionFrame:HookScript('OnHide', function() self:Show() end)
end

function Bar:NewButton(i)
	local y = floor((i-1) / 3)
	local x = (i-1) % 3

	local b = Addon.AbilityButton(self)
	b:SetPoint('BOTTOMLEFT', (b:GetWidth() + 10) * x, y * b:GetHeight())
	b:SetScript('OnDragStop', function() self:StopMovingOrSizing() end)
	b:SetScript('OnDragStart', function() self:StartMoving() end)
	b:SetHighlightTexture(nil)
	b:SetPushedTexture(nil)
	b:UnregisterAllEvents()
	b:SetFrameLevel(8-y)
	b:Enable()
	return b
end


--[[ Update ]]--

function Bar:Update()
	local enemy = Addon.Battle(LE_BATTLE_PET_ENEMY)
	local target = Addon.Battle(LE_BATTLE_PET_ALLY)

	for i, b in ipairs(self.buttons) do
		b:Display(enemy:GetAbility(i), target)
	end
end

function Bar:UpdateLock()
	for i, b in ipairs(self.buttons) do
		b:RegisterForDrag(Addon.sets.unlockActions and 'LeftButton' or nil)
	end
end
