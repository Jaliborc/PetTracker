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
local Tracker = Addon:NewClass('Frame', 'Tracker', nil, Addon.List)
local Journal = Addon.Journal


--[[ Startup ]]--

function Tracker:OnCreate()
	self:SetScript('OnShow', self.Update)
	self:SetScript('OnHide', self.Reset)
	self:SetSize(1,1)

	self.Anchor = Addon.ProgressBar(self)
	self.Anchor.yOff = -10
	self.maxEntries = 0

	self.__super.OnCreate(self)
end


--[[ Display ]]--

function Tracker:Update()
	self:Reset()
	self:AddSpecies()
end

function Tracker:AddSpecies()
	local progress = Journal:GetCurrentProgress()

	for quality = 0, self:MaxQuality() do
		for level = 0, Addon.MaxLevel do
			for i, specie in ipairs(progress[quality][level] or {}) do
				if self:Count() < self.maxEntries then
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
		local r,g,b = self:GetColor(quality)
		
		local line = self:NewLine()
		line.Text:SetText(name .. (level > 0 and format(' (%s)', level) or ''))
		line.Text:SetWidth(self.Anchor:GetWidth())
		line.SubIcon:SetTexture(sourceIcon)
		line.Icon:SetTexture(icon)
		line:SetScript('OnClick', function()
			Journal:Display(specie)
		end)

		line:SetScript('OnEnter', function()
			line.Text:SetTextColor(r, g, b)
		end)

		line:SetScript('OnLeave', function()
			line.Text:SetTextColor(r-.2, g-.2, b-.2)
		end)

		line:GetScript('OnLeave')(line)
	end
end


--[[ Interaction ]]--

function Tracker:ToggleOptions()
	SushiDropFrame:Toggle('TOPLEFT', self, 'BOTTOMLEFT', 5, -12, true, Tracker.ShowOptions)
end

function Tracker:ShowOptions()
	self:AddLine {
		text = 'Battle Pets',
		isTitle = true,
		notCheckable = true
	}

	self:AddLine {
		text = Addon.Locals.TrackPets,
		checked = not Addon.Sets.HideTracker,
		func = function() Tracker:Toggle() end,
		isNotRadio = true
	}

	self:AddLine {
		text = Addon.Locals.CapturedPets,
		checked = Addon.Sets.CapturedPets,
		isNotRadio = true,
		func = function()
			Addon.Sets.CapturedPets = not Addon.Sets.CapturedPets
			Addon:ForAllModules('TrackingChanged')
		end
	}
end

function Tracker:Toggle()
	Addon.Sets.HideTracker = not Addon.Sets.HideTracker
	Addon:ForAllModules('TrackingChanged')
end


--[[ Values ]]--

function Tracker:MaxQuality()
	return Addon.Sets.CapturedPets and Addon.MaxQuality or 0
end

function Tracker:GetColor(quality)
	if Addon.Sets.CapturedPets then
		return Addon.GetQualityColor(quality)
	end
	return 1,1,1, HIGHLIGHT_FONT_COLOR_CODE:sub(3)
end