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
local Tracker = Addon.TextList:NewClass('Tracker')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)


--[[ Construct ]]--

function Tracker:Construct()
	local f = self:Super(Tracker):Construct()
	f:RegisterEvent('ZONE_CHANGED_NEW_AREA', 'Update')
	f:RegisterSignal('COLLECTION_CHANGED', 'Update')
	f:RegisterSignal('OPTIONS_CHANGED', 'Update')
	f:SetScript('OnShow', f.Update)
	f:SetScript('OnHide', f.Clear)
	f:SetSize(1,1)

	f.Anchor = Addon.ProgressBar(f)
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
	local progress = Addon.Maps:GetCurrentProgress()

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
	local source = specie:GetSourceIcon()
	if source then
		local name, icon = specie:GetInfo()
		local text = name .. (level > 0 and format(' (%s)', level) or '')
		local r,g,b = self:GetColor(quality)

		local line = self:Add(text, icon, source, r,g,b)
		line:SetScript('OnClick', function() specie:Display() end)
	end
end


--[[ Values ]]--

function Tracker:MaxQuality()
	return Addon.sets.capturedPets and Addon.MaxQuality or 0
end

function Tracker:GetColor(quality)
	if Addon.sets.capturedPets then
		return Addon:GetColor(quality)
	end
	return 1,1,1, HIGHLIGHT_FONT_COLOR_CODE:sub(3)
end


--[[ Dropdown ]]--

function Tracker:ToggleDropdown()
	local drop = LibStub('Sushi-3.1').Dropdown:Toggle(self)
	if drop then
		drop:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 5, -12)
		drop:SetChildren {
			{
				text = AUCTION_CATEGORY_BATTLE_PETS,
				isTitle = true, notCheckable = true
			},
			{
				text = L.TrackPets,
				checked = Addon.sets.trackPets,
				func = Tracker.Toggle,
				isNotRadio = true,
			},
			{
				text = L.CapturedPets,
				checked = Addon.sets.capturedPets,
				func = Tracker.ToggleCaptured,
				isNotRadio = true,
			}
		}
	end
end

function Tracker:Toggle()
	Addon.sets.trackPets = not Addon.sets.trackPets
	Addon:SendSignal('OPTIONS_CHANGED')
end

function Tracker:ToggleCaptured()
	Addon.sets.capturedPets = not Addon.sets.capturedPets
	Addon:SendSignal('OPTIONS_CHANGED')
end
