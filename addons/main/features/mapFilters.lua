--[[
Copyright 2012-2024 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

local function search(box)
    local text = box:GetText()
    if Addon.sets.mapSearch ~= text then
		Addon.SetOption('mapSearch', text)
	end
end

Menu.ModifyMenu('MENU_WORLD_MAP_TRACKING', function(_, drop)
    drop:CreateDivider()
    drop:CreateTitle('|TInterface/Addons/PetTracker/art/compass:16:16|t PetTracker')
    drop:CreateCheckbox(L.Species, Addon.GetOption, Addon.ToggleOption, 'showSpecies')

    local box = drop:CreateTemplate('SearchBoxTemplate')
    box:AddInitializer(function(box)
        box.Instructions:SetText(L.FilterSpecies)
        box.Toggle = function() box:SetShown(Addon.sets.showSpecies) end
        box:SetSize(100, Addon.sets.showSpecies and 20 or 1)
        box:SetText(Addon.sets.mapSearch or '')
        box:HookScript('OnTextChanged', search)
        box:HookScript('OnShow', box.Toggle)
        box:Toggle()
    end)

    drop:CreateCheckbox(STABLES, Addon.GetOption, Addon.ToggleOption, 'showStables')
end)