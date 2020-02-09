--[[
	enemy.lua
		Abstract class that represents non-capturable pet
--]]

local ADDON, Addon = ...
local Enemy = Addon.Pet:NewClass('Enemy')

function Enemy:New(data)
  return self:Bind(data)
end

function Enemy:GetStats()
	return Addon.Predict:Stats(self.specie, self.level, self.quality, self:GetBreed())
end

function Enemy:GetBreed()
	local breeds = Addon.SpecieBreeds[self.specie]
	return breeds and breeds[1] or 3
end

function Enemy:GetAbility(i)
	local abilities = self:GetAbilities()
	for _, id in pairs(abilities) do
		i = i - 1
		if i == 0 then
			return id, nil, nil, true
		end
	end
end

for _, key in pairs {'Name', 'Specie', 'Model', 'Level', 'Quality'} do
	Enemy['Get' .. key] = function(self)
		return self[key:lower()]
	end
end
