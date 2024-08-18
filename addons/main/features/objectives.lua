--[[
Copyright 2012-2024 João Cardoso
All Rights Reserved
--]]

if C_AddOns.IsAddOnLoaded('Carbonite.Quests') then
	return
end

local ADDON, Addon = ...
local Objectives = Addon:NewModule('Objectives', Addon.Tracker())

function Objectives:OnEnable()
	self.Module = Mixin(CreateFrame('Frame', nil, nil, 'ObjectiveTrackerModuleTemplate'), {uiOrder = 188, blockOffsetX = 15})
	self.Module.Header:SetScript('OnMouseDown', function() self.ToggleDropdown(self.Module.Header) end)
	self.Module:SetHeader(PETS)
	self.Module.LayoutContents = function()
		if Addon.sets.zoneTracker and self:IsShown() then
			self.height = self:GetHeight()
			self.Module:AddBlock(self)
		end
	end

	self:SetParent(self.Module)
	ObjectiveTrackerFrame:AddModule(self.Module)
end

function Objectives:Update()
	if Addon.sets.zoneTracker then
		self:GetClass().Update(self)
	end
	self.Module:MarkDirty()
end