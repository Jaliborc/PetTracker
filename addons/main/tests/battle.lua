local Tests = WoWUnit and WoWUnit('PetTracker.Battle')
if not Tests then return end

local ADDON, Addon = ...
local AreEqual, IsTrue, IsFalse, Replace = WoWUnit.AreEqual, WoWUnit.IsTrue, WoWUnit.IsFalse, WoWUnit.Replace
local Pet = Addon.Battle:Get()


--[[ Pets ]]--

function Tests:Get()
	local pet = Addon.Battle:Get(1, 3)
	AreEqual(1, pet.owner)
	AreEqual(3, pet.index)
end

function Tests:GetCurrent()
	Replace(C_PetBattles, 'GetActivePet', function() return 1 end)
	AreEqual(1, Addon.Battle:GetCurrent(2).index)
end


--[[ Static ]]--

function Tests:AnyUpgrade()
	Replace(Addon.Battle, 'GetNum', function() return 2 end)
	Replace(Addon.Battle, 'IsUpgrade', function() return true end)
	IsTrue(Addon.Battle:AnyUpgrade())

	Replace(Addon.Battle, 'IsUpgrade', function() return false end)
	IsFalse(Addon.Battle:AnyUpgrade())
end

function Tests:GetRival()
	Replace(Addon.Battle, 'IsPvE', function() return true end)
	Replace(Addon.Battle, 'GetSpecie', function() return 1 end)
	AreEqual(Addon.Battle:GetRival(), nil)

	Replace(Addon.Battle, 'GetSpecie', function() return 872 end)
	AreEqual(Addon.Battle:GetRival(), 64330)
	Replace(Addon.Battle, 'GetSpecie', function() return 876 end)
	AreEqual(Addon.Battle:GetRival(), 65648)
end

function Tests:IsPvE()
	Replace(C_PetBattles, 'IsPlayerNPC', function() return true end)
	AreEqual(Addon.Battle:IsPvE(), true)
	Replace(C_PetBattles, 'IsPlayerNPC', function() return false end)
	AreEqual(Addon.Battle:IsPvE(), false)
end


--[[ Status ]]--

function Tests:IsAlive()
	Replace(C_PetBattles, 'GetHealth', function() return 5 end)
	IsTrue(Pet:IsAlive())

	Replace(C_PetBattles, 'GetHealth', function() return 0 end)
	IsFalse(Pet:IsAlive())
end

function Tests:IsUpgrade()
	Replace(Addon.Battle, 'GetBestOwned', function() return nil, 2, 17 end)
	Replace(Addon.Battle, 'IsWildBattle', function() return true end)

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
	local pet = Addon.Battle:Get(1, 2)
	local expected = {1, 2}

	Replace(C_PetBattles, 'GetPetSpeciesID', function(...) return {...} end)
	AreEqual(expected, pet:GetSpecie())
end
