--[[
Copyright 2012-2021 João Cardoso
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
			local i = GossipFrame_GetTitleButtonCount()
			local button = GossipFrame.titleButtonPool:Acquire()
			button:SetPoint('TOPLEFT', i > 0 and GossipFrame.buttons[i] or GossipGreetingText, 'BOTTOMLEFT', i > 0 and 0 or -10, i > 0 and ((GossipFrame.insertSeparator and -19 or 0) - 3) or -20)
			button:SetOption(L.TellMore, 'Gossip')
			button:SetID(id)
			button:Show()

			GossipFrame.buttons = GossipFrame.buttons or {}
			tinsert(GossipFrame.buttons, button)
		end
	end)

	hooksecurefunc(C_GossipInfo, 'SelectOption', function(id)
		if Addon.RivalInfo[id] then
			Addon.Rival(id):Display()
		end
	end)
end
