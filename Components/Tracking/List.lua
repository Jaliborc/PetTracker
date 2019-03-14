--[[
Copyright 2012-2019 João Cardoso
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
local Line = Addon:NewClass('Button', 'Line', ADDON .. 'Line')
local List = Addon:NewClass('Frame', 'List')


--[[ Constructor ]]--

function List:OnCreate()
	self.Lines = {}
end


--[[ API ]]--

function List:NewLine()
	local line = Line(self)
	local last = self:Last() or self.Anchor

	line:SetPoint('TOPLEFT', last, 'BOTTOMLEFT', last.xOff or 0, last.yOff or -4)
	line.Text:SetPoint('Left', line.Icon, 'Right', 8, 0)
	line.Icon:Show()
	line:Show()
	
	tinsert(self.Lines, line)
	return line
end

function List:Reset()
	for i, line in ipairs(self.Lines) do
		line:Release()
		line:Hide()
	end
	wipe(self.Lines)
end

function List:Last()
	return self.Lines[self:Count()]
end

function List:Count()
	return #self.Lines
end