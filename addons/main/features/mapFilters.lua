--[[
    Copyright 2012-2025 João Cardoso
    All Rights Reserved
--]]

local ADDON, Addon = ...
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
local Filters = Addon:NewModule('MapFilters')

local function search(box)
    local text = box:GetText()
    if Addon.sets.mapSearch ~= text then
        Addon.SetOption('mapSearch', text)
    end
end

function Filters:OnLoad()
    Menu.ModifyMenu('MENU_WORLD_MAP_TRACKING', function(_, drop)
        drop:CreateDivider()
        drop:CreateTitle('|TInterface/Addons/PetTracker/art/compass:16:16|t PetTracker')
        drop:CreateCheckbox(L.Species, Addon.GetOption, Addon.ToggleOption, 'showSpecies')

        local edit = drop:CreateTemplate('PetTrackerMenuSearch')
        edit:AddInitializer(function(edit)
            edit.Toggle = function() edit:SetShown(Addon.sets.showSpecies) end
            edit:SetSize(100, Addon.sets.showSpecies and 24 or 1)
            edit:HookScript('OnShow', edit.Toggle)
            edit:Toggle() 
            
            edit.Box.Instructions:SetText(L.FilterSpecies)
            edit.Box:HookScript('OnTextChanged', search)
            edit.Box:SetText(Addon.sets.mapSearch or '')
        end)

        drop:CreateCheckbox(STABLES, Addon.GetOption, Addon.ToggleOption, 'showStables')
    end)
end


---- bruteforce-fixing blizzard classic code  (temporary, hopefully)
if not Setup_Dropdown then
    return
end

function Setup_Dropdown(self) -- why is this GLOBAL function for a specific menu just called this!? UH!? what are you doing!?
    self.WorldMapOptionsDropDown:SetWidth(120)
	self.WorldMapOptionsDropDown:SetSelectionText(function()
		return MAP_OPTIONS_TEXT
	end)

    self.WorldMapOptionsDropDown:SetupMenu(function(dropdown, rootDescription)
        rootDescription:SetTag('MENU_WORLD_MAP_TRACKING') -- you forgot this, very important

        --[[local function IsCvarChecked(cvar) this is just local IsCvarChecked = GetCVarBool, with extra steps
            return GetCVarBool(cvar)
        end--]]

        local function SetCvarChecked(cvar) 
            SetCVar(cvar, not GetCVarBool(cvar))
        end

        if(GetCVarBool("questHelper")) then
            WatchFrame.showObjectives = GetCVarBool("questPOI")

            local questObjectives = rootDescription:CreateCheckbox(SHOW_QUEST_OBJECTIVES_ON_MAP_TEXT, GetCVarBool, function(cvar)
                WatchFrame.showObjectives = GetCVarBool(cvar) or nil
                QuestLog_UpdateMapButton()
                SetCvarChecked(cvar)
            end, "questPOI")

            questObjectives:SetTooltip(function(tooltip, elementDescription)
                GameTooltip_SetTitle(tooltip,  OPTION_TOOLTIP_SHOW_QUEST_OBJECTIVES_ON_MAP)
            end)

        end

        rootDescription:CreateCheckbox(SHOW_PET_BATTLES_ON_MAP_TEXT, GetCVarBool, SetCvarChecked, "showTamers") -- you forgot this too, was introduced in mists

        local digSites = rootDescription:CreateCheckbox(ARCHAEOLOGY_SHOW_DIG_SITES, GetCVarBool, SetCvarChecked, "digSites")
        digSites:SetTooltip(function(tooltip, elementDescription)
            GameTooltip_SetTitle(tooltip,  OPTION_TOOLTIP_SHOW_DIG_SITES_ON_MAP)
        end)

        local mapEncounters = C_EncounterJournal.GetEncountersOnMap(MapUtil.GetDisplayableMapForPlayer())
        if (#mapEncounters > 0) then
            local showBosses = rootDescription:CreateCheckbox(SHOW_BOSSES_ON_MAP_TEXT, GetCVarBool, SetCvarChecked, "showBosses")
            showBosses:SetTooltip(function(tooltip, elementDescription)
                GameTooltip_SetTitle(tooltip,  OPTION_TOOLTIP_SHOW_BOSSES_ON_MAP)
            end)
        end
    end)
end

---- hotfix end