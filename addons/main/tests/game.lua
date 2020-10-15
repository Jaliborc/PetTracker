local ADDON, Addon = ...
local Tests = WoWUnit and WoWUnit(ADDON .. '.Game')
if not Tests then return end

function Tests:GeneralAPI()
  C_Timer.After(0, function() end)
  C_Map.GetMapInfo(0)
  C_QuestLog.IsQuestFlaggedCompleted(0)
  C_DateAndTime.GetCurrentCalendarTime()
end

function Tests:PetJournal()
  C_PetJournal.GetNumPetSources()
  C_PetJournal.GetPetLoadOutInfo(0)
  C_PetJournal.GetPetInfoByPetID(0)
end
