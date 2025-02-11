--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local Line = Addon.Base:NewClass('SpecieLine', 'Button', true)

function Line:New(parent, text, icon, subicon, r,g,b)
	local line = self:Super(Line):New(parent)
	line.r, line.g, line.b = r,g,b
	line.Text:SetText(text)
	line.Text:SetPoint('Left', line.Icon, 'Right', 8, 0)
	line.SubIcon:SetTexture(subicon)
	line.Icon:SetTexture(icon)
	line.Icon:Show()

	line:SetScript('OnClick', nil)
	line:HighlightColor(false)
	return line
end

function Line:Construct()
	local line = self:Super(Line):Construct()
	line:SetScript('OnEnter', line.OnEnter)
	line:SetScript('OnLeave', line.OnLeave)
	return line
end

function Line:OnEnter()
	self:HighlightColor(true)
end

function Line:OnLeave()
	self:HighlightColor(false)
end

function Line:HighlightColor(highlight)
	local off = highlight and 1 or 0.8
	self.Text:SetTextColor(self.r*off, self.g*off, self.b*off)
end
