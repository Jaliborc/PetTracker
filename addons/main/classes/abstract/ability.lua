--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local Ability = Addon.Entity:NewClass('Ability')

function Ability:New(id, pet, cooldown, requisite, certain)
  if id then
    return self:Bind{id = id, pet = pet, cooldown = cooldown ~= 0 and cooldown, requisite = requisite, certain = certain}
  end
end

function Ability:GetModifier(target)
  local _, _, icon, _,_,_, type, healing = self:GetInfo()
  return not healing and target and C_PetBattles.GetAttackModifier(type, target:GetType()) or 1
end

function Ability:GetType()
  return select(7, self:GetInfo())
end

function Ability:GetInfo()
  return C_PetBattles.GetAbilityInfoByID(self.id)
end
