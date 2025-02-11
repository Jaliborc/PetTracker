--[[
Copyright 2012-2025 João Cardoso
All Rights Reserved
--]]

local ADDON, Addon = ...
local Specie = Addon.Pet:NewClass('Specie')

function Specie:New(specie)
	return self:Bind{specie = specie}
end

function Specie:GetID()
	local best = self:GetBestOwned()
	return best and best:GetID()
end

function Specie:GetQuality()
	return select(2, self:GetBestOwned())
end

function Specie:GetLevel()
	return select(3, self:GetBestOwned())
end

function Specie:GetSpecie()
	return self.specie
end
