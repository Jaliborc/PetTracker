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


--[[ Startup ]]--

function Swap:OnEnable()
	self:RegisterEvent('PET_BATTLE_ACTION_SELECTED', 'Hide')
	self:NewColumn(LE_BATTLE_PET_ENEMY, 'TOPRIGHT', -10)
	self:NewColumn(LE_BATTLE_PET_ALLY, 'TOPLEFT', 10)
	self:SetPoint('CENTER')
	self:SetSize(840, 424)
	self:Hide()

	SetPortraitToTexture(self.portrait:GetName(), 'Interface/Icons/INV_Pet_SwapPet')
	self.Close = _G[self:GetName() .. 'CloseButton']
	self.TitleText:SetText(SWITCH_PET)

	local oShow = PetBattlePetSelectionFrame_Show
	function PetBattlePetSelectionFrame_Show(...)
		if Addon.sets.switcher then
			self:Update()
			self:Show()
		else
			oShow(...)
		end
	end

	local oHide = PetBattlePetSelectionFrame_Hide
	function PetBattlePetSelectionFrame_Hide(...)
		self:Hide()
		oHide(...)
	end

	local oFrame = PetBattleFrame.BottomFrame.PetSelectionFrame
	function oFrame.IsShown(f)
		return Addon.sets.switcher and self:IsShown() or self.IsShown(f)
	end
end

function Swap:NewColumn(owner, point, off)
	for i = 1, NUM_BATTLE_PETS_IN_BATTLE do
		local slot = Addon.BattleSlot(self.Inset)
		slot:SetPoint(point, off, 101 - 108 * i)
		slot:SetScript('OnClick', function()
			if slot.pet:CanSwap() then
				C_PetBattles.ChangePet(slot.pet.index)
			end
		end)

		self[owner..i] = slot
	end

	local border = CreateFrame('Frame', nil, self, ADDON..'SlotBorder')
	border:SetPoint('TOP', self[owner..1], 0, 2)
end


--[[ Update ]]--

function Swap:Update()
	self:UpdateFor(LE_BATTLE_PET_ALLY, LE_BATTLE_PET_ENEMY)
	self:UpdateFor(LE_BATTLE_PET_ENEMY, LE_BATTLE_PET_ALLY)
	self.Close:SetEnabled(Addon.Battle:IsPvE() and Addon.Battle(LE_BATTLE_PET_ALLY):IsAlive())
end

function Swap:UpdateFor(owner, adversary)
	for i = 1, NUM_BATTLE_PETS_IN_BATTLE do
		local pet = Addon.Battle(owner, i)
		local slot = self[owner .. i]

		slot:Display(pet:Exists() and pet, Addon.Battle(adversary))
		slot.pet = pet
	end
end
