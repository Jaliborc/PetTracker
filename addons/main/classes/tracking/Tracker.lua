--[[
Copyright 2012-2025 João Cardoso
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

	f.Lines, f.MaxEntries = {}, 30
	f.Bar = Addon.ProgressBar(f)
	f.Bar:SetScript('OnMouseDown', f.Menu)
	f.Bar:SetPoint('TOPLEFT')
	f.Bar.yOff = -10
	return f
end

function Tracker:Menu()
	MenuUtil.CreateContextMenu(self, function(_, drop)
		drop:SetTag('PETTRACKER_ZONE')
		drop:CreateTitle('|TInterface/Addons/PetTracker/art/compass:16:16|t PetTracker')
		drop:CreateCheckbox(L.ZoneTracker, Addon.GetOption, Addon.ToggleOption, 'zoneTracker')
		drop:CreateCheckbox(L.CapturedPets, Addon.GetOption, Addon.ToggleOption, 'capturedPets')

		local get = function(v) return Addon.sets.targetQuality == v end
		local set = function(v) Addon.SetOption('targetQuality', v) end

		local target = drop:CreateButton(L.DisplayCondition)
		target:CreateRadio(ALWAYS, get, set, Addon.MaxQuality)
		target:CreateRadio(L.MissingRares, get, set, Addon.MaxPlayerQuality)
		target:CreateRadio(L.MissingPets, get, set, 1)
	end)
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
	self:SetHeight(#self.Lines * 19 + 65)
end


function Tracker:AddSpecie(specie, quality, level)
	local source = specie:GetSourceIcon()
	if source then
		local name, icon = specie:GetInfo()
		local text = name .. (level > 0 and format(' (%s)', level) or '')
		local r,g,b = self:GetColor(quality):GetRGB()
		local anchor = self.Lines[#self.Lines] or self.Bar
		
		local line = Addon.SpecieLine(self, text, icon, source, r,g,b)
		line:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT', anchor.xOff or 0, anchor.yOff or -4)
		line:SetScript('OnClick', function() specie:Display() end)

		tinsert(self.Lines, line)
	end
end

function Tracker:Clear()
	for i, line in ipairs(self.Lines) do
		line:Release()
	end
	wipe(self.Lines)
end


--[[ Values ]]--

function Tracker:MaxQuality()
	return Addon.sets.capturedPets and Addon.MaxQuality or 0
end

function Tracker:GetColor(quality)
	return Addon.sets.capturedPets and Addon:GetColor(quality) or WHITE_FONT_COLOR
end