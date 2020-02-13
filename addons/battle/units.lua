local MODULE =  ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
local Units = Addon:NewModule('Units')


--[[ Startup ]]--

function Units:OnEnable()
	hooksecurefunc('PetBattleUnitFrame_UpdateDisplay', function(p) self:UpdatePortrait(p) end)
  hooksecurefunc('PetBattleUnitTooltip_UpdateForUnit', function(t) self:UpdateTip(t) end)

  self.BreedIcons, self.Bangs = {}, {}
	self:RegisterSignal('COLLECTION_CHANGED', 'Update')
	self:RegisterSignal('BATTLE_STARTED', 'Update')
end

function Units:Update()
  PetBattleUnitFrame_UpdateDisplay(PetBattleFrame.ActiveAlly)
  PetBattleUnitFrame_UpdateDisplay(PetBattleFrame.ActiveEnemy)
end

function Units:UpdatePortrait(frame)
	local pet = Addon.Battle(frame.petOwner, frame.petIndex)
	local better = pet:IsUpgrade()
	if better or self.Bangs[frame] then
    self:GetBang(frame):SetShown(better)
  end

	if frame.Name and not (frame:GetName() or ''):find('Tooltip') then
		frame.Name:SetText((frame.Name:GetText() or '') .. ' ' .. pet:GetBreedIcon(.8))
	end
end

function Units:UpdateTip(tip)
	local pet = Addon.Battle(tip.petOwner, tip.petIndex)
	local icon = self.BreedIcons[tip] or tip:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	icon:SetPoint('CENTER', tip.Icon, 'TOPLEFT', 3, -2)
	icon:SetText(pet:GetBreedIcon(.9))

	tip.CollectedText:SetText(pet:GetOwnedText() or NORMAL_FONT_COLOR_CODE .. L.NoneCollected .. FONT_COLOR_CODE_CLOSE)
	self.BreedIcons[tip] = icon
end


--[[ Bangs ]]--

function Units:GetBang(frame)
	return self.Bangs[frame] or self:NewBang(frame)
end

function Units:NewBang(frame)
	local size = max(frame.Icon:GetHeight() / 2.5, 18)
	local bang = frame:CreateTexture(nil, 'OVERLAY')
	bang:SetTexture('Interface/GossipFrame/AvailableQuestIcon')
	bang:SetPoint('TOP', frame.Icon, 'TOPRIGHT', -2, -10)
	bang:SetSize(size, size)

	self.Bangs[frame] = bang
	return bang
end
