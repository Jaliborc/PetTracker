--[[
Copyright 2012-2024 João Cardoso
All Rights Reserved
--]]

if C_AddOns.IsAddOnLoaded('Carbonite.Quests') then
	return
end

local ADDON, Addon = ...
local Objectives = Addon:NewModule('Objectives', Addon.Tracker())

function Objectives:OnLoad()
	self.Module = Mixin(CreateFrame('Frame', nil, nil, 'ObjectiveTrackerModuleTemplate'), {uiOrder = 188, blockOffsetX = 15})
	self.Module.Header:SetScript('OnMouseDown', self.Menu)
	self.Module:SetHeader(PETS)
	
	self.Module.IsComplete = nop
	self.Module.LayoutContents = function()
		if Addon.sets.zoneTracker then
			self.MaxEntries = floor((self.Module.availableHeight - 103) / 19)
			self:GetClass().Update(self)

			if self:IsShown() and not self.Bar:IsMaximized() then
				self.height = self:GetHeight()
				self.Module:AddBlock(self)
			end
		end
	end

	self:SetParent(self.Module)
	ObjectiveTrackerFrame:AddModule(self.Module)
end

function Objectives:Update()
	self.Module:MarkDirty()
end