local Tests = WoWUnit and WoWUnit('PetTracker.Journal', 'PET_JOURNAL_LIST_UPDATE')
if not Tests then return end

local _, Addon = ...
local AreEqual, Exists, Disable = WoWUnit.AreEqual, WoWUnit.Exists, WoWUnit.Disable
local Replace = WoWUnit.Replace
local Journal = Addon.Journal

local UncommonPet, RarePet, RareSpecie
if GetRealmName():find('(EU)') then
	UncommonPet = '???'
	RarePet = '0x000000000070C482'
	RareSpecie = 323
else
	UncommonPet = 'BattlePet-0-00000350627A'
	RarePet = 'BattlePet-0-000003506273'
	RareSpecie = 163
end


--[[ Listings ]]--

function Tests:GetSpeciesIn()
	local elwynn = Journal.GetSpeciesIn(37)
	local expected = {
		40,
		162,
		200,
	}

	for _, specie in pairs(expected) do
		Exists(elwynn[specie])
	end
end

function Tests:GetRivalsIn()
	local elwynn = Journal.GetRivalsIn(37)
	Exists(elwynn[64330])
end


--[[ Atomics ]]--

function Tests:GetBestOwned()
	AreEqual({RarePet, 4, 1}, {Journal:GetBestOwned(RareSpecie)})
	AreEqual({nil, 0, 0}, {Journal:GetBestOwned(nil)})
end

function Tests:GetQuality()
	AreEqual(3, Journal:GetQuality(UncommonPet))
end

function Tests:GetTypeIcon()
	local expected = Addon.GetTypeIcon(3)
	AreEqual(expected, Journal:GetTypeIcon(395))
end

function Tests:GetSource()
	AreEqual(5, Journal:GetSource(395))
	AreEqual(7, Journal:GetSource(200))
end
