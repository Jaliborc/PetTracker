--[[
Copyright 2012-2024 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local Tracker = Addon.Base:NewClass('Tracker', 'Frame')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)


--[[ Construct ]]--

function Tracker:Construct()
	local f = self:Super(Tracker):Construct()
	f:RegisterEvent('ZONE_CHANGED_NEW_AREA', 'Update')
	f:RegisterSignal('COLLECTION_CHANGED', 'Update')
	f:RegisterSignal('OPTIONS_CHANGED', 'Update')
	f:SetScript('OnShow', f.Update)
	f:SetScript('OnHide', f.Clear)
	f:SetSize(1,235)

	f.Lines, f.MaxEntries = {}, 20
	f.Bar = Addon.ProgressBar(f)
	f.Bar:SetPoint('TOPLEFT')
	f.Bar.yOff = -10
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
				if #self.Lines < self.MaxEntries then
					self:AddSpecie(specie, quality, level)
				else
					break
				end
			end
		end
	end

	self.Bar:SetProgress(progress)
	self:SetShown(progress.total > 0)
	self:SetHeight(#self.Lines * 20 + 65)
end


function Tracker:AddSpecie(specie, quality, level)
	local source = specie:GetSourceIcon()
	if source then
		local name, icon = specie:GetInfo()
		local text = name .. (level > 0 and format(' (%s)', level) or '')
		local r,g,b = self:GetColor(quality):GetRGB()
		local anchor = self.Lines[#self.Lines] or self.Bar
		
		local line = Addon.SpecieLine(self, text, icon, source, r,g,b)
		line:SetScript('OnClick', function() specie:Display() end)
		line:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT', anchor.xOff or 0, anchor.yOff or -4)

		tinsert(self.Lines, line)
	end
end

function Tracker:Clear()
	for i, line in ipairs(self.Lines) do
		line:Release()
	end
	wipe(self.Lines)
end


--[[ Dropdown ]]--

function Tracker:ToggleDropdown()
	local drop = LibStub('Sushi-3.2').Dropdown:Toggle(self)
	if drop then
		drop:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 5, -12)
		drop:SetChildren {
			{
				text = L.ZoneTracker, 
				icon = 'Interface/Addons/PetTracker/art/compass',
				isTitle = true
			},
			{
				text = L.TrackPets,
				checked = Addon.sets.zoneTracker,
				func = Tracker.Toggle,
				isNotRadio = true
			},
			{
				text = L.CapturedPets,
				checked = Addon.sets.capturedPets,
				func = Tracker.ToggleCaptured,
				isNotRadio = true
			},
			{
				text = L.DisplayCondition,
				notCheckable = true,
				sublevel = function(self)
					self:Add {
						{
							text = ALWAYS, quality = Addon.MaxQuality,
							checked = Addon.sets.targetQuality == Addon.MaxQuality,
							func = Tracker.SetGoal
						},
						{
							text = L.MissingRares, quality = Addon.MaxPlayerQuality,
							checked = Addon.sets.targetQuality == Addon.MaxPlayerQuality,
							func = Tracker.SetGoal
						},
						{
							text = L.MissingPets, quality = 1,
							checked = Addon.sets.targetQuality == 1,
							func = Tracker.SetGoal
						}
					}
				end
			}
		}
	end
end

function Tracker:Toggle()
	Addon.sets.zoneTracker = not Addon.sets.zoneTracker
	Addon:SendSignal('OPTIONS_CHANGED')
end

function Tracker:ToggleCaptured()
	Addon.sets.capturedPets = not Addon.sets.capturedPets
	Addon:SendSignal('OPTIONS_CHANGED')
end

function Tracker:SetGoal()
	Addon.sets.targetQuality = self.quality
	Addon:SendSignal('OPTIONS_CHANGED')
end


--[[ Values ]]--

function Tracker:MaxQuality()
	return Addon.sets.capturedPets and Addon.MaxQuality or 0
end

function Tracker:GetColor(quality)
	return Addon.sets.capturedPets and Addon:GetColor(quality) or WHITE_FONT_COLOR
end