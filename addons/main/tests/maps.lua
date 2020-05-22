local ADDON, Addon = ...
local Tests = WoWUnit and WoWUnit(ADDON .. '.Maps')
if not Tests then return end


--[[ Locals ]]--

local AreEqual, IsTrue = WoWUnit.AreEqual, WoWUnit.IsTrue
local Durotar = Addon.Maps:GetProgressIn(1)


--[[ Tests ]]--

function Tests:ProgressStructure()
  AreEqual(#Durotar, Addon.MaxQuality)
  AreEqual(type(Durotar[0]), 'table')
end

function Tests:ProgressTotals()
  AreEqual(type(Durotar[0].total), 'number')
  AreEqual(type(Durotar.total), 'number')
end

function Tests:ProgressContent()
  AreEqual(type(Durotar[0][0]), 'table')
  IsTrue(#Durotar[0][0] > 0)
end
