--[[
	Copyright 2012-2025 João Cardoso
	All Rights Reserved
--]]

if C_AddOns.IsAddOnLoaded('Carbonite.Quests') then
	return
end

local ADDON, Addon = ...
local Objectives = Addon:NewModule('Objectives', Addon.Tracker(ObjectiveTrackerFrame))

function Objectives:OnLoad()
	local header = CreateFrame('Frame', nil, self:GetParent(), 'ObjectiveTrackerModuleHeaderTemplate')
	header.MinimizeButton:SetScript('OnClick', function() self:Toggle() end)
	header:SetScript('OnMouseDown', self.Menu)
	header:SetPoint('TOPLEFT', self, -15, 35)
	header.Text:SetText(PETS)

	self:RegisterSignal('OPTIONS_CHANGED', 'Layout')
	self.Header = header

	hooksecurefunc(self:GetParent(), 'Update', function()
		self:Layout()
	end)
end

function Objectives:Layout()
	local new = not self.Header:IsShown()
	local hasContent, offset = self:GetContent()
	local isEnabled = hasContent and not self:GetParent().isCollapsed

	if hasContent then
		self:GetParent():Show()
	end

	if new then
		self.Header:PlayAddAnimation()
	end

	self:SetShown(isEnabled and not self.collapsed)
	self:SetPoint('TOPLEFT', 15, -(offset or 0))
	self.Header:SetShown(isEnabled)
end

function Objectives:GetContent()
	if Addon.sets.zoneTracker then
		local parent = self:GetParent()
		local used = 0

		for i, module in ipairs(parent.modules or {}) do
			local height = module:GetContentsHeight()
			if height > 0 then
				used = used + height + 10
			end
		end

		local free = parent:GetAvailableHeight() - used
		if free >= 103 then
			self.MaxEntries = floor((free - 103) / 19)
			self:Update()

			return not self.Bar:IsMaximized(), used + 73
		end
	end
end

function Objectives:Toggle()
	self.collapsed = not self.collapsed
	self.Header:SetCollapsed(self.collapsed)
	self:Layout()

	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end