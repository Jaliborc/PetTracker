--[[
	tracker.lua
		Displays pet capture progress summary of a given zone
--]]

local ADDON, Addon = ...
local Tracker = Addon.TextList:NewClass('Tracker')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)


--[[ Construct ]]--

function Tracker:New(...)
	local f = self:Super(Tracker):New(...)
	f:SetScript('OnShow', f.Update)
	f:SetScript('OnHide', f.Clear)
	f:SetSize(1,1)

	f.Anchor = Addon.ProgressBar(self)
	f.Anchor.yOff = -10
	f.MaxEntries = 0
	return f
end


--[[ Update ]]--

function Tracker:Update()
	self:Clear()
	self:AddSpecies()
end

function Tracker:AddSpecies()
	local progress = Journal:GetCurrentProgress()

	for quality = 0, self:MaxQuality() do
		for level = 0, Addon.MaxLevel do
			for i, specie in ipairs(progress[quality][level] or {}) do
				if self:Count() < self.MaxEntries then
					self:AddSpecie(specie, quality, level)
				else
					break
				end
			end
		end
	end

	self.Anchor:SetProgress(progress)
	self:SetHeight(self:Count() * 20 + 65)
end


function Tracker:AddSpecie(specie, quality, level)
	local sourceIcon = Journal:GetSourceIcon(specie)
	if sourceIcon then
		local name, icon = Journal:GetInfo(specie)
		local text = name .. (level > 0 and format(' (%s)', level) or '')
		local r,g,b = self:GetColor(quality)

		local line = self:Add(text, icon, sourceIcon)
		line:SetScript('OnClick', function() Journal:Display(specie) end)
		line:SetScript('OnEnter', function() line.Text:SetTextColor(r,g,b) end)
		line:SetScript('OnLeave', function() line.Text:SetTextColor(r-.2, g-.2, b-.2) end)
		line:ExecuteScript('OnLeave')
	end
end


--[[ Values ]]--

function Tracker:MaxQuality()
	return Addon.sets.capturedPets and Addon.MaxQuality or 0
end

function Tracker:GetColor(quality)
	if Addon.sets.capturedPets then
		return Addon.Utils:GetColor(quality)
	end
	return 1,1,1, HIGHLIGHT_FONT_COLOR_CODE:sub(3)
end


--[[ Dropdown ]]--

function Tracker:ToggleDropdown()
	--SushiDropFrame:Toggle('TOPLEFT', self, 'BOTTOMLEFT', 5, -12, true, Tracker.ShowOptions)

	self:AddLine {
		text = 'Battle Pets',
		isTitle = true,
		notCheckable = true
	}

	self:AddLine {
		text = L.TrackPets,
		checked = not Addon.sets.hideTracker,
		func = function() Tracker:Toggle() end,
		isNotRadio = true
	}

	self:AddLine {
		text = L.CapturedPets,
		checked = Addon.sets.capturedPets,
		isNotRadio = true,
		func = function()
			Addon.sets.capturedPets = not Addon.sets.capturedPets
			Addon:SendSignal('TRACKING_CHANGED')
		end
	}
end

function Tracker:Toggle()
	Addon.sets.hideTracker = not Addon.sets.hideTracker
	Addon:SendSignal('TRACKING_CHANGED')
end
