--[[
Copyright 2012-2024 João Cardoso
All Rights Reserved
--]]

if LibStub('C_Everywhere').Addons.C_AddOns.IsAddOnLoaded('Carbonite.Quests') then
	return
end

local ADDON, Addon = ...
local Parent, Minimize = ObjectiveTrackerBlocksFrame, ObjectiveTrackerFrame.HeaderMenu
local Objectives = Addon:NewModule('Objectives', Addon.Tracker(Parent))

do
	OBJECTIVE_TRACKER_ADDONS = OBJECTIVE_TRACKER_ADDONS or {}
	tinsert(OBJECTIVE_TRACKER_ADDONS, 0)
	Objectives.Index = #OBJECTIVE_TRACKER_ADDONS
end


--[[ Startup ]]--

function Objectives:OnEnable()
	local header = CreateFrame('Button', 'PetTrackerObjectiveTrackerHeader', self, 'ObjectiveTrackerContainerHeaderTemplate')  -- ObjectiveTrackerHeaderTemplate -> ObjectiveTrackerContainerHeaderTemplate according to https://github.com/Tercioo/World-Quest-Tracker/blob/db15d824fa4ba80e7bcdc30d126e52b001f36dc9/WorldQuestTracker_Tracker.lua#L321 as of 2024 08 17
	header:SetScript('OnClick', self.ToggleDropdown)
	header:RegisterForClicks('anyUp')
	header:SetPoint('TOPLEFT')
	header:Show()
	header.Text:SetText(PETS)
	header.MinimizeButton:Hide()

	self.Bar:SetPoint('TOPLEFT', header, 'BOTTOMLEFT', -4, -10)
	self.Bar:SetScript('OnMouseDown', self.ToggleOptions)
	self.Header = header

	-- broken by 11.0.0: ObjectiveTracker_Update  --> ObjectiveTrackerManager, "UpdateAll"  as per https://github.com/Tercioo/World-Quest-Tracker/blob/db15d824fa4ba80e7bcdc30d126e52b001f36dc9/WorldQuestTracker_Tracker.lua#L1653 on 2024 08 17
	hooksecurefunc(ObjectiveTrackerManager, "UpdateAll", function()
		local off = self:GetUsedHeight()
		local availableEntries = floor(((Parent.maxHeight or 0) - off - 45) / 20)

		if availableEntries ~= self.MaxEntries then
			self.MaxEntries = availableEntries
			self:Update()
		else
			self:UpdateMinimize()
		end

		self:SetPoint('TOPLEFT', Parent, -10, -off)
	end)
end


--[[ API Override ]]--

function Objectives:Update()
	self:SetShown(Addon.sets.zoneTracker)
	self:GetClass().Update(self)
	self:SetShown(self:IsShown() and not self.Bar:IsMaximized())
	self:UpdateMinimize()

	OBJECTIVE_TRACKER_ADDONS[self.Index] = self:IsShown() and self:GetHeight() or 0
end

function Objectives:UpdateMinimize()
	if self:IsShown() and not Minimize:IsShown() then
		Minimize:SetFrameLevel(max(Minimize:GetFrameLevel(), self.Header:GetFrameLevel()+2))
		Minimize:SetPoint('RIGHT', self.Header, 'RIGHT')
		Minimize:Show()
	end
end

function Objectives:GetUsedHeight()
	local height = Parent.contentsHeight or 0
	for i = 1, self.Index-1 do
		height = height + OBJECTIVE_TRACKER_ADDONS[i]
	end

	if height > 0 then
		height = height + 15
	end

	return height
end
