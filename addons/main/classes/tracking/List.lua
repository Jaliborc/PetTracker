--[[
	lists.lua
		A top-to-bottom array of clickable text lines
--]]


local ADDON, Addon = ...
local List = Addon.Base:NewClass('TextList', 'Frame')
local Line = Addon.Base:NewClass('TextLine', 'Button', true)

function List:New(...)
	local f = self:Super(List):New(...)
	f.Lines = {}
	return f
end

function List:Add(text, icon, subicon)
	local line = Line(self)
	local last = self:Last() or self.Anchor
	line:SetPoint('TOPLEFT', last, 'BOTTOMLEFT', last.xOff or 0, last.yOff or -4)
	line.Text:SetText(text)
	line.Text:SetPoint('Left', line.Icon, 'Right', 8, 0)
	line.Text:SetWidth(self.Anchor:GetWidth())
	line.SubIcon:SetTexture(subicon)
	line.Icon:SetTexture(icon)
	line.Icon:Show()

	tinsert(self.Lines, line)
	return line
end

function List:Clear()
	for i, line in ipairs(self.Lines) do
		line:Release()
	end
	wipe(self.Lines)
end

function List:Last()
	return self.Lines[self:Count()]
end

function List:Count()
	return #self.Lines
end
