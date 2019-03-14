--[[
Copyright 2012-2019 João Cardoso
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

local _, Addon = ...
local Predict = Addon:NewModule('Predict')


function Predict:Breed(specie, level, rarity, health, power, speed)
	local base, breeds = Addon.Stats[specie], Addon.Breeds[specie]

	if base then
		local leveled = Addon.QualityScale[rarity] * level

		health = health / 5 - 20
		health = min(max(health / leveled - base[1], 0), 2)
		power  = min(max(power / leveled - base[2], 0), 2)
		speed  = min(max(speed / leveled - base[3], 0), 2)

		local best = 100
		local chosen = -1

		for i, breed in pairs(breeds) do
			local buff = Addon.BreedStats[breed]
			local off = abs(health - buff[1]) + abs(power - buff[2]) + abs(speed - buff[3])
			if off < best then
				chosen = breed
				best  = off
			end
		end

		return chosen
	end
end

function Predict:Stats(specie, level, rarity, breed)
	local base = Addon.Stats[specie]

	if base then
		local leveled = Addon.QualityScale[rarity] * level
		local buff = Addon.BreedStats[breed]

		return floor((base[1] + buff[1]) * leveled * 5 + 100.5),
			   floor((base[1] + buff[1]) * leveled + .5),
			   floor((base[2] + buff[2]) * leveled + .5)
	end
end