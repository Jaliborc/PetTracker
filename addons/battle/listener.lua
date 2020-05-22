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

local MODULE =  ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local Listener = Addon:NewModule('BattleListener')


--[[ Startup ]]--

function Listener:OnEnable()
	if not Addon.state.casts then
		self:Reset()
	end

	self:RegisterSignal('OPTIONS_RESET', 'Reset')
	self:RegisterEvent('PET_BATTLE_FINAL_ROUND', 'OnWinner')
	self:RegisterEvent('CHAT_MSG_PET_BATTLE_COMBAT_LOG', 'OnMessage')
end

function Listener:Reset()
	Addon.sets.rivalHistory = Addon.sets.rivalHistory or {}
	Addon.state.casts = {{id = {}, turn = {}}, {id = {}, turn = {}}, {id = {}, turn = {}}}
	Addon.state.turn = 0
end


--[[ Events ]]--

function Listener:OnMessage(_, message)
	local id = tonumber(message:match('^|T.-|t|cff......|HbattlePetAbil:(%d+)'))
	if id then
		local isHeal = message:find(ACTION_SPELL_HEAL)
		local isTargetEnemy = message:find(ENEMY)

		if (isHeal and isTargetEnemy) or not (isHeal or isTargetEnemy) then
			local pet = Addon.Battle(LE_BATTLE_PET_ENEMY)
			local casts = Addon.state.casts[pet.index]

			for i, ability in ipairs(pet:GetAbilities()) do
				if ability == id then
					local k = i % 3
					casts.turn[k] = Addon.state.turn
					casts.id[k] = id
					return
				end
			end
		end
	else
		local round = message:match(PET_BATTLE_COMBAT_LOG_NEW_ROUND:gsub('%%d', '(%%d+)'))
		if round then
			Addon.state.turn = tonumber(round)
		end
	end
end

function Listener:OnWinner(_, winner)
	local rival = Addon.Battle:GetRival()
	if rival then
		local history = Addon.sets.rivalHistory[rival] or {}
		local entry = tostring(winner) .. format('%03x', self:GetDate())

		for i = 1,3 do
			local id, spell1, spell2, spell3 = C_PetJournal.GetPetLoadOutInfo(i)
			if id then
				entry = entry .. format('%01x', ceil(self:GetHealthPercentage(LE_BATTLE_PET_ALLY, i) * 15))
							  			.. format('%03x', spell1) .. format('%03x', spell2) .. format('%03x', spell3)
							  			.. id:sub(13)
			end
		end

		tinsert(history, 1, entry)
		if #history > 9 then
			tremove(history)
		end

		Addon.sets.rivalHistory[rival] = history
	end

	self:Reset()
end


--[[ API ]]--

function Listener:GetDate()
	local date = C_Calendar.GetDate()
	return (date.year-2014) * 31*12 + (date.month-1) * 31 + date.monthDay-1
end

function Listener:GetHealthPercentage(owner, i)
	return Saturate(C_PetBattles.GetHealth(owner, i) / C_PetBattles.GetMaxHealth(owner, i))
end
