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
local Specie = Addon:NewModule('Specie')
local Journal = Addon.Journal


--[[ API ]]--

function Specie:Get(specie)
	return setmetatable({id = specie}, self)
end

function Specie:GetAbstract()
	local name, _,_,_, source, description = self:GetInfo()
	local family = self:GetTypeName()

	return strjoin(' ', name, family, source, description)
end

function Specie:GetQuality()
	return select(2, self:GetBestOwned())
end

function Specie:GetLevel()
	return select(3, self:GetBestOwned())
end

function Specie:GetSpecie()
	return self.id
end


--[[ Metamagic ]]--

setmetatable(Specie, {__index = function(Specie, key)
	Specie[key] = Journal[key] and function(self, ...)
		return Journal[key](Journal, self:GetSpecie(), ...)
	end

	return rawget(Specie, key)
end}).__index = Specie
