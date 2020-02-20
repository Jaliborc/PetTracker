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

local MODULE =  ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local Toggle = Addon:NewModule('TrackToggle', CreateFrame('CheckButton', ADDON .. 'TrackToggle', PetJournal, 'InterfaceOptionsCheckButtonTemplate'))

function Toggle:OnEnable()
	self:Update()
	self:SetScript('OnClick', self.OnClick)
	self:RegisterSignal('OPTIONS_CHANGED', 'Update')
	self.Text:SetText(LibStub('AceLocale-3.0'):GetLocale(ADDON).TrackPets)
	self:SetPoint('RIGHT', CollectMeOpen2Button or PetJournalFindBattle, 'LEFT', -self.Text:GetWidth() - 15, -1)
end

function Toggle:OnClick()
	Addon.sets.trackPets = self:GetChecked()
	Addon:SendSignal('OPTIONS_CHANGED')
end

function Toggle:Update()
	self:SetChecked(Addon.sets.trackPets)
end
