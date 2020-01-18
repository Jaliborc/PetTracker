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

local ADDON, Addon = 'PetTracker', PetTracker
local Config = Addon:NewModule('Config')
local L = Addon.Locals

local PAW_ICON = '|TInterface\\Garrison\\MobileAppIcons:13:13:0:0:1024:1024:261:389:261:389|t '
local HELP_ICON = '|TInterface\\HelpFrame\\HelpIcon-KnowledgeBase:13:13:0:0:64:64:14:50:14:50|t '
local PATRONS = {{title='Jenkins',people={'Gnare','ProfessahX','Zaneius Valentine'}},{},{title='Ambassador',people={'Fernando Bandeira','Michael Irving','Julia F','Peggy Webb','Lolari','Craig Falb','Mary Barrentine','Patryk Kalis','Lifeprayer','Steve Lund','Grimmcanuck','Donna Wasson'}}} -- generated patron list
local FAQ = L.FAQ

function Config:Startup()
	local options = self:CreatePanel(SushiMagicGroup, nil, PAW_ICON .. ADDON)
	options:SetChildren(function(self)
		Addon:ForAllModules('AddOptions', self)
	end)

	local faq = self:CreatePanel(SushiMagicGroup, options:GetTitle(), HELP_ICON .. HELP_LABEL)
	faq:SetSubtitle(L.FAQDescription)
	faq:SetChildren(function(self)
		for i = 1, #FAQ, 2 do
			self:CreateHeader(FAQ[i], 'GameFontHighlight', true)
			self:CreateHeader(FAQ[i+1], 'GameFontDisable').bottom = 15
		end
	end)

	local credits = self:CreatePanel(SushiCreditsGroup, options:GetTitle())
	credits:SetWebsite('http://www.patreon.com/jaliborc')
	credits:SetPeople(PATRONS)
end

function Config:CreatePanel(class, ...)
	local group = class:CreateOptionsCategory(...)
	group:SetAddon(ADDON)
	group:SetFooter('Copyright 2012-2020 João Cardoso')
	group.Category.default = function()
		for k, v in pairs(Addon.Sets) do
			if type(v) ~= 'table' then
				Addon.Sets[k] = nil
			end
		end

		Addon.Tutorial:Restart()
		group:Update()
	end

	return group
end

Config:Startup()
