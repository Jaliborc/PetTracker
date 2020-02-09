--[[
	abilityButton.lua
		Class that defines common pin behavior
--]]

local ADDON, Addon = ...
local Ability = Addon.Base:NewClass('AbilityButton')
Ability:NewClass('AbilityAction', 'Button', 'PetBattleAbilityButtonTemplate')
Ability:NewClass('AbilityButton', 'Button', true)


--[[ Construct ]]--

function Ability:Construct()
	local f = self:Super(Ability):Construct()
	b:SetScript('OnEnter', f.OnEnter)
	b:SetScript('OnLeave', f.OnLeave)
	b:SetScript('OnEvent', nil)
	b:SetScript('OnClick', nil)
	return f
end

function Ability:Display(pet, i, target)
	local id, cooldown, requisite, certain = pet:GetAbility(i)
	if id then
		local unusable = cooldown or requisite
		local color = (unusable or not certain) and .5 or 1
		local _, _, icon, _,_,_, type, healing = C_PetBattles.GetAbilityInfoByID(id)
		local modifier = not healing and target and C_PetBattles.GetAttackModifier(type, target) or 1

		self.BetterIcon:SetTexture('Interface/PetBattles/BattleBar-AbilityBadge-' .. (modifier > 1 and 'Strong' or 'Weak'))
		self.BetterIcon:SetShown(modifier ~= 1)

		self.Icon:SetTexture(icon)
		self.Icon:SetDesaturated(unusable)
		self.Icon:SetVertexColor(color, color, color)
		self.Lock:SetShown(requisite)

		self.Cooldown:SetText(cooldown or "")
		self.CooldownShadow:SetShown(cooldown)
		self.Cooldown:SetShown(cooldown)

		if self.Type then
			self.Type:SetTexture(Addon.GetTypeIcon(type))
		end

		self.pet, self.id = pet, id
		self.text = requisite
	end

	self:SetShown(id)
end


--[[ Tooltips ]]--

function Ability:OnEnter()
	if self.pet.owner then
		PetBattleAbilityTooltip_SetAbilityByID(self.pet:GetOwner(), self.pet:GetID(), self.id, self.text and PET_ABILITY_REQUIRES_LEVEL:format(self.text))
		PetBattleAbilityTooltip_Show('BOTTOM', self, 'TOP')
	else
		local real = FloatingPetBattleAbilityTooltip
		FloatingPetBattleAbilityTooltip = PetBattlePrimaryAbilityTooltip

		FloatingPetBattleAbility_Show(self.id, self.pet:GetStats())
		FloatingPetBattleAbilityTooltip:ClearAllPoints()
		FloatingPetBattleAbilityTooltip:SetPoint('TOPLEFT', self, 'TOPRIGHT', 5, 0)
		FloatingPetBattleAbilityTooltip = real
	end
end

function Ability:OnLeave()
	PetBattlePrimaryAbilityTooltip:Hide()
end
