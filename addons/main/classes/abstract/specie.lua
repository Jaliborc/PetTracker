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
local Specie = Addon.Pet:NewClass('Specie')

function Specie:New(specie)
	return self:Bind{specie = specie}
end

function Specie:GetID()
	return self:GetBestOwned():GetID()
end

function Specie:GetQuality()
	return select(2, self:GetBestOwned())
end

function Specie:GetLevel()
	return select(3, self:GetBestOwned())
end

function Specie:GetSpecie()
	return self.specie
end
