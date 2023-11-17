--[[
Copyright 2012-2023 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
--local C = LibStub('C_Everywhere')
local Sushi = LibStub('Sushi-3.2')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

local Button = Addon:NewModule('Compartment', {
    text = ADDON,
    notCheckable = true,
    keepShownOnClick = true,
    icon = 'interface/addons/pettracker/art/compass',
    menu = {
        {
            text = '|A:worldquest-tracker-questmarker:12:12|a  ' .. 'Zone Tracker',
            func = function () Addon.Tracker:Toggle() end,
            notCheckable = 1
        },
        {
            text = '|A:worldquest-icon-engineering:12:12|a  ' .. OPTIONS,
            notCheckable = 1,
            func = function()
                if LoadAddOn(ADDON .. '_Config') then
                    Addon.Options:Open()
                end
            end
        },
        { 
            text = '|T516770:12:12:0:0:64:64:14:50:14:50|t  ' .. HELP_LABEL,
            notCheckable = 1,
            func = function()
                if LoadAddOn(ADDON .. '_Config') then
                    Addon.Options.FAQ:Open()
                end
            end
        },
        {
            text = '|Tinterface/addons/pettracker/art/discord:12:12|t  ' .. 'Community',
            notCheckable = true,
            func = function()
				Sushi.Popup {
					text = 'Copy the following url into your browser', button1 = OKAY, whileDead = 1, exclusive = 1, hideOnEscape = 1,
					hasEditBox = 1, editBoxWidth = 260, editBoxText = 'ewrgwergwegweg', autoHighlight = 1
				}
            end
        }
    }
})

function Button:func(_,_,_, button)
    local Drop = Button.drop or Sushi.Dropdown(AddonCompartmentFrame, Button.menu, true)
    Drop:SetCall('OnReset', function() Button.drop = nil end)
    Drop:SetPoint('TOPRIGHT', self, 'BOTTOMLEFT', -2, -10)

    Button.drop = Drop
    Button:funcOnLeave()
end
    
function Button:funcOnEnter()
    if not (Button.drop and Button.drop:IsShown()) then
        local _, title, notes = C_AddOns.GetAddOnInfo(ADDON)
        GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMLEFT')
        GameTooltip:SetText(title)
        GameTooltip:AddLine(notes, 1,1,1)
        GameTooltip:Show()
    end
end

function Button:funcOnLeave()
    GameTooltip:Hide()
end

AddonCompartmentFrame:RegisterAddon(Button)