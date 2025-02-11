--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local MODULE =  ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local Mods = Addon:NewModule('JournalMods')

local STAT_NAMES = {PET_BATTLE_STAT_HEALTH, PET_BATTLE_STAT_POWER, PET_BATTLE_STAT_SPEED}
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)


--[[ Startup ]]--

function Mods:OnLoad()
  hooksecurefunc('PetJournal_UpdatePetCard', function(...) self:ModifyCard(...) end)
  hooksecurefunc('PetJournal_UpdatePetLoadOut', function(...) self:ModifyLoadOut(...) end)
end

function Mods:ModifyCard(card)
  if card.petID then
    local pet = Addon.Pet(card.petID)
    local breeds = pet:GetAvailableBreeds()
    if breeds then
      card.PetInfo.sourceText = format('%s\n%s%s:%s %s', card.PetInfo.sourceText, NORMAL_FONT_COLOR_CODE, L.AvailableBreeds, FONT_COLOR_CODE_CLOSE, breeds)
    end

    local footer = card.QualityFrame
    if footer:IsShown() then
      footer:SetWidth(150)
      footer:GetRegions():Hide()
      footer:SetScript('OnEnter', function() self:OnEnter(footer) end)
      footer:SetScript('OnLeave', function() self:OnLeave(footer) end)
      footer.quality:SetText(pet:GetBreedIcon(.75, -3,-1) .. footer.quality:GetText() .. ' ' .. pet:GetBreedName())
      footer.quality:SetPoint('LEFT', 4, 0)
      footer.pet = pet
    end
  end
end

function Mods:ModifyLoadOut()
  for i = 1, NUM_BATTLE_PETS_IN_BATTLE do
    local slot = PetJournal.Loadout['Pet'..i]
    if slot.petID then
      slot.name:SetText((slot.name:GetText() or '') .. Addon.Pet(slot.petID):GetBreedIcon(.75, 3,-1))
    end
  end
end


--[[ Scripts ]]--

function Mods:OnEnter(frame)
  local tip = Addon.MultiTip()
  tip:SetOwner(frame, 'ANCHOR_RIGHT', -54, 0)
  tip:AddHeader(PET_BATTLE_STAT_QUALITY)
  tip:AddLine(PET_BATTLE_TOOLTIP_RARITY)
  tip:AddHeader(L.Breed)
  tip:AddLine(L.BreedExplanation)

  local breed = frame.pet:GetBreed()
  if breed then
    tip:AddLine('\n' .. Addon.Breeds:Name(breed), 1,1,1)

    for stat, bonus in ipairs(Addon.Predict.BreedStats[breed] or {}) do
      if bonus > 0 then
        tip:AddLine(format('+ %d%% %s', bonus*50, STAT_NAMES[stat]))
      end
    end
  end

  tip:Show()
  self.Tip = tip
end

function Mods:OnLeave()
  self.Tip:Release()
end
