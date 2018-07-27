if not WoWUnit then
	return
end

local _, Addon = ...
local AreEqual, Replace = WoWUnit.AreEqual, WoWUnit.Replace
local Tests = WoWUnit('PetTracker.Static')


--[[ Values ]]--

function Tests.GetQualityColor()
	AreEqual({Addon.GetQualityColor(4)}, {GetItemQualityColor(3)})
	AreEqual({Addon.GetQualityColor(0)}, {1, .1, .1, 'ffff2020'})
end

function Tests:GetTypeIcon()
	local actual = Addon:GetTypeIcon(6)
	local expected = 'Interface/PetBattles/PetIcon-Magical'
	
	AreEqual(actual, expected)
end

function Tests:GetBreedIcon()
	AreEqual(Addon:GetBreedIcon(nil, 1), '')
	AreEqual(Addon:GetBreedIcon(1, .8), '')
	AreEqual(Addon:GetBreedIcon(3, 1), '|TInterface\\PetBattles\\PetBattle-StatIcons:22:22:0:0:32:32:16:32:0:16|t')
end


--[[ Utilities ]]--

function Tests:KeepShort()
	local short = strrep('a', 20)
	local long = strrep('a', 300)
	
	short = Addon.KeepShort(short)
	long = Addon.KeepShort(long)
	
	AreEqual(strlen(short), 20)
	AreEqual(strlen(long), 100)
end

function Tests:Date()
	local function test(day, month, year) 
		Replace('CalendarGetDate', function() return nil, month, day, year end)
		AreEqual({day, month, year}, {Addon.UnpackDate(Addon.GetDate())})
	end

	test(1, 1, 2014)
	test(1, 3, 2014)
	test(15, 3, 2014)
	test(31, 3, 2014)
	test(31, 12, 2014)
	test(1, 1, 2016)
	test(1, 3, 2016)
	test(31, 12, 2016)
end