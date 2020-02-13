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

local Tutorials = PetTracker:NewModule('Tutorials', 'CustomTutorials-2.1')
local L = LibStub('AceLocale-3.0'):GetLocale('PetTracker')


--[[ Startup ]]--

function Tutorials:OnEnable()
	self:Load()
	self:RegisterEvent('ADDON_LOADED', 'Load')
	self:Trigger('main', 4)

	if (Addon.sets.mainTutorial or 0) > 3 then
		self:Trigger('journal', 1)
	end
end

function Tutorials:Load()
	-- triggers
	if WorldMapFrame and not self.map then
		WorldMapFrame:HookScript('OnShow', function() self:Trigger('main', 6) end)

		self.map = true
	end

	if Addon.RivalJournals and not self.journal then
		PetJournal:HookScript('OnShow', function() self:Trigger('journal', 3) end)
		Addon.RivalJournals:HookScript('OnShow', function() self:Trigger('journal', 7) end)

		self.journal = true
	end

	-- content
	self:Register {
		key = 'mainTutorial',
		title = ADDON, savedvariable = Addon.sets,
		onShow = function(f, i)
			if i == 3 then
				self:Load()
			end
		end,

		{
			text = L.Tutorial[1],
			image = 'Interface/Addons/PetTracker/Art/Pets',
			point = 'CENTER'
		},
		{
			text = L.Tutorial[2],
			point = 'TOPRIGHT', relPoint = 'TOPLEFT',
			image = 'Interface/Addons/PetTracker/Art/Tracker',
			shineRight = 10, shineLeft = -35,
			shineTop = 6, shineBottom = 0,
			anchor = ObjectiveTrackerFrame,
			shine = ObjectiveTrackerFrame,
			x = -40
		},
		{
			text = L.Tutorial[3],
			point = 'TOPRIGHT', relPoint = 'TOPLEFT',
			anchor = Addon.Objectives and Addon.Objectives.Header or Minimap,
			shine = Addon.Objectives and Addon.Objectives.Header,
			shineTop = 10, shineBottom = -7,
			shineRight = 10, shineLeft = -20,
			x = -30
		},
		{
			text = L.Tutorial[4],
			point = 'TOPRIGHT', relPoint = 'TOPLEFT',
			shineRight = 6, shineLeft = 2,
			anchor = MiniMapWorldMapButton,
			shine = MiniMapWorldMapButton,
			y = -10
		},
		{
			text = L.Tutorial[5],
			point = 'TOPLEFT', relPoint = 'BOTTOMRIGHT',
			anchor = Addon.MapFilter.Frames[WorldMapFrame],
			anchor = Addon.MapFilter.Frames[WorldMapFrame],
			shineLeft = -2, shineTop = 2,
			y = 5
		},
		{
			text = L.Tutorial[6],
			point = 'TOPLEFT', relPoint = 'BOTTOMRIGHT',
			shineTop = 6, shineBottom = -6,
			shineRight = 6, shineLeft = -12,
			shine = PetTrackerMapFilter,
			anchor = PetTrackerMapFilter,
			x = 15
		}
	}

	self:Register {
		key = 'journalTutorial',
		title = ADDON, savedvariable = Addon.sets,

		{
			text = L.JournalTutorial[1],
			point = 'BOTTOM', relPoint = 'TOP',
			shineRight = 2, shineLeft = -2,
			shineTop = 2, shineBottom = -2,
			anchor = CollectionsMicroButton,
			shine = CollectionsMicroButton,
			y = 10
		},
		{
			text = L.JournalTutorial[1],
			point = 'BOTTOMLEFT', relPoint = 'TOPRIGHT',
			shineLeft = 2, shineRight = -2,
			shineTop = 8,
			x = 20
		},
		{
			text = L.JournalTutorial[2],
			point = 'BOTTOMLEFT', relPoint = 'BOTTOMRIGHT',
			shineLeft = -4, shineRight = 4,
			shineBottom = -4, shineTop = 3,
			x = 20
		},
		{
			text = L.JournalTutorial[3],
			point = 'BOTTOMLEFT', relPoint = 'TOPRIGHT',
			anchor = Addon.RivalJournals and Addon.RivalJournals.Tab,
			shine = Addon.RivalJournals and Addon.RivalJournals.Tab,
			shineTop = 8,
			x = 20
		},
		{
			text = L.JournalTutorial[4],
			point = 'TOPLEFT', relPoint = 'TOPRIGHT',
			x = 20
		},
		{
			text = L.JournalTutorial[5],
			point = 'TOPLEFT', relPoint = 'BOTTOMRIGHT',
			anchor = Addon.RivalJournals and Addon.RivalJournals.SearchBox,
			shine = Addon.RivalJournals and Addon.RivalJournals.SearchBox,
			shineTop = 6, shineBottom = -6,
			shineRight = 6, shineLeft = -12,
			x = 15
		},
		{
			text = L.JournalTutorial[6],
			point = 'TOPLEFT', relPoint = 'TOPRIGHT',
			anchor = CollectionsJournal
			shine = Addon.RivalJournals and Addon.RivalJournals.Tab3,
			shineLeft = -3, shineRight = 5,
			shineBottom = -5, shineTop = 3,
			x = 20
		}
	}
end


--[[ API ]]--

function Tutorials:Register(data)
	self.RegisterTutorials(ADDON .. key, data)
end

function Tutorials:Trigger(id, index)
	self.TriggerTutorial(ADDON .. id .. 'Tutorial', index)
end
