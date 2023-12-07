--[[
Copyright 2012-2023 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local C = LibStub('C_Everywhere')
local Addon = LibStub('WildAddon-1.0'):NewAddon(ADDON, Addon, 'MutexDelay-1.0')
Addon.MaxQuality = 6
Addon.MaxLevel = 25


--[[ Events ]]--

function Addon:OnEnable()
	LibStub('LibPetJournal-2.0').RegisterCallback(self, 'PostPetListUpdated', 'OnPetsChanged')
	self:RegisterEvent('PET_BATTLE_OPENING_START', 'OnBattle')
	self.state = PetTracker_State or {}
	self.sets = setmetatable(PetTracker_Sets or {}, {__index = {
		zoneTracker = true, capturedPets = true, specieIcons = true, rivalPortraits = true,
		switcher = true, alertUpgrades = true, forfeit = true,
	}})

	if self.sets.tutorial == 12 then
		(SettingsPanel or InterfaceOptionsFrame):HookScript('OnShow', function()
			C.AddOns.LoadAddOn(ADDON .. '_Config')
		end)
	else
		C.AddOns.LoadAddOn(ADDON .. '_Config')
	end

	PetTracker_Sets, PetTracker_State = self.sets, self.state
	AddonCompartmentFrame:RegisterAddon {
		text = ADDON, keepShownOnClick = true, notCheckable = true,
		icon = 'interface/addons/pettracker/art/compass',
		func = function()
			if C.AddOns.LoadAddOn(ADDON .. '_Config') then
				Addon.Options:Open()
			end
		end
	}
end

function Addon:OnPetsChanged()
	self:Delay(.1, 'SendSignal', 'COLLECTION_CHANGED')
end

function Addon:OnBattle()
	if C.AddOns.LoadAddOn(ADDON .. '_Battle') then
		self:SendSignal('BATTLE_STARTED')
	end
end


--[[ Utility ]]--

function Addon:GetColor(quality)
	return quality > 0 and ITEM_QUALITY_COLORS[quality - 1].color or RED_FONT_COLOR
end
