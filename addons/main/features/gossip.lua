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
local Gossip = Addon:NewModule('Gossip')
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)

function Gossip:OnEnable()
	hooksecurefunc('GossipFrameUpdate', function()
		local unit = UnitGUID('npc')
		local id = unit and tonumber(select(6, strsplit('-', unit)), nil)

		if Addon.RivalInfo[id] then
			local index = GossipFrame.buttonIndex
			local button = _G['GossipTitleButton' .. index]
			button:SetText(L.TellMore)
			button.type = ADDON
			button:SetID(index)
			button:Show()

			local icon = _G[button:GetName() .. 'GossipIcon']
			icon:SetTexture('Interface/GossipFrame/GossipGossipIcon')

			GossipResize(button)
			GossipFrame.buttonIndex = index + 1
			GossipFrame.tamer = id
		end
	end)

	hooksecurefunc(C_GossipInfo, 'SelectOption', function(index)
		local button = _G['GossipTitleButton' .. index]
		if button and button.type == ADDON then
			Addon.Rival(GossipFrame.tamer):Display()
		end
	end)
end
