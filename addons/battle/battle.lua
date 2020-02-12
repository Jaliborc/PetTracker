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
local Battle = Addon.Pet:NewClass('Battle')


--[[ Static ]]--

function Battle:AnyUpgrade()
	for i = 1, self:NumPets(LE_BATTLE_PET_ENEMY) do
		local pet = self(LE_BATTLE_PET_ENEMY, i)
		if pet:IsUpgrade() then
			return true
		end
	end
end

function Battle:GetRival()
	if self:IsPvE() then
		local specie1 = self(LE_BATTLE_PET_ENEMY, 1):GetSpecie()
		local specie2 = self(LE_BATTLE_PET_ENEMY, 2):GetSpecie()
		local specie3 = self(LE_BATTLE_PET_ENEMY, 3):GetSpecie()

		for id, rival in pairs(Addon.RivalInfo) do
			local first = tonumber(rival:match('^[^:]+:[^:]+:[^:]*:[^:]+:%w%w%w%w(%w%w%w)'), 36)
			if first == specie1 or first == specie2 or first == specie3 then
				return id
			end
		end
	end
end

function Battle:IsPvE()
	return C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY)
end

function Battle:NumPets(owner)
	return C_PetBattles.GetNumPets(owner)
end

function Battle:New(owner, index)
	return self:Bind{owner = owner, index = index or C_PetBattles.GetActivePet(owner)}
end


--[[ Instance ]]--

function Battle:IsUpgrade()
	if self:IsWildBattle() and not self:IsAlly() then
		if self:GetSpecie() and self:GetSource() == 5 then
			local _, quality, level = self:GetBestOwned()

			if self:GetQuality() > quality then
				return true

			elseif self:GetQuality() == quality then
				if level > 20 then
					level = level + 2
				elseif level > 15 then
					level = level + 1
				end

				return self:GetLevel() > level
			end
		end
	end

	return false
end

function Battle:CanSwap()
	return self:IsAlly() and C_PetBattles.CanPetSwapIn(self.index)
end

function Battle:IsAlly()
	return self.owner ~= LE_BATTLE_PET_ENEMY
end

function Battle:IsAlive()
	return self:GetHealth() > 0
end

function Battle:Exists()
	return self:NumPets(self.owner) >= self.index
end


--[[ Overrides ]]--

function Battle:GetAbility(i)
	local abilities, levels = self:GetAbilities()

	if self:IsAlly() or self:IsPvE() then
		if i < 4 then
			local usable, cooldown = self:GetAbilityState(i)
			local requisite = not (cooldown or usable) and levels[i]
			local id = self:GetAbilityInfo(i) or abilities[i]

			return Addon.Ability(id, self, cooldown, requisite, true)
		end
	else
		local k = i % 3
		local casts = Addon.state.casts[self.index]
		if not casts.id[k] and self:GetLevel() >= max(levels[i], levels[i+3] or 0) then
			return Addon.Ability(abilities[i], self)
		end

		if i < 4 then
			local id = casts.id[k] or abilities[i]
			local cooldown = select(4, C_PetBattles.GetAbilityInfoByID(id)) or 0
			local requisite = self:GetLevel() < levels[i] and levels[i]
			local remaining = casts.turn[k] and (cooldown + casts.turn[k] - Addon.state.Turn) or 0

			return Addon.Ability(id, self, remaining, requisite, true)
		end
	end
end

function Battle:GetStats()
	local speedScale  = self:GetStateValue(25)
	local healthScale = self:GetStateValue(99)
	local healthBonus = self:GetStateValue(2)

	if speedScale and healthScale and healthBonus then
		speedScale  = 100/(speedScale+100)
		healthScale = 100/(healthScale+100)

		local isWild = self:IsWildBattle() and not self:IsAlly()
		local healthNerf = isWild and 1.2 or 1
		local powerNerf = isWild and 1.25 or 1

		return floor((self:GetMaxHealth() * healthScale - healthBonus) * healthNerf + .5),
			   floor(self:GetPower() * powerNerf + .5),
			   floor(self:GetSpeed() * speedScale + .5)
	end
end

function Battle:GetSpecie()
	return self:GetPetSpeciesID()
end

function Battle:GetModel()
	return self:GetDisplayID()
end

function Battle:GetQuality()
	return self:GetBreedQuality()
end

function Battle:GetType()
	return self:GetPetType()
end

for k,v in pairs(C_PetBattles) do
	Battle[k] = rawget(Battle, k) or function(self, ...) return C_PetBattles[k](self.owner, self.index, ...) end
end
