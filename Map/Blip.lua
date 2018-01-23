--[[
Copyright 2012-2017 João Cardoso
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

local ADDON, Addon = ...
local Blip = Addon:NewClass('Button', 'Blip')
local Drop = CreateFrame('Frame', ADDON..'BlipDrop', nil, 'UIDropDownMenuTemplate')

Drop.point, Drop.relativePoint = 'TOP', 'BOTTOM'
Blip.Drop = Drop


--[[ Events ]]--

function Blip:OnCreate()
	self:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
	self:SetScript('OnClick', self.OnClick)

	self.icon = self:CreateTexture(nil, 'ARTWORK')
	self.icon:SetAllPoints(true)
end

function Blip:OnRelease()
	self:Hide()
end

function Blip:OnClick(button)
	if button == 'RightButton' then
		self:ShowDrop()
	elseif self.ShowJournal then
		self:ShowJournal()
	end
end


--[[ Dropdown ]]--

function Blip:ShowDrop()
	self.lines = {}
	self:AddLine(self:GetTooltip(), true)

	if self.ShowJournal then
		self:AddLine('ShowJournal')
	end

	if IsAddOnLoaded('TomTom') then
		self:AddLine('AddWaypoint')
	end

	if #self.lines > 1 then
		EasyMenu(self.lines, Drop, self, 0, 0)
	end
end

function Blip:AddWaypoint()
	TomTom:AddMFWaypoint(GetCurrentMapAreaID(), 0, self.x, self.y)
end

function Blip:AddLine(key, isTitle)
	tinsert(self.lines, {
		text = Addon.Locals[key] or key,
		notCheckable = 1,
		isTitle = isTitle,
		func = function()
			self[key](self)
		end
	})
end