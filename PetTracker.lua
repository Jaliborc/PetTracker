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

local ADDON, Addon = ...
local NewClass = LibStub('Poncho-1.0')
local Listener = CreateFrame('Frame', ADDON .. 'Listener')
Listener:SetScript('OnEvent', function(_, event) Addon[event](Addon) end)
Listener:RegisterEvent('PLAYER_ENTERING_WORLD')


--[[ API ]]--

function Addon:NewClass(type, name, ...)
	return self:NewModule(name, NewClass(type, ADDON .. name, nil, ...))
end

function Addon:NewModule(name, object)
	object = object or {}
	self[name] = object
	return object
end

function Addon:ForAllModules(key, ...)
	for name, module in pairs(Addon) do
		if type(module) == 'table' and module[key] then
			module[key](module, ...)
		end
	end
end


--[[ Events ]]--

function Addon:PLAYER_ENTERING_WORLD()
	PetTracker_State = PetTracker_State or {}
	PetTracker_Sets = PetTracker_Sets or {}

	self.Sets = PetTracker_Sets
	self.State = PetTracker_State
	self:ForAllModules('Startup')

	Listener:UnregisterEvent('PLAYER_ENTERING_WORLD')
	Listener:RegisterEvent('PET_JOURNAL_LIST_UPDATE')
end

function Addon:PET_JOURNAL_LIST_UPDATE()
	C_Timer.After(1, function() -- data on client doesnt update immediately every time
			self:ForAllModules('TrackingChanged')
	end)
end

_G[ADDON] = Addon
