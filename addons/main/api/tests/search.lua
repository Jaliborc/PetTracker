local Tests = WoWUnit and WoWUnit('PetTracker.Filters')
if not Tests then return end

local ADDON, Addon = ...
local IsTrue, IsFalse, Replace = WoWUnit.IsTrue, WoWUnit.IsFalse, WoWUnit.Replace

local Ram = Addon.Specie:Get(374)
local Rabbit = Addon.Specie:Get(378)
local Robot = Addon.Specie:Get(254)

local Aki = Addon.Rival:Get(66741)
local Zunta = Addon.Rival:Get(66126)


--[[ Tests ]]--

function Tests:Empty()
	IsTrue(Addon:Search(Ram, ''))
end

function Tests:Name()
	IsTrue(Addon:Search(Ram, 'Black'))
	IsFalse(Addon:Search(Ram, 'White'))

	IsTrue(Addon:Search(Aki, 'Aki'))
	IsFalse(Addon:Search(Zunta, 'Aki'))
end

function Tests:Type()
	IsTrue(Addon:Search(Ram, 'Crit'))
	IsFalse(Addon:Search(Ram, 'Humanoid'))

	IsTrue(Addon:Search(Aki, 'Dragon'))
	IsFalse(Addon:Search(Zunta, 'Dragon'))
end

function Tests:Source()
	IsTrue(Addon:Search(Ram, 'Battle'))
	IsFalse(Addon:Search(Ram, 'Vendor'))
end

function Tests:Location()
	IsTrue(Addon:Search(Ram, 'Forest'))
	IsFalse(Addon:Search(Ram, 'Desert'))
end

function Tests:Quality()
	Replace(Addon.Journal, 'GetBestOwned', function(self, specie)
		return nil, specie == 378 and 1 or specie == 374 and 4 or 0, 1
	end)

	IsTrue(Addon:Search(Rabbit, 'Poor'))
	IsTrue(Addon:Search(Ram, 'Maximized Rare'))
	IsTrue(Addon:Search(Robot, 'Not Maximized Missing None'))

	IsTrue(Addon:Search(Aki, 'Legendary'))
	IsTrue(Addon:Search(Zunta, 'Common'))
end
