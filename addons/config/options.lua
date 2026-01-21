--[[
	Copyright 2012-2026 João Cardoso
	All Rights Reserved
--]]

local Sushi, Addon = LibStub('Sushi-3.2'), PetTracker
local L = LibStub('AceLocale-3.0'):GetLocale('PetTracker')
local Options = PetTracker:NewModule('Options', Sushi.OptionsGroup('|Tinterface/addons/pettracker/art/compass:16:16|t PetTracker'))

local PATRONS = {{title='Jenkins',people={'Gnare','Johnny Rabbit','Debora S Ogormanw'}},{title='Ambassador',people={'Julia F','Lolari ','Ptsdthegamer','Swallow@area52','Peter Hollaubek','Jury ','Bc Spear','Adam Mann','Michael Kinasz','Ronald Platz','M Prieto','Goldpaw','Brian Joaquin','Ole Jonny Søndenå','Airdrigh','Sean Locko'}}} -- generated patron list
local PATREON_ICON = '  |TInterface/Addons/PetTracker/art/patreon:12:12|t'
local HELP_ICON = '  |T516770:13:13:0:0:64:64:14:50:14:50|t'
local FOOTER = 'Copyright 2012-2026 João Cardoso'
local PET_QUALITIES = {}

for i = Addon.MaxPlayerQuality, 1, -1 do
	tinsert(PET_QUALITIES, {key = i, text = Addon:GetColor(i):WrapTextInColorCode(_G['BATTLE_PET_BREED_QUALITY'..i])})
end


--[[ Startup ]]--

function Options:OnLoad()
	self.Help = Sushi.OptionsGroup(self, HELP_LABEL .. HELP_ICON)
					:SetSubtitle(L.HelpDescription):SetFooter(FOOTER):SetChildren(self.OnHelp)
	self.Credits = Sushi.OptionsGroup(self, 'Patrons' .. PATREON_ICON)
					:SetSubtitle(L.PatronsDescription):SetFooter(FOOTER):SetOrientation('HORIZONTAL'):SetChildren(self.OnCredits)

	self:SetCall('OnChildren', self.OnMain)
	self:SetSubtitle(L.OptionsDescription)
	self:SetFooter(FOOTER)
end

function Options:OnMain()
	self:Add('Header', TRACKING, GameFontHighlight, true)
	self:AddCheck('ZoneTracker')
	self:AddCheck('SpecieIcons')
	self:AddCheck('RivalPortraits')

	self:Add('Header', COMBAT, GameFontHighlight, true)
	self:AddCheck('Switcher')
	self:AddCheck('AlertUpgrades')
	self:AddCheck('Forfeit')
	self:AddChoice('MinAlertQuality', PET_QUALITIES)
end

function Options:OnHelp()
	for i = 1, #L.FAQ, 2 do
		self:Add('ExpandHeader', L.FAQ[i], GameFontHighlightSmall):SetExpanded(self[i]):SetCall('OnClick', function() self[i] = not self[i] end)

		if self[i] then
			local answer = self:Add('Header', L.FAQ[i+1], GameFontHighlightSmall)
			answer.left, answer.right, answer.bottom = 16, 16, 16
		end
	end

	self:Add('RedButton', 'Show Tutorial'):SetWidth(200):SetCall('OnClick', function() Addon.Tutorials:Restart() end).top = 10
	self:Add('RedButton', 'Ask Community'):SetWidth(200):SetCall('OnClick', function()
		Sushi.Popup:External('bit.ly/discord-jaliborc')
		SettingsPanel:Close(true)
	end)
end

function Options:OnCredits()
	for i, rank in ipairs(PATRONS) do
		if rank.people then
			self:Add('Header', rank.title, GameFontHighlight, true).top = i > 1 and 20 or 0

			for j, name in ipairs(rank.people) do
				self:Add('Header', name, i > 1 and GameFontHighlight or GameFontHighlightLarge):SetWidth(180)
			end
		end
	end

	self:AddBreak()
	self:Add('RedButton', 'Join Us'):SetWidth(200):SetCall('OnClick', function()
		Sushi.Popup:External('patreon.com/jaliborc')
		SettingsPanel:Close(true)
	end).top = 20
end


--[[ API ]]--

function Options:AddCheck(id)
	return self:AddSetting('Check', id)
end

function Options:AddChoice(id, entries)
	local b = Options:AddSetting('DropChoice', id)
	b:AddChoices(entries)
	return b
end

function Options:AddSetting(class, id)
	local arg = id:gsub('^.', strlower)
	local b = self:Add(class, L[id])
	b:SetTip(L[id], L[id .. 'Tip'])
	b:SetValue(Addon.sets[arg])
	b:SetCall('OnInput', function(b, v)
		Addon.sets[arg] = v
		Addon:SendSignal('OPTIONS_CHANGED')
	end)

	return b
end
