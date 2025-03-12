--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local MODULE =  ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local Listener = Addon:NewModule('BattleListener')


--[[ Startup ]]--

function Listener:OnLoad()
	if not Addon.state.history then
		self:Reset()
	end

	self:RegisterSignal('OPTIONS_RESET', 'Reset')
	self:RegisterEvent('PET_BATTLE_FINAL_ROUND', 'OnWinner')
	self:RegisterEvent('CHAT_MSG_PET_BATTLE_COMBAT_LOG', 'OnMessage')
end

function Listener:Reset()
	Addon.sets.history = Addon.sets.history or {}
	Addon.state.casts = {{id = {}, turn = {}}, {id = {}, turn = {}}, {id = {}, turn = {}}}
	Addon.state.turn = 0
end


--[[ Events ]]--

function Listener:OnMessage(message)
	local id = tonumber(message:match('^|T.-|t|cff......|HbattlePetAbil:(%d+)'))
	if id then
		local isHeal = message:find(ACTION_SPELL_HEAL)
		local isTargetEnemy = message:find(ENEMY)

		if (isHeal and isTargetEnemy) or not (isHeal or isTargetEnemy) then
			local pet = Addon.Battle(Enum.BattlePetOwner.Enemy)
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

function Listener:OnWinner(winner)
	local rival = Addon.Battle:GetRival()
	if rival then
		local history = Addon.sets.history[rival] or {}
		local entry = format('%d:%x:', tostring(winner), self:GetDate())

		for i = 1,3 do
			local id, spell1, spell2, spell3 = C_PetJournal.GetPetLoadOutInfo(i)
			if id then
				entry = entry .. format('%01x:%x:%x:%x:%s:', ceil(self:GetHealthPercentage(Enum.BattlePetOwner.Ally, i) * 15), spell1, spell2, spell3, id:sub(13))
			end
		end

		tinsert(history, 1, entry)
		if #history > 9 then
			tremove(history)
		end

		Addon.sets.history[rival] = history
	end

	self:Reset()
end


--[[ API ]]--

function Listener:GetDate()
	local date = C_DateAndTime.GetCurrentCalendarTime()
	return (date.year-2014) * 31*12 + (date.month-1) * 31 + date.monthDay-1
end

function Listener:GetHealthPercentage(owner, i)
	return Saturate(C_PetBattles.GetHealth(owner, i) / C_PetBattles.GetMaxHealth(owner, i))
end
