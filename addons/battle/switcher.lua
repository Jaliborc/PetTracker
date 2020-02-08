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
local Swap = Addon:NewModule('Switcher', CreateFrame('Frame', ADDON .. 'Switcher', PetBattleFrame, 'ButtonFrameTemplate'))

local Enemy = LE_BATTLE_PET_ENEMY
local Player = LE_BATTLE_PET_ALLY


--[[ Startup ]]--

function Swap:OnEnable()
	self:Hide()
	self:SetSize(840, 424)
	self:SetPoint('CENTER')
	self:NewColumn(Enemy, 'TOPRIGHT', -10)
	self:NewColumn(Player, 'TOPLEFT', 10)
	self.TitleText:SetText(SWITCH_PET)
	self:RegisterEvent('PET_BATTLE_ACTION_SELECTED', function()
		self:Hide()
	end)

	SetPortraitToTexture(self.portrait:GetName(), 'Interface/Icons/INV_Pet_SwapPet')
	self.Close = _G[self:GetName() .. 'CloseButton']

	local oShow = PetBattlePetSelectionFrame_Show
	function PetBattlePetSelectionFrame_Show()
		if Addon.sets.switcher then
			self:Update()
			self:Show()
		else
			oShow()
		end
	end

	local oHide = PetBattlePetSelectionFrame_Hide
	function PetBattlePetSelectionFrame_Hide()
		self:Hide()
		oHide()
	end

	local oFrame = PetBattleFrame.BottomFrame.PetSelectionFrame
	function oFrame:IsShown()
		return Addon.sets.switcher and self:IsShown() or self.IsShown(oFrame)
	end
end

function Swap:NewColumn(owner, ...)
	for i = 1, NUM_BATTLE_PETS_IN_BATTLE do
		self[owner..i] = self:NewSlot(i, ...)
	end

	local border = CreateFrame('Frame', nil, self, ADDON..'SlotBorder')
	border:SetPoint('TOP', self[owner..1], 0, 2)
end

function Swap:NewSlot(i, point, off)
	local f = Addon.PetSlot(self.Inset)
	f:SetPoint(point, off, 101 - 108 * i)
	f:SetScript('OnClick', function()
		if f.pet:Swap() then
			self:Hide()
		end
	end)

	return f
end


--[[ Update ]]--

function Swap:Update()
	self:UpdateFor(Player, Enemy)
	self:UpdateFor(Enemy, Player)
	self.Close:SetEnabled(Addon.Battle:IsPvE() and Addon.Battle:GetCurrent(Player):IsAlive())
end

function Swap:UpdateFor(owner, target)
	local targetType = Addon.Battle:GetCurrent(target):GetType()

	for i = 1, NUM_BATTLE_PETS_IN_BATTLE do
		local pet = Addon.Battle(owner, i)
		local slot = self[owner .. i]

		slot:Display(pet:Exists() and pet, targetType)
		slot.pet = pet
	end
end
