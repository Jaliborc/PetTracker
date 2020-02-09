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
--]]

local ADDON, Addon = ...
local Addon = LibStub('WildAddon-1.0'):NewAddon(ADDON, Addon, 'MutexDelay-1.0')
Addon.MaxQuality = LE_ITEM_QUALITY_RARE + 1
Addon.MaxLevel = 25


--[[ Events ]]--

function Addon:OnEnable()
	PetTracker_State = PetTracker_State or {}
	PetTracker_Sets = PetTracker_Sets or {}

	self.sets, self.state = PetTracker_Sets, PetTracker_State
	self:RegisterEvent('PLAYER_ENTERING_WORLD')

	if self.sets.MainTutorial then
		--[[for k,v in pairs(self.sets) do
			self.sets[k] = nil
			self.sets[k:gsub('^.', strlower)] = v
		end]]--
	end

	if (self.sets.mainTutorial or 0) < 6 or (self.sets.journalTutorial or 0) < 7 then
		LoadAddOn('PetTracker_Config')
	else
		CreateFrame('Frame', nil, InterfaceOptionsFrame):SetScript('OnShow', function()
			LoadAddOn('PetTracker_Config')
		end)
	end
end

function Addon:PLAYER_ENTERING_WORLD()
	self:RegisterEvent('PET_JOURNAL_LIST_UPDATE')
	self:SendSignal('PETS_CHANGED')
end

function Addon:PET_JOURNAL_LIST_UPDATE()
	self:Delay(2, 'SendSignal', 'PETS_CHANGED') -- data on client doesnt update immediately every time
end


--[[ Utility ]]--

function Addon:GetColor(quality)
	if quality > 0 then
		return GetItemQualityColor(quality - 1)
	end

	return RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, RED_FONT_COLOR_CODE:sub(3)
end
