local ADDON, Addon = ...
local Tests = WoWUnit and WoWUnit(ADDON .. '.Game')
if not Tests then return end


function Tests:C_Miscellaneous()
  C_Timer.After(0, function() end)
  C_Map.GetMapInfo(0)
  C_QuestLog.IsQuestFlaggedCompleted(0)
  C_DateAndTime.GetCurrentCalendarTime()
  C_CurrencyInfo.GetCurrencyInfo(0)
  C_CurrencyInfo.GetCurrencyLink(0,0)
end

function Tests:C_PetJournal()
  C_PetJournal.GetNumPetSources()
  C_PetJournal.GetPetLoadOutInfo(1)
  C_PetJournal.GetPetInfoByPetID('BattlePet-0-000000000000')
end
