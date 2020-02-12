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
local Predict = Addon:NewModule('Predict')

Predict.QualityScale = {1,1.1,1.2,1.3,1.4,1.5}
Predict.BreedStats = {
	[3] = {.5,.5,.5},
	[4] = {0,2,0},
	[5] = {0,0,2},
	[6] = {2,0,0},
	[7] = {.9,.9,0},
	[8] = {0,.9,.9},
	[9] = {.9,0,.9},
	[10] = {.4,.9,.4},
	[11] = {.4,.4,.9},
	[12] = {.9,.4,.4}
}

function Predict:Breed(specie, level, quality, health, power, speed)
	local base, breeds = Addon.SpecieStats[specie], Addon.SpecieBreeds[specie]
	if base then
		local leveled = self.QualityScale[quality] * level
		local best = 100
		local chosen = -1

		health = min(max((health / 5 - 20) / leveled - base[1], 0), 2)
		power  = min(max(power / leveled - base[2], 0), 2)
		speed  = min(max(speed / leveled - base[3], 0), 2)

		for i, breed in pairs(breeds) do
			local buff = self.BreedStats[breed]
			local off = abs(health - buff[1]) + abs(power - buff[2]) + abs(speed - buff[3])
			if off < best then
				chosen = breed
				best  = off
			end
		end

		return chosen
	end
end

function Predict:Stats(specie, level, quality, breed)
	local base = Addon.SpecieStats[specie]
	if base then
		local leveled = self.QualityScale[quality] * level
		local buff = self.BreedStats[breed]

		return floor((base[1] + buff[1]) * leveled * 5 + 100.5),
			   floor((base[1] + buff[1]) * leveled + .5),
			   floor((base[2] + buff[2]) * leveled + .5)
	end
end
