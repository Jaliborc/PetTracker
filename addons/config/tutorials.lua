--[[
Copyright 2012-2026 João Cardoso
All Rights Reserved
--]]

local Addon = _G[(...):match('[^_]+')]
local L = LibStub('AceLocale-3.0'):GetLocale('PetTracker')
local Tutorials = Addon:NewModule('Tutorials', 'CustomTutorials-2.1')


--[[ Startup ]]--

function Tutorials:OnLoad()
	self:Load()
	self:Start()

	self:HookShown(WorldMapFrame, 'Load')
	self:RegisterEvent('ADDON_LOADED', 'Load')
	self:RegisterSignal('OPTIONS_RESET', 'Start')
end

function Tutorials:Load()
	self:RegisterTutorials {
		title = 'PetTracker',
		savedvariable = Addon.sets, key = 'tutorial',

		{
			text = L.Tutorial[1],
			image = 'Interface/Addons/PetTracker/art/welcome',
			point = 'CENTER'
		},
		{
			text = L.Tutorial[2],
			point = 'TOPRIGHT', relPoint = 'TOPLEFT',
			image = 'Interface/Addons/PetTracker/art/tracker',
			shineRight = 10, shineLeft = -35,
			shineTop = 6, shineBottom = 0,
			anchor = WatchFrame or ObjectiveTrackerFrame,
			shine = WatchFrame or ObjectiveTrackerFrame,
			x = -40,
		},
		{
			text = L.Tutorial[3],
			point = 'TOPRIGHT',
			anchor = MiniMapWorldMapButton or MinimapCluster.ZoneTextButton,
			shine = MiniMapWorldMapButton or MinimapCluster.ZoneTextButton,
			shineRight = MiniMapWorldMapButton and 4 or -5, shineLeft = MiniMapWorldMapButton and 2 or -12,
			shineTop = MiniMapWorldMapButton and 0 or 9, shineBottom = MiniMapWorldMapButton and 0 or -9,
			x = MiniMapWorldMapButton and -20 or 0, y = -30
		},
		{
			text = L.Tutorial[4],
			point = 'TOPLEFT', relPoint = 'TOPRIGHT',
			image = 'Interface/Addons/PetTracker/art/map-filter',
			shine = WorldMapFrame.WorldMapOptionsDropDown,
			shineTop = 5, shineBottom = -5, shineRight = 5, shineLeft = -5,
			anchor = WorldMapFrame,
			x = 20, y = -160
		},
		{
			text = L.Tutorial[5],
			point = 'TOPLEFT', relPoint = 'TOPRIGHT',
			image = 'Interface/Addons/PetTracker/art/map-filter',
			shine = WorldMapFrame.WorldMapOptionsDropDown,
			shineTop = 5, shineBottom = -5, shineRight = 5, shineLeft = -5,
			anchor = WorldMapFrame,
			x = 20, y = -160
		},
		{
			text = L.Tutorial[6],
			point = 'BOTTOM', relPoint = 'TOP',
			anchor = CollectionsMicroButton,
			shine = CollectionsMicroButton,
			shineTop = MiniMapWorldMapButton and -14 or 7, shineBottom = -7,
			shineRight = 7, shineLeft = -7,
			y = 10
		},
		{
			text = L.Tutorial[7],
			point = 'BOTTOMLEFT', relPoint = 'TOPLEFT',
			anchor = Addon.TrackToggle, shine = Addon.TrackToggle,
			shineLeft = -4, shineRight = 4,
			shineBottom = -4, shineTop = 3,
			x = 20
		},
		{
			text = L.Tutorial[8],
			point = 'BOTTOMLEFT', relPoint = 'TOPRIGHT',
			anchor = Addon.RivalsJournal and Addon.RivalsJournal.PanelTab,
			shine = Addon.RivalsJournal and Addon.RivalsJournal.PanelTab,
			shineBottom = -2, shineTop = 5,
			x = 20
		},
		{
			text = L.Tutorial[9],
			point = 'TOPLEFT', relPoint = 'TOPRIGHT',
			anchor = Addon.RivalsJournal,
			x = 20
		},
		{
			text = L.Tutorial[10],
			point = 'TOPLEFT', relPoint = 'BOTTOMRIGHT',
			anchor = Addon.RivalsJournal and Addon.RivalsJournal.SearchBox,
			shine = Addon.RivalsJournal and Addon.RivalsJournal.SearchBox,
			shineTop = 6, shineBottom = -6,
			shineRight = 6, shineLeft = -12,
			x = 15
		},
		{
			text = L.Tutorial[11],
			point = 'TOPLEFT', relPoint = 'TOPRIGHT',
			anchor = CollectionsJournal,
			shine = Addon.RivalsJournal and Addon.RivalsJournal.Tab3,
			shineLeft = -3, shineRight = 5,
			shineBottom = -5, shineTop = 3,
			x = 20
		},
	}

	self:TriggerOn(WorldMapFrame, 6)
	self:TriggerOn(Addon.TrackToggle, 8)
	self:TriggerOn(Addon.RivalsJournal, 11)
end

function Tutorials:Start()
	self:TriggerTutorial(3)
end

function Tutorials:Restart()
	Addon.sets.tutorial = nil
	self:Start()
end


--[[ API ]]--

function Tutorials:TriggerOn(frame, step)
	self:HookShown(frame, 'TriggerTutorial', step)
end

function Tutorials:HookShown(frame, call, arg)
	if frame and not self[frame] then
		if frame:IsVisible() then
			self[call](self, arg)
		else
			frame:HookScript('OnShow', function()
				if self[frame] == 0 then
					self[call](self, arg)
					self[frame] = 1
				end					
			end)
		end

		self[frame] = 0
	end
end
