--[[
Copyright 2012-2023 João Cardoso
All Rights Reserved
--]]

local Sushi, Addon = LibStub('Sushi-3.1'), PetTracker
local Options = PetTracker:NewModule('Options', Sushi.OptionsGroup(CreateAtlasMarkup('Mobile-Pets', 14,14) .. ' PetTracker'))
local L = LibStub('AceLocale-3.0'):GetLocale('PetTracker')

local PATRONS = {{},{title='Jenkins',people={'Gnare','Seventeen','Justin Hall','Debora S Ogormanw','Johnny Rabbit'}},{title='Ambassador',people={'Julia F','Lolari ','Rafael Lins','Joanie Nelson','Kopernikus ','Kelly Wolf','Dodgen','Nitro ','Guidez ','Ptsdthegamer','Denise Mckinlay','Burt Humburg','Swallow@area52','Adam Mann','Christie Hopkins','Bc Spear','Jury ','Jeff Stokes','Tigran Andrew','Jeffrey Jones','Peter Hollaubek','Bobby Pagiazitis','Michael Kinasz','Sam Ramji','Dave Burlingame','Syed Hamdani'}}} -- generated patron list
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
