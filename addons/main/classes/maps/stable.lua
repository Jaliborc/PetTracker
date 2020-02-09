--[[
	stable.lua
		Pin marking a stable location
--]]


local ADDON, Addon = ...
local Pin = Addon.Pin:NewClass('StablePin')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

function Pin:Construct()
	local b = self:Super(Pin):Construct()
	b.Icon:SetTexture('Interface/Minimap/Tracking/StableMaster')
	b.Icon:SetSize(18, 18)
	b:SetSize(18, 18)
	return b
end

function Pin:OnTooltip(tip)
	tip:AddHeader(MINIMAP_TRACKING_STABLEMASTER)
	tip:AddLine(L.StableTip, 1,1,1)
end
