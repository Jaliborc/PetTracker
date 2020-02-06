local GetInfo, GetModifier = C_PetBattles.GetAbilityInfoByID, C_PetBattles.GetAttackModifier

function SortComparison(target, others)
	local pets = {}
	local scores = {}

	for _, pet in pairs(others) do
		local score = ComparePets(target, pet)
		local i = 1

		while scores[i] and scores[i] > score do
			i = i + 1
		end

		tinsert(pets, i, pet)
		tinsert(scores, i, score)
	end

	return pets, scores
end

function ComparePets(a, b)
	return CompareOffense(a, b) / CompareOffense(b, a)
end

local function GetAbilityModifier(self, i, family) 
	local id, _, locked = self:GetAbility(i)
	if id and not locked then
		local _,_,_,_,_,_, type, healing = GetInfo(id)
		if not healing then
			return GetModifier(type, family)
		end
	end
end

function CompareOffense(a, b)
	local family = b:GetType()
	local score, count = 0, 0

	for i = 1, 3 do
		local first = GetAbilityModifier(a, i, family)
		local second = GetAbilityModifier(a, i+3, family)
		local modifier = first and second and (max(first, second)+first+second)/3 or first or second

		if modifier then
			score = score + modifier
			count = count + 1
		end
	end

	return score / count
end

--[[local Cat = PetTracker.Specie:Get(224)
local Bear = PetTracker.Specie:Get(202)
local Critter =  PetTracker.Specie:Get(374)
local Robot =  PetTracker.Specie:Get(254)
local Ghost =  PetTracker.Specie:Get(190)

local pets, scores = SortComparison(Critter, {Ghost, Robot, Bear, Cat})
for i, pet in ipairs(pets) do
	print(pet:GetInfo(), scores[i])
end]]--