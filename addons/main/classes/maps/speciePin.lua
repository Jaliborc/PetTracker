--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local Pin = Addon.Pin:NewClass('SpeciePin')


--[[ Overrides ]]--

function Pin:Construct()
	local b = self:Super(Pin):Construct()
	b:SetScript('OnClick', b.OnClick)
	b:SetSize(16, 16)

	b.Type = b:CreateTexture(nil, 'ARTWORK')
	b.Type:SetTexCoord(0.79687500, 0.49218750, 0.50390625, 0.65625000)
	b.Type:SetPoint('CENTER')
	b.Type:SetSize(13, 13)

	b.Icon = b:CreateTexture(nil, 'ARTWORK')
	b.Icon:SetMask('Interface/CHARACTERFRAME/TempPortraitAlphaMask')
	b.Icon:SetPoint('CENTER')
	b.Icon:SetSize(14, 14)

	b.Border = b:CreateTexture(nil, 'OVERLAY')
	b.Border:SetAtlas('Neutraltrait-border-selected')
	b.Border:SetPoint('CENTER')
	b.Border:SetSize(22, 22)

	return b
end

function Pin:New(frame, index, x,y, specie)
	local b = self:Super(Pin):New(frame, index, x,y)
	b.Type:SetShown(not Addon.sets.specieIcons)
	b.Icon:SetShown(Addon.sets.specieIcons)
  b.specie = specie

	if Addon.sets.specieIcons then
		b.Icon:SetTexture(specie:GetIcon())
	else
		b.Type:SetTexture(specie:GetTypeIcon())
	end

	return b
end


--[[ Interaction ]]--

function Pin:OnClick(button)
	if button == 'LeftButton' then
		self.specie:Display()
	end
end

function Pin:OnTooltip(tip)
	local name, icon, _,_, source = self.specie:GetInfo()
	local owned = self.specie:GetOwnedText()

	tip:AddHeader(('|T%s:%d:%d:-2:0|t'):format(icon, 20, 20) .. name)
	tip:AddLine((owned and NORMAL_FONT_COLOR:WrapTextInColorCode(owned .. '|n') or '') .. self:KeepShort(source), 1,1,1)
end

function Pin:KeepShort(text)
	if not text:find('|n') and strlen(text) > 100 then
		return text:sub(0, 97) .. '...'
	end
	return text
end
