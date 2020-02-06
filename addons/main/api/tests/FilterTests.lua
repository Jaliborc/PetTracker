local Tests = WoWUnit and WoWUnit('PetTracker.Filters')
if not Tests then return end

local _, Addon = ...
local IsTrue, IsFalse, Replace = WoWUnit.IsTrue, WoWUnit.IsFalse, WoWUnit.Replace

local Ram = Addon.Specie:Get(374)
local Rabbit = Addon.Specie:Get(378)
local Robot = Addon.Specie:Get(254)

local Aki = Addon.Rival:Get(66741)
local Zunta = Addon.Rival:Get(66126)

function Tests:Empty()
	IsTrue(Addon:Filter(Ram, ''))
end

function Tests:Name()
	IsTrue(Addon:Filter(Ram, 'Black'))
	IsFalse(Addon:Filter(Ram, 'White'))

	IsTrue(Addon:Filter(Aki, 'Aki'))
	IsFalse(Addon:Filter(Zunta, 'Aki'))
end

function Tests:Type()
	IsTrue(Addon:Filter(Ram, 'Crit'))
	IsFalse(Addon:Filter(Ram, 'Humanoid'))

	IsTrue(Addon:Filter(Aki, 'Dragon'))
	IsFalse(Addon:Filter(Zunta, 'Dragon'))
end

function Tests:Source()
	IsTrue(Addon:Filter(Ram, 'Battle'))
	IsFalse(Addon:Filter(Ram, 'Vendor'))
end

function Tests:Location()
	IsTrue(Addon:Filter(Ram, 'Forest'))
	IsFalse(Addon:Filter(Ram, 'Desert'))
end

function Tests:Quality()
	Replace(Addon.Journal, 'GetBestOwned', function(self, specie)
		return nil, specie == 378 and 1 or specie == 374 and 4 or 0, 1
	end)

	IsTrue(Addon:Filter(Rabbit, 'Poor'))
	IsTrue(Addon:Filter(Ram, 'Maximized Rare'))
	IsTrue(Addon:Filter(Robot, 'Not Maximized Missing None'))

	IsTrue(Addon:Filter(Aki, 'Legendary'))
	IsTrue(Addon:Filter(Zunta, 'Common'))
end
