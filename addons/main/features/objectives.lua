--[[
	Copyright 2012-2026 João Cardoso
	All Rights Reserved
--]]

local ADDON, Addon = ...
local Objectives = Addon:NewModule('Objectives', Addon.Tracker(ObjectiveTrackerFrame or WatchFrame), 'MutexDelay-1.0')


--[[ Classic ]]--

if WatchFrame then
	function Objectives:OnLoad()
		local header = Addon.SpecieLine(self, PETS, nil,nil, NORMAL_FONT_COLOR:GetRGB())
		header:SetScript('OnClick', self.ToggleMenu)
		header.Text:SetPoint('LEFT')

		self.Header = header
		self:SetPoint('TOPLEFT', header, 'BOTTOMLEFT', 3, -3)
		self:RegisterSignal('OPTIONS_CHANGED', WatchFrame_Update)

		WatchFrame_AddObjectiveHandler(function(parent, anchor, _, width)
			if Addon.sets.zoneTracker then
				local point = anchor and 'BOTTOMLEFT' or 'TOPLEFT'
				local at = anchor or self:GetParent()
		
				self.Header:SetPoint('TOPLEFT', at, point, 2, -4)
				self.Bar:SetWidth(width - 5)
				self:SetParent(parent)
				self:Update()
			end

			local count = #self.Lines
			local active = count > 0 and Addon.sets.zoneTracker
			self:SetShown(active)

			return active and self.Lines[count] or anchor, 0, count, 0
		end)

		Menu.ModifyMenu('MENU_WATCH_FRAME_HEADER', function(_, drop) self.CreateMenu(drop) end)
	end

	return
end


--[[ Retail ]]--

function Objectives:OnLoad()
	local header = CreateFrame('Frame', nil, self:GetParent(), 'ObjectiveTrackerModuleHeaderTemplate')
	header.MinimizeButton:SetScript('OnClick', function() self:Toggle() end)
	header:SetScript('OnMouseDown', self.ToggleMenu)
	header:SetPoint('TOPLEFT', self, -15, 35)
	header.Text:SetText(PETS)

	self:RegisterSignal('OPTIONS_CHANGED', 'Layout')
	self.Header = header

	hooksecurefunc(ObjectiveTrackerContainerMixin, 'Update', function()
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

	if self:IsVisible() then
		self:Delay(5, 'Layout') -- reliancy fallback, in case of blizzard code changes
	end
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