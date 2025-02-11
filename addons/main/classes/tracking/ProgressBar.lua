--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local Bar = Addon.Base:NewClass('ProgressBar', 'Frame', true)

function Bar:New(...)
	local f = self:Super(Bar):New(...)
	f.Overlay:SetFrameLevel(f:GetFrameLevel() + Addon.MaxQuality + 1)
	f.Bars = {}

	for i = 1, Addon.MaxQuality do
		local r,g,b = Addon:GetColor(i):GetRGB()
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
end

function Bar:IsMaximized()
	local criteria = self.Bars[Addon.sets.targetQuality]
	local max = select(2, criteria:GetMinMaxValues())
	return max == 0 or criteria:GetValue() == max
end
