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

local _, Addon = ...
local Loader = Addon:NewModule('ConfigLoader')

function Loader:Startup()
	if (Addon.Sets.MainTutorial or 0) < 6 or (Addon.Sets.JournalTutorial or 0) < 7 then
		LoadAddOn('PetTracker_Config')
	else
		CreateFrame('Frame', nil, InterfaceOptionsFrame):SetScript('OnShow', function()
			LoadAddOn('PetTracker_Config')
		end)
	end
end
