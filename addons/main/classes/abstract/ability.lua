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
