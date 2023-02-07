--[[
Copyright 2012-2023 João Cardoso
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

local Sushi, Addon = LibStub('Sushi-3.1'), PetTracker
local Options = PetTracker:NewModule('Options', Sushi.OptionsGroup(CreateAtlasMarkup('Mobile-Pets', 14,14) .. ' PetTracker'))
local L = LibStub('AceLocale-3.0'):GetLocale('PetTracker')

local PATRONS = {{},{title='Jenkins',people={'Gnare','Justin Rusbatch','Seventeen','Grumpyitis','Justin Hall','Debora S Ogormanw','Johnny Rabbit'}},{title='Ambassador',people={'Julia F','Lolari ','Owen Pitcairn','Rafael Lins','Mediocre Monk','Joanie Nelson','Nitro ','Dodgen','Guidez ','Ptsdthegamer','Denise Mckinlay','Frosted(mrp)','Burt Humburg','Keks','Connie ','Adam Mann','Christie Hopkins','Kopernikus ','Bc Spear','Kendall Lane','Jury ','Dominik','Jeff Stokes','Tigran Andrew','Jeffrey Jones','Swallow@area52','Peter Hollaubek','Daniel  Di Battis','Teofan Bobarnea','Bobby Pagiazitis','Lars Norberg','Metadata','Michael Kinasz','Sam Ramji','The Patron'}}} -- generated patron list
local HELP_ICON = ' |T516770:13:13:0:0:64:64:14:50:14:50|t'
local FOOTER = 'Copyright 2012-2023 João Cardoso'


--[[ Startup ]]--

function Options:OnEnable()
	local faq = Sushi.OptionsGroup(self, HELP_LABEL .. HELP_ICON)
	faq:SetSubtitle(L.FAQDescription)
	faq:SetChildren(self.OnFAQ)
	faq:SetFooter(FOOTER)

	local credits = Sushi.CreditsGroup(self, PATRONS, 'Patrons |TInterface/Addons/PetTracker/art/patreon:12:12|t')
	credits:SetSubtitle('PetTracker is distributed for free and supported trough donations. A massive thank you to all the supporters on Patreon and Paypal who keep development alive. You can become a patron too at |cFFF96854patreon.com/jaliborc|r.', 'http://www.patreon.com/jaliborc')
	credits:SetFooter(FOOTER)

	self:SetCall('OnDefaults', self.OnDefaults)
	self:SetCall('OnChildren', self.OnMain)
	self:SetSubtitle(L.OptionsDescription)
	self:SetFooter(FOOTER)
end

function Options:OnDefaults()
	wipe(Addon.sets)
	wipe(Addon.state)

	Addon:SendSignal('OPTIONS_CHANGED')
	Addon:SendSignal('OPTIONS_RESET')
end

function Options:OnMain()
	self:Add('Header', TRACKING, GameFontHighlight, true)
	self:AddCheck('TrackPets')
	self:AddCheck('SpecieIcons')
	self:AddCheck('RivalPortraits')

	self:Add('Header', L.Source5, GameFontHighlight, true)
	self:AddCheck('Switcher')
	self:AddCheck('AlertUpgrades')
	self:AddCheck('Forfeit')
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
	b:SetValue(Addon.sets[arg])
	b:SetCall('OnInput', function(b, v)
		Addon.sets[arg] = v
		Addon:SendSignal('OPTIONS_CHANGED')
	end)

	return b
end
