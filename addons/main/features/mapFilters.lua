--[[
Copyright 2012-2024 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

local function get(key)
    return not Addon.sets[key]
end

local function set(key)
    Addon.sets[key] = not Addon.sets[key]
    Addon.MapCanvas:UpdateAll()
end

local function search(box)
    local text = box:GetText()
    if Addon.sets.mapSearch ~= text then
		Addon.sets.mapSearch = text
		Addon.MapCanvas:UpdateAll()
	end
end

Menu.ModifyMenu('MENU_WORLD_MAP_TRACKING', function(_, drop)
    drop:CreateDivider()
    drop:CreateTitle('|TInterface/Addons/PetTracker/art/compass:16:16|t PetTracker:')
    drop:CreateCheckbox(L.Species, get, set, 'hideSpecies')

    local box = drop:CreateTemplate('SearchBoxTemplate')
    box:AddInitializer(function(box)
        box.Instructions:SetText(L.FilterSpecies)
        box.Toggle = function() box:SetShown(not Addon.sets.hideSpecies) end
        box:SetSize(100, Addon.sets.hideSpecies and 1 or 20)
        box:SetText(Addon.sets.mapSearch or '')
        box:HookScript('OnTextChanged', search)
        box:HookScript('OnShow', box.Toggle)
        box:Toggle()
    end)

    drop:CreateCheckbox(STABLES, get, set, 'hideStables')
end)