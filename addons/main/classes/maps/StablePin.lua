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
local Pin = Addon:NewClass(nil, 'StablePin', nil, Addon.Pin)

function Pin:OnCreate()
	self.__super.OnCreate(self)
	self.icon:SetTexture('Interface/Minimap/Tracking/StableMaster')
	self.icon:SetSize(18, 18)
	self:SetSize(18, 18)
end

function Pin:OnTooltip(tip)
	tip:AddHeader(MINIMAP_TRACKING_STABLEMASTER)
	tip:AddLine(Addon.Locals.StableTip, 1,1,1)
end
