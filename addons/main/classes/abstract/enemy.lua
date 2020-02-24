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
local Enemy = Addon.Pet:NewClass('Enemy')

function Enemy:New(data)
  return self:Bind(data)
end

function Enemy:GetStats()
	return Addon.Predict:Stats(self:GetSpecie(), self:GetLevel(), self:GetQuality(), self:GetBreed())
end

function Enemy:GetBreed()
	local breeds = Addon.SpecieBreeds[self:GetSpecie()]
	return breeds and breeds[1] or 3
end

function Enemy:GetAbility(i)
	local abilities = self:GetAbilities()
	for _, id in pairs(abilities) do
		i = i - 1
		if i == 0 then
			return Addon.Ability(id, self, nil, nil, true)
		end
	end
end

for _, key in pairs {'Name', 'Specie', 'Model', 'Level', 'Quality'} do
	Enemy['Get' .. key] = function(self)
		return self[key:lower()]
	end
end
