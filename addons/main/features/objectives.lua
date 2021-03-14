--[[
Copyright 2012-2021 João Cardoso
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

if IsAddOnLoaded('Carbonite.Quests') then
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
	local header = CreateFrame('Button', nil, self, 'ObjectiveTrackerHeaderTemplate')
	header:SetScript('OnClick', self.ToggleDropdown)
	header:RegisterForClicks('anyUp')
	header:SetPoint('TOPLEFT')
	header:Show()
	header.Text:SetText(PETS)
	header.MinimizeButton:Hide()

	self.Bar:SetPoint('TOPLEFT', header, 'BOTTOMLEFT', -4, -10)
	self.Bar:SetScript('OnMouseDown', self.ToggleOptions)
	self.Header = header

	hooksecurefunc('ObjectiveTracker_Update', function()
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
	self:SetShown(Addon.sets.trackPets)
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
