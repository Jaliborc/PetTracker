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

local ADDON, Addon = ...
local ActionBar = PetBattleFrame.BottomFrame
local Actions = Addon:NewModule('EnemyActions', CreateFrame('CheckButton', ADDON .. 'EnemyActions', ActionBar))
Actions:SetPoint('BOTTOM', ActionBar, 'TOP', 0, 30)
Actions:SetMovable(true)

local Ability = Addon.AbilityAction
local Pets = Addon.Battle

local Enemy = LE_BATTLE_PET_ENEMY
local Player = LE_BATTLE_PET_ALLY


--[[ Startup ]]--

function Actions:Startup()
	self:SetSize(175, 55)
	self:SetScale(.8)
	self.buttons = {}

	for i = 1, 6 do
		self.buttons[i] = self:CreateButton(i)
	end

	self:RegisterEvent('PET_BATTLE_PET_CHANGED')
	self:RegisterEvent('PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE')
	self:SetScript('OnEvent', self.Update)

	self:SetHook('PetBattlePetSelectionFrame_Hide', self.Show)
	self:SetHook('PetBattlePetSelectionFrame_Show', self.Hide)
	self:SetScript('OnShow', self.Update)

	self:UpdateLock()
end

function Actions:AddOptions(panel)
	panel:Create('CheckButton', 'UnlockActions'):SetCall('OnInput', function(_, value)
		Addon.Sets.UnlockActions = value
		self:UpdateLock()
	end)
end

function Actions:SetHook(target, hook)
	hooksecurefunc(target, function()
		hook(self)
	end)
end

function Actions:CreateButton(i)
	local y = floor((i-1) / 3)
	local x = (i-1) % 3

	local button = Ability(self)
	button:SetPoint('BOTTOMLEFT', (button:GetWidth() + 10) * x, y * button:GetHeight())
	button:SetScript('OnDragStop', function() self:StopMovingOrSizing() end)
	button:SetScript('OnDragStart', function() self:StartMoving() end)
	button:SetHighlightTexture(nil)
	button:SetPushedTexture(nil)
	button:UnregisterAllEvents()
	button:SetFrameLevel(8-y)
	button:Enable()
	
	return button
end


--[[ Update ]]--

function Actions:Update()
	local enemy = Pets:GetCurrent(Enemy)
	local target = Pets:GetCurrent(Player):GetType()
	
	for i = 1, 6 do
		self.buttons[i]:Display(enemy, i, target)
	end
end

function Actions:UpdateLock()
	for i = 1, 6 do
		self.buttons[i]:RegisterForDrag(Addon.Sets.UnlockActions and 'LeftButton' or nil)
	end
end