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

local _, Addon = ...
local Pin = Addon:NewClass(nil, 'SpeciePin', nil, Addon.Pin)

function Pin:OnCreate()
	 self.__super.OnCreate(self)
	 self.icon:SetTexCoord(0.79687500, 0.49218750, 0.50390625, 0.65625000)
	 self.icon:SetSize(16, 16)

	 self:SetScript('OnClick', self.OnClick)
	 self:SetSize(16, 16)
end

function Pin:OnClick(button)
	 if button == 'LeftButton' then
	 	 HideUIPanel(WorldMapFrame)
		 self.specie:Display()
	 end
end

function Pin:OnTooltip(tip)
	local name, icon, _,_, source = self.specie:GetInfo()
	local owned = self.specie:GetOwnedText()

	tip:AddHeader(('|T%s:%d:%d:-2:0|t'):format(icon, 20, 20) .. name)
	tip:AddLine((owned and (owned .. '|n') or '') .. Addon.KeepShort(source), 1,1,1)
end
