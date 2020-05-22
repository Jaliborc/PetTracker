local ADDON, Addon = ...
local Tests = WoWUnit and WoWUnit(ADDON .. '.Search')
if not Tests then return end


--[[ Locals ]]--

local IsTrue, IsFalse = WoWUnit.IsTrue, WoWUnit.IsFalse
local Replace = WoWUnit.Replace

local Ram = Addon.Specie(374)
local Rabbit = Addon.Specie(378)
local Robot = Addon.Specie(254)

local Aki = Addon.Rival(66741)
local Zunta = Addon.Rival(66126)


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
	Replace(Addon.Pet, 'GetBestOwned', function(self)
		return nil, self:GetSpecie() == 378 and 1 or self:GetSpecie() == 374 and 4 or 0, 1
	end)

	IsTrue(Addon:Search(Rabbit, 'Poor'))
	IsTrue(Addon:Search(Ram, 'Maximized Rare'))
	IsTrue(Addon:Search(Robot, 'Not Maximized Missing None'))

	IsTrue(Addon:Search(Aki, 'Legendary'))
	IsTrue(Addon:Search(Zunta, 'Common'))
end
