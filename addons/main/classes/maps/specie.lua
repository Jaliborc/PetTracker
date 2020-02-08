--[[
	specie.lua
		Pin marking a pet specie spawn location
--]]

local ADDON, Addon = ...
local Pin = Addon.Pin:NewClass('SpeciePin')

function Pin:New(...)
	local b = self:Super(Pin):New(...)
	b.Icon:SetTexCoord(0.79687500, 0.49218750, 0.50390625, 0.65625000)
	b.Icon:SetSize(16, 16)
	b:SetScript('OnClick', b.OnClick)
	b:SetSize(16, 16)
	return b
end

function Pin:OnClick(button)
	if button == 'LeftButton' then
		self.specie:Display()
	end
end

function Pin:OnTooltip(tip)
	local name, icon, _,_, source = self.specie:GetInfo()
	local owned = self.specie:GetOwnedText()

	tip:AddHeader(('|T%s:%d:%d:-2:0|t'):format(icon, 20, 20) .. name)
	tip:AddLine((owned and (owned .. '|n') or '') .. self:KeepShort(source), 1,1,1)
end

function Pin:KeepShort(text)
	if not text:find('|n') and strlen(text) > 100 then
		return text:sub(0, 97) .. '...'
	end
	return text
end
