--[[
Copyright 2012-2019 João Cardoso
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

local ADDON, Addon = 'PetTracker', PetTracker
local OriginalSwap = PetBattleFrame.BottomFrame.PetSelectionFrame
local Swap = Addon:NewModule('Switcher', CreateFrame('Frame', ADDON .. 'Switcher', PetBattleFrame, 'ButtonFrameTemplate'))

local NumPets = NUM_BATTLE_PETS_IN_BATTLE
local NumAbilities = NUM_BATTLE_PET_ABILITIES
local Enemy = LE_BATTLE_PET_ENEMY
local Player = LE_BATTLE_PET_ALLY

local Slot = Addon.BattleSlot
local Battle = Addon.Battle


--[[ Startup ]]--

function Swap:Startup()
	self:Hide()
	self:SetHooks()
	self:RegisterEvent('PET_BATTLE_ACTION_SELECTED')
	self:SetScript('OnEvent', function()
		PetBattlePetSelectionFrame_Hide()
	end)

	SetPortraitToTexture(self.portrait:GetName(), 'Interface/Icons/INV_Pet_SwapPet')
	Addon.EnemyActions.Hide = function() end
end

function Swap:SetHooks()
	function PetBattlePetSelectionFrame_Show()
		self:Initialize()
		self:Update()
		self:Show()
	end

	function PetBattlePetSelectionFrame_Hide()
		self:Hide()
	end

	function OriginalSwap.IsShown()
		return self:IsShown()
	end
end

function Swap:Initialize()
	self:CreateSlotLine(Enemy, 'TOPRIGHT', -10)
	self:CreateSlotLine(Player, 'TOPLEFT', 10)
	self.TitleText:SetText(SWITCH_PET)
	self:SetPoint('CENTER')
	self:SetSize(840, 424)

	self.CreateSlotLine, self.CreateSlot = nil
	self.Initialize = function() end
end


--[[ Create Slots ]]--

function Swap:CreateSlotLine(owner, ...)
	for i = 1, NumPets do
		self[owner..i] = self:CreateSlot(i, ...)
	end

	local border = CreateFrame('Frame', nil, self, ADDON..'SlotBorder')
	border:SetPoint('TOP', self[owner..1], 0, 2)
end

function Swap:CreateSlot(i, point, off)
	local slot = Slot(self.Inset)
	slot:SetPoint(point, off, 101 - 108 * i)
	slot:SetScript('OnClick', function()
		self:OnClick(slot)
	end)

	return slot
end


--[[ Update ]]--

function Swap:Update()
	self:UpdateFor(Player, Enemy)
	self:UpdateFor(Enemy, Player)

	local close = _G[Swap:GetName() .. 'CloseButton']
	local playerPet = Battle:GetCurrent(Player)

	if Battle:IsPvE() and playerPet:IsAlive() then
		close:Enable()
	else
		close:Disable()
	end
end

function Swap:UpdateFor(owner, target)
	target = Battle:GetCurrent(target):GetType()

	for i = 1, NumPets do
		local pet = Battle:Get(owner, i)
		local slot = self[owner .. i]

		slot:Display(pet:Exists() and pet, target)
		slot.pet = pet
	end
end


--[[ Frame Events ]]--

function Swap:OnClick(slot)
	if slot.pet:Swap() then
		self:Hide()
	end
end
