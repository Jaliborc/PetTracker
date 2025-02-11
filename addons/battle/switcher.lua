--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local MODULE =  ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local Swap = Addon:NewModule('Switcher', CreateFrame('Frame', ADDON .. 'Switcher', PetBattleFrame, 'ButtonFrameTemplate'))


--[[ Startup ]]--

function Swap:OnLoad()
	self:RegisterEvent('PET_BATTLE_ACTION_SELECTED', 'Hide')
	self:NewColumn(Enum.BattlePetOwner.Enemy, 'TOPRIGHT', -10)
	self:NewColumn(Enum.BattlePetOwner.Ally, 'TOPLEFT', 10)
	self:SetPoint('CENTER')
	self:SetSize(840, 424)
	self:Hide()

	SetPortraitToTexture(self.PortraitContainer.portrait, 'Interface/Icons/INV_Pet_SwapPet')
	self.TitleContainer.TitleText:SetText(SWITCH_PET)
	self.Close = _G[self:GetName() .. 'CloseButton']

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
	self:UpdateFor(Enum.BattlePetOwner.Ally, Enum.BattlePetOwner.Enemy)
	self:UpdateFor(Enum.BattlePetOwner.Enemy, Enum.BattlePetOwner.Ally)
	self.Close:SetEnabled(Addon.Battle:IsPvE() and Addon.Battle(Enum.BattlePetOwner.Ally):IsAlive())
end

function Swap:UpdateFor(owner, adversary)
	for i = 1, NUM_BATTLE_PETS_IN_BATTLE do
		local pet = Addon.Battle(owner, i)
		local slot = self[owner .. i]

		slot:Display(pet:Exists() and pet, Addon.Battle(adversary))
		slot.pet = pet
	end
end
