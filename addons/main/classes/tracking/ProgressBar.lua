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
local Bar = Addon.Base:NewClass('ProgressBar', 'Frame', true)

function Bar:New(...)
	local f = self:Super(Bar):New(...)
	f.Overlay:SetFrameLevel(f:GetFrameLevel() + Addon.MaxQuality + 1)
	f.Bars = {}

	for i = 1, Addon.MaxQuality do
		local r,g,b = Addon:GetColor(i)
		local bar = CreateFrame('StatusBar', nil, f)
		bar:SetStatusBarTexture('Interface/TargetingFrame/UI-StatusBar')
		bar:SetFrameLevel(f:GetFrameLevel() + i)
		bar:SetStatusBarColor(r,g,b)
		bar:SetAllPoints()

		f.Bars[i] = bar
	end

	return f
end

function Bar:SetProgress(progress)
	local owned = 0
	for i = Addon.MaxQuality, 1, -1 do
		owned = owned + progress[i].total

		self.Bars[i]:SetMinMaxValues(0, progress.total)
		self.Bars[i]:SetValue(owned)
	end

	self.Overlay.Text:SetFormattedText(PLAYERS_FOUND_OUT_OF_MAX, owned, progress.total)
	self:SetShown(progress.total > 0)
end
