--[[
	enemy.lua
		Abstract class that represents non-capturable pet
--]]

local ADDON, Addon = ...
local Enemy = Addon.Pet:NewClass('Enemy')

function Enemy:GetStats()
	return Addon.Predict:Stats(self.id, self.level, self.quality, self:GetBreed())
end

function Enemy:GetBreed()
	local breeds = Addon.SpecieBreeds[self.id]
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
