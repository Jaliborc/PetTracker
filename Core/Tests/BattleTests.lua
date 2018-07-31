if not WoWUnit then
	return
end

local _, Addon = ...
local AreEqual, IsTrue, IsFalse, Replace = WoWUnit.AreEqual, WoWUnit.IsTrue, WoWUnit.IsFalse, WoWUnit.Replace
local Tests = WoWUnit('PetTracker.Battle')

local Battle, Journal = Addon.Battle, Addon.Journal
local Server = C_PetBattles
local Pet = Battle:Get()


--[[ Pets ]]--

function Tests:Get()
	local pet = Battle:Get(1, 3)
	AreEqual(1, pet.owner)
	AreEqual(3, pet.index)
end

function Tests:GetCurrent()
	Replace(Server, 'GetActivePet', function() return 1 end)
	AreEqual(1, Battle:GetCurrent(2).index)
end


--[[ Static ]]--

function Tests:AnyUpgrade()
	Replace(Battle, 'GetNum', function() return 2 end)
	Replace(Battle, 'IsUpgrade', function() return true end)
	IsTrue(Battle:AnyUpgrade())

	Replace(Battle, 'IsUpgrade', function() return false end)
	IsFalse(Battle:AnyUpgrade())
end

function Tests:GetRival()
	Replace(Battle, 'IsPvE', function() return true end)
	Replace(Battle, 'GetSpecie', function() return 1 end)
	AreEqual(Battle:GetRival(), nil)

	Replace(Battle, 'GetSpecie', function() return 872 end)
	AreEqual(Battle:GetRival(), 64330)
	Replace(Battle, 'GetSpecie', function() return 876 end)
	AreEqual(Battle:GetRival(), 65648)
end

function Tests:IsPvE()
	Replace(Server, 'IsPlayerNPC', function() return true end)
	AreEqual(Battle:IsPvE(), true)
	Replace(Server, 'IsPlayerNPC', function() return false end)
	AreEqual(Battle:IsPvE(), false)
end


--[[ Status ]]--

function Tests:IsAlive()
	Replace(Server, 'GetHealth', function() return 5 end)
	IsTrue(Pet:IsAlive())

	Replace(Server, 'GetHealth', function() return 0 end)
	IsFalse(Pet:IsAlive())
end

function Tests:IsUpgrade()
	Replace(Battle, 'GetBestOwned', function() return nil, 2, 17 end)
	Replace(Battle, 'IsWildBattle', function() return true end)

	local function Test(specie, quality, level)
		Replace(Pet, 'GetSpecie', function() return specie end)
		Replace(Pet, 'GetQuality', function() return quality end)
		Replace(Pet, 'GetLevel', function() return level end)
		return Pet:IsUpgrade()
	end

	IsFalse(Test(374, 1, 25))
	IsTrue(Test(374, 3, 1))

	IsFalse(Test(374, 2, 18))
	IsTrue(Test(374, 2, 19))

	IsFalse(Test(1124, 3, 1))
	IsFalse(Test(nil, 3, 1))
end


--[[ Other ]]--

function Tests:__index()
	local pet = Battle:Get(1, 2)
	local expected = {1, 2}

	Replace(Server, 'GetPetSpeciesID', function(...) return {...} end)
	AreEqual(expected, pet:GetSpecie())
end
