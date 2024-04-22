--[[
Copyright 2012-2024 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local List = Addon.Base:NewClass('TextList', 'Frame')

function List:Construct(parent)
	local f = self:Super(List):Construct(parent)
	f.Lines = {}
	return f
end

function List:Add(text, icon, subicon, r,g,b)
	local anchor = self:Last() or self.Anchor
	local line = Addon.TextLine(anchor, text, icon, subicon, r,g,b)
	line:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT', anchor.xOff or 0, anchor.yOff or -4)

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
