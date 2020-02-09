--[[
	tip.lua
		A tooltip for map canvas pins
--]]


local ADDON, Addon = ...
local Tooltip = Addon.Base:NewClass('MapTip', 'GameTooltip', 'GameTooltipTemplate', true)


--[[ Construct ]]--

function Tooltip:Construct()
	local f = self:Super(Tooltip):Construct()
	f.Strokes = f.Strokes or {}
	return f
end


--[[ API ]]--

function Tooltip:SetOwner(...)
	self:Super(Tooltip):SetOwner(...)
	self.NumStrokes = 0

	for i, stroke in pairs(self.Strokes) do
		stroke:Hide()
	end
end

function Tooltip:AddHeader(header)
	self:AddLine(header, 1,1,1, true)
end

function Tooltip:AddLine(text, r,g,b, isHeader)
	self:Super(Tooltip):AddLine(text, r,g,b, not isHeader)

	local i = self:NumLines()
	if i > 1 then
		local previous = self:GetLine(i - 1)
		local line = self:GetLine(i)
		line:SetPoint('TOPLEFT', previous, 'BOTTOMLEFT', 0, isHeader and -10 or -2)
		line:SetFontObject(isHeader and GameTooltipHeaderText or GameTooltipText)

		if isHeader then
			self:GetStroke(i):Show()
			self.NumStrokes = self.NumStrokes + 1
		end
	end
end

function Tooltip:Show()
	self:SetShown(self:NumLines() > 0)
	if self:IsShown() then
		local parent = self:GetParent()

		self:SetHeight(self:GetHeight() + self.NumStrokes * 8)
		self:SetScale(parent and (1 / parent:GetScale()) or UIParent:GetScale())
		self:SetFrameStrata('FULLSCREEN_DIALOG')
	end
end


--[[ Children ]]--

function Tooltip:GetLine(i)
	return _G[self:GetName() .. 'TextLeft' .. i]
end

function Tooltip:GetStroke(i)
	return self.Strokes[i] or self:NewStroke(i)
end

function Tooltip:NewStroke(i)
	local line = self:GetLine(i - 1)
	local stroke = self:CreateTexture()
	stroke:SetPoint('TOPLEFT', line, 'BOTTOMLEFT', -5, -3)
	stroke:SetPoint('TOPRIGHT', line, 'BOTTOMRIGHT', 5, -3)
	stroke:SetColorTexture(.3, .3, .3)
	stroke:SetHeight(1)

	self.Strokes[i] = stroke
	return stroke
end
