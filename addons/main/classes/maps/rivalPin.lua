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
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
local Pin = Addon.Pin:NewClass('RivalPin', nil, 'EncounterJournalPinTemplate')
Pin.FrameLevel = 'PIN_FRAME_LEVEL_ENCOUNTER'


--[[ Overrides ]]--

function Pin:Construct()
	local b = self:Super(Pin):Construct()
	b.DefeatedOverlay:Hide()
	b:SetScript('OnClick', b:GetClass().OnClick)
	b:Show()
	return b
end

function Pin:New(frame, index, x,y, rival)
	local b = self:Super(Pin):New(frame, index, x,y)
  SetPortraitTextureFromCreatureDisplayID(b.Background, rival.model)
	b.Background:SetDesaturated(IsQuestFlaggedCompleted(rival.quest))
  b.rival = rival
	return b
end

function Pin:SetCanvasScale(scale)
	self:Super(Pin):SetCanvasScale(scale * 0.8)
end


--[[ Interaction ]]--

function Pin:OnClick()
	self.rival:Display()
end

function Pin:OnTooltip(tip)
	tip:AddHeader(self.rival.name)
	tip:AddLine(L.Source5)

	for i, pet in ipairs(self.rival) do
		local icon = format('|T%s:16:16:-3:0:128:256:60:100:130:170:255:255:255|t', pet:GetTypeIcon())
		local r,g,b = pet:GetColor()

		tip:AddLine(icon .. pet:GetName() .. ' (' .. pet:GetLevel() .. ')', r,g,b)
	end
end
