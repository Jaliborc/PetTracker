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
local Battle = Addon.Battle
local Listener = Addon:NewModule('BattleListener', CreateFrame('Frame'))


--[[ Startup ]]--

function Listener:Startup()
	if not Addon.State.Casts then
		self:Reset()
	end

	self:Upgrade()
	self:RegisterEvent('PET_BATTLE_FINAL_ROUND')
	self:RegisterEvent('CHAT_MSG_PET_BATTLE_COMBAT_LOG')
	self:SetScript('OnEvent', function(self, event, ...)
		self[event](self, ...)
	end)
end

function Listener:Upgrade()
	if Addon.Sets.RivalHistory then
		for rival, games in pairs(Addon.Sets.RivalHistory) do
			for i = #games, 1, -1 do
				local data = games[i]
				local len = data:len()
				if len ~= 26 and len ~= 48 and len ~= 70 then
					if len == 82 and data:sub(15,18) == '0000' then -- MoP format
						games[i] = data:sub(1,14) .. data:sub(19,40) .. data:sub(45,66) .. data:sub(71, 82)
					else
						tremove(games, i) -- corrupted data
					end
				end
			end
		end
	else
		Addon.Sets.RivalHistory = {}
	end
end

function Listener:Reset()
	Addon.State.Casts = {{id = {}, turn = {}}, {id = {}, turn = {}}, {id = {}, turn = {}}}
	Addon.State.Turn = 0
end


--[[ Events ]]--

function Listener:CHAT_MSG_PET_BATTLE_COMBAT_LOG(message)
	local id = tonumber(message:match('^|T.-|t|cff......|HbattlePetAbil:(%d+)'))
	if id then
		local isHeal = message:find(ACTION_SPELL_HEAL)
		local isTargetEnemy = message:find(ENEMY)

		if (isHeal and isTargetEnemy) or not (isHeal or isTargetEnemy) then
			local pet = Battle:GetCurrent(LE_BATTLE_PET_ENEMY)
			local casts = Addon.State.Casts[pet.index]

			for i, ability in ipairs(pet:GetAbilities()) do
				if ability == id then
					local k = i % 3
					casts.turn[k] = Addon.State.Turn
					casts.id[k] = id
					return
				end
			end
		end
	else
		local round = message:match(PET_BATTLE_COMBAT_LOG_NEW_ROUND:gsub('%%d', '(%%d+)'))
		if round then
			Addon.State.Turn = tonumber(round)
		end
	end
end

function Listener:PET_BATTLE_FINAL_ROUND(winner)
	local rival = Battle:GetRival()
	if rival then
		local history = Addon.Sets.RivalHistory[rival] or {}
		local entry = tostring(winner) .. format('%03x', Addon.GetDate())

		for i = 1,3 do
			local id, spell1, spell2, spell3 = C_PetJournal.GetPetLoadOutInfo(i)
			if id then
				local health = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, i) / C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, i)

				entry = entry .. format('%01x', ceil(health * 15))
							  .. format('%03x', spell1) .. format('%03x', spell2) .. format('%03x', spell3)
							  .. id:sub(13)
			end
		end

		tinsert(history, 1, entry)
		if #history > 9 then
			tremove(history)
		end

		Addon.Sets.RivalHistory[rival] = history
	end

	self:Reset()
end
