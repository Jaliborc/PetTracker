--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local MODULE =  ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local Bar = Addon:NewModule('EnemyBar', CreateFrame('Frame', nil, PetBattleFrame.BottomFrame))


--[[ Startup ]]--

function Bar:OnLoad()
	PetBattleFrame.BottomFrame.PetSelectionFrame:HookScript('OnShow', function() self:Hide() end)
	PetBattleFrame.BottomFrame.PetSelectionFrame:HookScript('OnHide', function() self:Show() end)

	self.Buttons = {}
	for i = 1,6 do
		self.Buttons[i] = self:NewButton(i)
	end

	self:RegisterSignal('OPTIONS_RESET', 'Reposition')
	self:RegisterEvent('PET_BATTLE_PET_CHANGED', 'Update')
	self:RegisterEvent('PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE', 'Update')
	self:SetScript('OnShow', self.Update)
	self:SetClampedToScreen(true)
	self:SetMovable(true)
	self:SetSize(176, 52)
	self:Reposition()
	self:Update()
end

function Bar:NewButton(i)
	local y = floor((i-1) / 3)
	local x = (i-1) % 3

	local b = Addon.AbilityAction(self)
	b:SetPoint('BOTTOMLEFT', (b:GetWidth() + 10) * x, y * b:GetHeight())
	b:SetScript('OnDragStart', function() self:DragStart() end)
	b:SetScript('OnDragStop', function() self:DragStop() end)
	b:RegisterForDrag('LeftButton')
	b:ClearHighlightTexture()
	b:ClearPushedTexture()
	b:UnregisterAllEvents()
	b:SetFrameLevel(8-y)
	b:Enable()
	return b
end


--[[ API ]]--

function Bar:Update()
	local enemy = Addon.Battle(Enum.BattlePetOwner.Enemy)
	local target = Addon.Battle(Enum.BattlePetOwner.Ally)

	for i, b in ipairs(self.Buttons) do
		b:Display(enemy:GetAbility(i), target)
	end
end

function Bar:Reposition()
	self:SetPoint('BOTTOM', self:GetParent(), 'TOP', Addon.sets.enemyBarX or 0, Addon.sets.enemyBarY or 30)
end

function Bar:DragStart()
	if IsShiftKeyDown() then
		self:StartMoving()
	end
end

function Bar:DragStop()
	Addon.sets.enemyBarX = self:GetCenter() - self:GetParent():GetCenter()
	Addon.sets.enemyBarY =	self:GetBottom() - self:GetParent():GetTop()

	self:StopMovingOrSizing()
end
