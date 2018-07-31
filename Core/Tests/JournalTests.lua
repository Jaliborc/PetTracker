if not WoWUnit then
	return
end

local _, Addon = ...
local Tests = WoWUnit('PetTracker.Journal', 'PET_JOURNAL_LIST_UPDATE', 'GUILD_ROSTER_UPDATE')

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

function Tests:GetProgressIn()
	local qualities = {4, 1, 0, 0, 3, 3}
	local levels = {15, 15, 0, 0, 17, 18}
	local filled = {
		total = 6,
		
		[0] = {[0] = {3, 4}, total = 2},
		[1] = {[15] = {2}, total = 1},
		[2] = {total = 0},
		[3] = {[17] = {5}, [18] = {6}, total = 2},
		[4] = {[15] = {1}, total = 1},
	}

	local empty = {
		total = 0,

		[0] = {total = 0},
		[1] = {total = 0},
		[2] = {total = 0},
		[3] = {total = 0},
		[4] = {total = 0},
	}

	Replace(Journal, 'GetSpeciesIn', function(self, zone) return zone == 2 and qualities or {} end)
	Replace(Journal, 'GetBestOwned', function(self, specie) return nil, qualities[specie], levels[specie] end)
	
	AreEqual(empty, Journal:GetProgressIn(1))
	AreEqual(filled, Journal:GetProgressIn(2))
end

function Tests:GetSpeciesIn()
	local results = Journal:GetSpeciesIn(36)
	local expected = {
		424,
		391,
		309,
		395,
		646,
		266,
	}
	
	for _, specie in pairs(expected) do
		Exists(results[specie])
	end
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