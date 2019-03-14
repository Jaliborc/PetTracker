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

local _, Addon = ...
local Pin = Addon:NewClass(nil, 'RivalPin', 'EncounterJournalPinTemplate', Addon.Pin)

function Pin:OnCreate()
	 self.__super.OnCreate(self)
	 self:SetScript('OnClick', self.__index.OnClick)
	 self.framelevel = 'PIN_FRAME_LEVEL_ENCOUNTER'
end

function Pin:Display(rival)
  SetPortraitTextureFromCreatureDisplayID(self.Background, rival.model)
	self.Background:SetDesaturated(IsQuestFlaggedCompleted(rival.quest))
  self.rival = rival
end

function Pin:OnClick()
	self.rival:Display()
end

function Pin:OnTooltip(tip)
	tip:AddHeader(self.rival.name)
	tip:AddLine(Addon.Locals.PetBattle)

	for i, pet in ipairs(self.rival) do
		local r,g,b = Addon.GetQualityColor(pet:GetQuality())
		local icon = format('|T%s:16:16:-3:0:128:256:60:100:130:170:255:255:255|t', pet:GetTypeIcon())

		tip:AddLine(icon .. pet:GetName() .. ' (' .. pet:GetLevel() .. ')', r,g,b)
	end
end
