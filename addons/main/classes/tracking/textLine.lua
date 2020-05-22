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
local Line = Addon.Base:NewClass('TextLine', 'Button', true)

function Line:New(parent, text, icon, subicon, r,g,b)
  local line = self:Super(Line):New(parent)
  line.r, line.g, line.b = r,g,b
  line.Text:SetText(text)
  line.Text:SetPoint('Left', line.Icon, 'Right', 8, 0)
  line.Text:SetWidth(parent:GetWidth())
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
  local off = highlight and 0 or .2
  self.Text:SetTextColor(self.r-off, self.g-off, self.b-off)
end
