--[[
Copyright 2012-2018 João Cardoso
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


local _, private = ...
local ADDON, Addon = ...

local gui = CreateFrame("Frame", "PetTrackerOptions", _G.UIParent)
gui.name = "PetTracker"
Addon.gui = gui

local checkboxes = {}
local function addSubCategory(parent, name)
    local header = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    header:SetText(name)

    local line = parent:CreateTexture(nil, "ARTWORK")
    line:SetSize(450, 1)
    line:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -4)
    line:SetColorTexture(1, 1, 1, .2)

    return header
end

local createToggleBox do
    local function toggle(self)
        _G.PetTracker_Sets[self.value] = self:GetChecked()
	    Addon:ForAllModules('ConfigChanged')
    end

    function createToggleBox(parent, value, text)
        local checkbutton = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
        checkbutton.Text:SetText(text)
        checkbutton.value = value
        _G.tinsert(checkboxes, checkbutton)

        checkbutton:SetScript("OnClick", toggle)
        return checkbutton
    end
end


_G.InterfaceOptions_AddCategory(gui)
local title = gui:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOP", -30, -26)
title:SetText("PetTracker")

local features = addSubCategory(gui, "Tracker")
features:SetPoint("TOPLEFT", 16, -80)

local trackingBox = createToggleBox(gui, "HideTracker", Addon.Locals.HideTracker)
trackingBox:SetPoint("TOPLEFT", features, "BOTTOMLEFT", 10, -20)

local capturedBox = createToggleBox(gui, "CapturedPets", Addon.Locals.CapturedPets)
capturedBox:SetPoint("LEFT", trackingBox, "RIGHT", 105, 0)


local map = addSubCategory(gui, "Map")
map:SetPoint("TOPLEFT", 16, -160)

local showPetBox = createToggleBox(gui, "HideSpecies", Addon.Locals.HidePets)
showPetBox:SetPoint("TOPLEFT", map, "BOTTOMLEFT", 10, -20)

local showCapturedbox = createToggleBox(gui, "mapCaptured", Addon.Locals.CapturedPets)
showCapturedbox:SetPoint("LEFT", showPetBox, "RIGHT", 105, 0)

local showTrainersBox = createToggleBox(gui, "HideRivals", Addon.Locals.HideTrainers)
showTrainersBox:SetPoint("LEFT", showCapturedbox, "RIGHT", 105, 0)

local showStablesBox = createToggleBox(gui, "HideStables", Addon.Locals.HideStables)
showStablesBox:SetPoint("LEFT", showTrainersBox, "RIGHT", 105, 0)


gui.refresh = function()
    for i = 1, #checkboxes do
        checkboxes[i]:SetChecked(_G.PetTracker_Sets[checkboxes[i].value] == true)
    end
end

gui.default = function()
    gui.refresh()
end

-- easy slash command
_G.SLASH_PETTRACKER1 = "/pettracker"
_G.SlashCmdList.PETTRACKER = function(msg, editBox)
    _G.InterfaceOptionsFrame_OpenToCategory(gui)
    _G.InterfaceOptionsFrame_OpenToCategory(gui)
end