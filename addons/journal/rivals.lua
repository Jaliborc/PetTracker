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
local Journal = Addon:NewModule('RivalsJournal', _G[ADDON .. 'RivalsJournal'])
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)


--[[ Startup ]]--

function Journal:OnEnable()
	self.PanelTab = LibStub('SecureTabs-2.0'):Add(CollectionsJournal, self, L.Rivals)
	self:SetScript('OnShow', self.OnShow)
end

function Journal:OnShow()
	PetJournalTutorialButton:Hide()
	HybridScrollFrame_CreateButtons(self.List, ADDON..'RivalEntry', 44, 0)
	SetPortraitToTexture(self.portrait, 'Interface/Icons/PetJournalPortrait')

	self.Inset:Hide()
	self:SetScript('OnShow', nil)
	self.TitleText:SetText(L.Rivals)
	self.List.scrollBar.doNotHide = true
	self.Count.Label:SetText(L.TotalRivals)
	self.Count.Number:SetText(#Addon.RivalOrder)
	self.SearchBox:SetText(Addon.sets.rivalSearch or '')
	self.SearchBox:SetScript('OnTextChanged', function() self:Search(self.SearchBox:GetText()) end)

	self.Tab1.tip = TEAM
	self.Tab1.Icon:SetTexture('Interface/Icons/ability_hunter_pet_goto')
	self.Tab1.Icon:SetPoint('BOTTOM', 1, 1)
	self.Tab1.Icon:SetSize(27, 29)

	self.Tab2.tip = LOCATION_COLON:sub(0, -2)
	self.Tab2.Icon:SetTexture('Interface/Icons/inv_misc_map03')
	self.Tab2.Icon:SetPoint('BOTTOM', 1, 4)
	self.Tab2.Icon:SetSize(23, 23)

	self.Tab3.tip = HISTORY
	self.Tab3.Icon:SetTexture('Interface/Icons/achievement_challengemode_platinum')
	self.Tab3.Icon:SetPoint('BOTTOM', 1, 2)
	self.Tab3.Icon:SetSize(25, 25)

	self.Slots = Addon.JournalSlot:NewSet('TOP', self.Team, 0, 104)
	self.Team.Border.Text:SetText(L.EnemyTeam)
	self.History.LoadButton:SetText(L.LoadTeam)
	self.History.Empty:SetText(L.NoHistory)

	self.Map:SetMapID(2)
	self.Map.BorderFrame.Bg:Hide()
	self.Map.BorderFrame:SetFrameLevel(self.Map:GetPinFrameLevelsManager():GetValidFrameLevel('PIN_FRAME_LEVEL_TOPMOST')+1)
	self.Map:AddDataProvider(CreateFromMixins(MapExplorationDataProviderMixin))
	self.Map:AddDataProvider(CreateFromMixins(GroupMembersDataProviderMixin))

	for i = 1, 4 do
		local loot = CreateFrame('ItemButton', '$parentLoot' .. i, self.Card, ADDON..'Reward')
		loot:SetPoint('TOPRIGHT', -58 + 45 * (i % 2), - 45 * ceil(i/2))
		loot.Count:Show()

		self.Card[i] = loot
	end

	for i = 1, 9 do
		local record = Addon.BattleRecord(self.History)
		record:HookScript('OnClick', function() self.History:SetSelected(i) end)
		record:SetPoint('TOP', 0, 40-55*i)

		self.History[i] = record
	end

	self:SetRival(Addon.Rival(Addon.RivalOrder[1]))
	self:SetTab(1)
end


--[[ Actions ]]--

function Journal:SetRival(rival)
	self:Open()
	self.List.selected = rival
	self.List:update()
	self:Update()
end

function Journal:Search(text)
	Addon.sets.rivalSearch = text

	self:Open()
	self.SearchBox:SetText(text)
	self.SearchBox.Instructions:SetShown(text == '')
	self.List:update()
end

function Journal:SetTab(tab)
	for i = 1,3 do
		local selected = i == tab
		local tab = self['Tab' .. i]

		tab.Hider:SetShown(not selected)
		tab.Highlight:SetShown(not selected)
		tab.TabBg:SetTexCoord(0.01562500, 0.79687500,
			selected and 0.78906250 or 0.61328125, selected and 0.95703125 or 0.78125000)
	end

	self.Team:SetShown(tab == 1)
	self.Map:SetShown(tab == 2)
	self.History:SetShown(tab == 3)
	self.Card:SetShown(tab ~= 3)
	self:Update()
end

function Journal:Open()
	LibStub('SecureTabs-2.0'):Update(CollectionsJournal, self.PanelTab)
end


--[[ Redraw ]]--

function Journal.List:update()
	local self = Journal.List
	local off = HybridScrollFrame_GetOffset(self)
	local rivals = {}

	for i, id in pairs(Addon.RivalOrder) do
		local rival = Addon.Rival(id)
		if Addon:Search(rival, Addon.sets.rivalSearch) then
			tinsert(rivals, rival)
		end
	end

	for i, button in ipairs(self.buttons) do
		local rival = rivals[i + off]

		if rival then
			button.name:SetText(rival.name)
			button.model.level:SetText(rival:GetLevel())
			button.petTypeIcon:SetTexture(rival:GetTypeIcon())
			button.model.quality:SetVertexColor(rival:GetColor())
			button.selectedTexture:SetShown(rival.id == self.selected.id)

			if button.model:GetDisplayInfo() ~= rival.model then
				button.model:SetDisplayInfo(rival.model)
			end
		end

		button:SetShown(rival)
		button.rival = rival
	end

	HybridScrollFrame_Update(self, #rivals * 46, self:GetHeight())
end

function Journal:Update()
	local rival = self.List.selected

	if self.Card:IsShown() then
		self.Card:Display(rival)
	end

	if self.Team:IsShown() then
		for i, slot in ipairs(self.Slots) do
			slot:Display(rival[i])
		end
	end

	if self.Map:IsShown() then
			self.Map:Display(rival)
	end

	if self.History:IsShown() then
		self.History:Display(rival)
	end
end

function Journal.Card:Display(rival)
	self.name:SetText(rival.name)
	self.zone:SetText(rival:GetMapName())
	self.quest:SetShown(rival.quest ~= 0)

	if self.model:GetDisplayInfo() ~= rival.model then
		self.model:SetDisplayInfo(rival.model)
		self.model:SetRotation(.3)
	end

	for i, slot in ipairs(self) do
		slot:Hide()
	end

	if rival.quest ~= 0 then
		local completed = rival:IsCompleted()
		local rewards = rival:GetRewards()

		self.quest.status:SetText(rival:GetCompleteState())
		self.quest.icon:SetDesaturated(completed)
		self.quest.ring:SetDesaturated(completed)
		self.quest.id = rival.quest

		for i, loot in pairs(rewards) do
			local slot = self[i]
			slot.icon:SetTexture(loot.icon)
			slot.icon:SetDesaturated(completed)
			slot.Count:SetText(loot.count)
			slot.link = loot.link
			slot:Show()
		end

		if rival.gold > 0 then
			local slot = self[#rewards+1]
			slot.icon:SetTexture('Interface/icons/inv_misc_coin_01')
			slot.icon:SetDesaturated(completed)
			slot.Count:SetText(rival.gold)
			slot.link = nil
			slot:Show()
		end
	end
end

function Journal.Map:Display(rival)
	local scroll = self:GetCanvasContainer()
	local id = rival:GetMap() or C_Map.GetFallbackWorldMapID()
	if id ~= self:GetMapID() then
		self:SetMapID(id)
		tremove(scroll.zoomLevels, 1)
		self:ResetZoom()
	end

	if self.Destination then
		self.Destination:Release()
	end

	local x, y = rival:GetLocation()
	if x and y then
		local scale = scroll.zoomLevels[#scroll.zoomLevels].scale
		local minX, maxX, minY, maxY = scroll:CalculateScrollExtentsAtScale(scale)

		scroll:SetZoomTarget(scale)
		scroll:SetPanTarget(Clamp(x, minX, maxX), Clamp(y, minY, maxY))

		self.Destination = Addon.RivalPin(self, 1, x,y, rival)
	end
end

function Journal.History:Display(rival)
	local entries = Addon.sets.rivalHistory and Addon.sets.rivalHistory[rival.id] or {}
	self.Empty:SetShown(#entries == 0)
	self:SetSelected(nil)

	for i, data in ipairs(entries) do
		self[i]:Display(data)
	end

	for i = #entries+1, 9 do
		self[i]:Hide()
	end
end

function Journal.History:SetSelected(selected)
	for i = 1, 9 do
		self[i].Selected:SetShown(selected == i)
	end

	if selected then
		self.LoadButton:Enable()
		self.selected = selected
	else
		self.LoadButton:Disable()
	end
end

function Journal.History:LoadTeam()
	local record = self[self.selected]

	for i, pet in ipairs(record.pets) do
		C_PetJournal.SetPetLoadOutInfo(i, pet.id)

		for k, ability in ipairs(pet.abilities) do
			C_PetJournal.SetAbility(i, k, ability)
		end
	end
end
