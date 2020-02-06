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

local ADDON, Addon = ...
local Progress = Addon:NewClass('Frame', 'ProgressBar', ADDON..'ProgressBar')
local Format = PLAYERS_FOUND_OUT_OF_MAX


--[[ Constructor ]]--

function Progress:OnCreate()
	self.Overlay:SetFrameLevel(self:GetFrameLevel() + Addon.MaxQuality + 1)
	self.Bars = {}

	for i = 1, Addon.MaxQuality do
		self.Bars[i] = self:CreateBar(i)
	end
end

function Progress:CreateBar(i)
	local r, g, b = Addon.GetQualityColor(i)
	local bar = CreateFrame('StatusBar', nil, self)
	bar:SetStatusBarTexture('Interface/TargetingFrame/UI-StatusBar')
	bar:SetFrameLevel(self:GetFrameLevel() + i)
	bar:SetStatusBarColor(r, g, b)
	bar:SetAllPoints()

	return bar
end


--[[ API ]]--

function Progress:SetProgress(progress)
	local owned = 0

	for i = Addon.MaxQuality, 1, -1 do
		owned = owned + progress[i].total

		self.Bars[i]:SetMinMaxValues(0, progress.total)
		self.Bars[i]:SetValue(owned)
	end

	self.Overlay.Text:SetFormattedText(Format, owned, progress.total)
	self:SetShown(progress.total > 0)
end
