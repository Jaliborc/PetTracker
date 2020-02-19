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

local Sushi = LibStub('Sushi-3.1')
local Options = PetTracker:NewModule('Options', Sushi.OptionsGroup('PetTracker |TInterface/Garrison/MobileAppIcons:13:13:0:0:1024:1024:261:389:261:389|t'))
local L = LibStub('AceLocale-3.0'):GetLocale('PetTracker')

local PATRONS = {{title='Jenkins',people={'Gnare','ProfessahX','Zaneius Valentine'}},{},{title='Ambassador',people={'Fernando Bandeira','Michael Irving','Julia F','Peggy Webb','Lolari','Craig Falb','Mary Barrentine','Patryk Kalis','Lifeprayer','Steve Lund','Grimmcanuck','Donna Wasson'}}} -- generated patron list
local HELP_ICON = ' |TInterface/HelpFrame/HelpIcon-KnowledgeBase:13:13:0:0:64:64:14:50:14:50|t'
local FOOTER = 'Copyright 2012-2020 João Cardoso'


--[[ Startup ]]--

function Options:OnEnable()
	local faq = Sushi.OptionsGroup(self, HELP_LABEL .. HELP_ICON)
	faq:SetSubtitle(L.FAQDescription)
	faq:SetChildren(self.OnFAQ)
	faq:SetFooter(FOOTER)

	local credits = Sushi.CreditsGroup(self, PATRONS)
	credits:SetSubtitle(nil, 'http://www.patreon.com/jaliborc')
	credits:SetFooter(FOOTER)

	self:SetCall('OnDefaults', self.OnDefaults)
	self:SetCall('OnChildren', self.OnMain)
	self:SetSubtitle(L.OptionsDescription)
	self:SetFooter(FOOTER)
end

function Options:OnDefaults()
	--wipe(PetTracker.sets)
	--PetTracker:SendSignal('OPTIONS_CHANGED')
end

function Options:OnMain()
	self:Add('Header', TRACKING, GameFontHighlight, true)
	self:AddCheck('ZoneTracker')
	self:AddCheck('RivalPortraits')

	self:Add('Header', BATTLE_PET_SOURCE_5, GameFontHighlight, true)
	self:AddCheck('Switcher')
	self:AddCheck('AlertUpgrades')
	self:AddSetting('DropChoice', 'Forfeit'):AddChoices {
		{text = ALWAYS, key = 'auto'},
		{text = 'Prompt', key = 'ask'},
		{text = NEVER, key = false},
	}
end

function Options:OnFAQ()
	for i = 1, #L.FAQ, 2 do
		self:Add('Header', L.FAQ[i], GameFontHighlight, true)
		self:Add('Header', L.FAQ[i+1], GameFontDisable).bottom = 15
	end
end


--[[ API ]]--

function Options:AddCheck(id)
	return self:AddSetting('Check', id)
end

function Options:AddSetting(class, id)
	local arg = id:gsub('^.', strlower)
	local b = self:Add(class, L[id])
	b:SetTip(L[id], L[id .. 'Tip'])
	b:SetValue(PetTracker.sets[arg])
	b:SetCall('OnInput', function(b, v)
		PetTracker.sets[arg] = v
		PetTracker:SendSignal('OPTIONS_CHANGED')
	end)

	return b
end
