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

local ADDON, Addon = 'PetTracker', PetTracker
local Tutorial = Addon:NewModule('Tutorial')
local Lib = LibStub('CustomTutorials-2.1')
local L = Addon.Locals


--[[ Events ]]--

function Tutorial:Startup()
	if (Addon.Sets.MainTutorial or 0) < 4 then
		self:Trigger('Main', 4)
	else
		self:Split()
	end
end

function Tutorial:Split()
	WorldMapFrame:HookScript('OnShow', function()
		self:Trigger('Main', 6)
	end)

	if GetAddOnEnableState(UnitName('player'), ADDON .. '_Journal') > 0 then
		self:Trigger('Journal', 1)

		if PetJournal then
			self:HookJournal()
		else
			hooksecurefunc('LoadAddOn', function(addon)
				if addon == 'Blizzard_Collections' then
					self:HookJournal()
				end
			end)
		end
	end
end

function Tutorial:HookJournal()
	self.HookJournal = function() end

	CollectionsJournal:HookScript('OnShow', function()
		self:Trigger('Journal', 2)
	end)

	PetJournal:HookScript('OnShow', function()
		self:Trigger('Journal', 2)
		self:Trigger('Journal', 4)
	end)

	local function RivalJournal()
		if Addon.Sets.JournalTutorial >= 3 then
			self:Trigger('Journal', 4, true)
			self:Trigger('Journal', 7)
		else
			_G[ADDON .. 'RivalJournal']:HookScript('OnShow', RivalJournal)
		end
	end

	_G[ADDON .. 'RivalJournal']:HookScript('OnShow', RivalJournal)
end

function Tutorial:Restart()
	self:Reset('Main')
	self:Reset('Journal')
	self:Startup()
end


--[[ Utilities ]]--

function Tutorial:Register(id, data)
	data.title = ADDON
	data.savedvariable = Addon.Sets
	data.key = id .. 'Tutorial'

	Lib.RegisterTutorials(ADDON .. id, data)
end

function Tutorial:Trigger(id, ...)
	Lib.TriggerTutorial(ADDON .. id, ...)
end

function Tutorial:Reset(id)
	Lib.ResetTutorials(ADDON .. id)
end


--[[ Content ]]--

Tutorial:Register('Main', {
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
	},

	onShow = function(self, i)
		if i == 3 then
			local header = Addon.Objectives and Addon.Objectives.Header
			self[i].anchor = header or Minimap
			self[i].shine = header
		elseif i == 4 then
			Tutorial:Split()
		elseif i >= 5 then
			self[i].anchor = Addon.MapFilter.frames[WorldMapFrame]
			self[i].shine = Addon.MapFilter.frames[WorldMapFrame]
		end
	end
})

Tutorial:Register('Journal', {
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
		shineTop = 6, shineBottom = -6,
		shineRight = 6, shineLeft = -12,
		x = 15
	},
	{
		text = L.JournalTutorial[6],
		point = 'TOPLEFT', relPoint = 'TOPRIGHT',
		shineLeft = -3, shineRight = 5,
		shineBottom = -5, shineTop = 3,
		x = 20
	},

	onShow = function(self, i)
		if i == 2 then
			self[i].shine = CollectionsJournalTab2
			self[i].anchor = CollectionsJournalTab2
		elseif i == 3 then
			self[i].shine = _G[ADDON .. 'TrackToggle']
			self[i].anchor = CollectionsJournal
		elseif i == 4 then
			self[i].shine = _G[ADDON .. 'RivalJournal'].Tab
			self[i].anchor = _G[ADDON .. 'RivalJournal'].Tab
		elseif i == 5 then
			self[i].anchor = CollectionsJournal
		elseif i == 6 then
			self[i].anchor = _G[ADDON .. 'RivalJournal'].SearchBox
			self[i].shine = _G[ADDON .. 'RivalJournal'].SearchBox
		elseif i == 7 then
			self[i].anchor = CollectionsJournal
			self[i].shine = _G[ADDON .. 'RivalJournal'].Tab3
		end
	end
})

Tutorial:Startup()
