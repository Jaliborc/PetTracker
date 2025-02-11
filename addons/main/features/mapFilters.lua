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