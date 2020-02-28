--[[
Copyright 2012-2020 João Cardoso
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

local ADDON, Addon = ...
local List = Addon.Base:NewClass('TextList', 'Frame')

function List:New(parent)
	local f = self:Super(List):New(parent)
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
