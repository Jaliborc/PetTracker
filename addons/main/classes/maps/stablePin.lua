--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local Pin = Addon.Pin:NewClass('StablePin')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

function Pin:Construct()
	local b = self:Super(Pin):Construct()
	b.Icon = b:CreateTexture(nil, 'ARTWORK')
	b.Icon:SetTexture('Interface/Minimap/Tracking/StableMaster')
	b.Icon:SetAllPoints()
	b:SetSize(18, 18)
	return b
end

function Pin:OnTooltip(tip)
	tip:AddHeader(MINIMAP_TRACKING_STABLEMASTER)
	tip:AddLine(L.StableTip, 1,1,1)
end
