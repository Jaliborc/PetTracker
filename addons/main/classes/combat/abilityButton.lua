--[[
	abilityButton.lua
		Class that defines common pin behavior
--]]

local ADDON, Addon = ...
local Ability = Addon.Base:NewClass('AbilityButton')
Ability:NewClass('AbilityAction', 'Button', 'PetBattleAbilityButtonTemplate')
Ability:NewClass('AbilityDisplay', 'Button', true)


--[[ Construct ]]--

function Ability:Construct()
	local b = self:Super(Ability):Construct()
	b:SetScript('OnEnter', b.OnEnter)
	b:SetScript('OnLeave', b.OnLeave)
	b:SetScript('OnEvent', nil)
	b:SetScript('OnClick', nil)
	return b
end

function Ability:Display(ability, target)
	if ability then
		local unusable = ability.cooldown or ability.requisite
		local color = (unusable or not ability.certain) and .5 or 1
		local modifier = ability:GetModifier(target)

		self.BetterIcon:SetTexture('Interface/PetBattles/BattleBar-AbilityBadge-' .. (modifier > 1 and 'Strong' or 'Weak'))
		self.BetterIcon:SetShown(modifier ~= 1)

		self.Icon:SetTexture(select(3, ability:GetInfo()))
		self.Icon:SetVertexColor(color, color, color)
		self.Lock:SetShown(ability.requisite)
		self.Icon:SetDesaturated(unusable)

		self.Cooldown:SetText(ability.cooldown or '')
		self.CooldownShadow:SetShown(ability.cooldown)
		self.Cooldown:SetShown(ability.cooldown)

		if self.Type then
			self.Type:SetTexture(ability:GetTypeIcon())
		end
	end

	self.ability = ability
	self:SetShown(ability)
end


--[[ Tooltips ]]--

function Ability:OnEnter()
	local pet = self.ability.pet
	if pet.owner then
		PetBattleAbilityTooltip_SetAbilityByID(pet.owner, pet.index, self.ability.id, self.ability.requisite and PET_ABILITY_REQUIRES_LEVEL:format(self.ability.requisite))
		PetBattleAbilityTooltip_Show('BOTTOM', self, 'TOP')
	else
		local real = FloatingPetBattleAbilityTooltip
		FloatingPetBattleAbilityTooltip = PetBattlePrimaryAbilityTooltip
		FloatingPetBattleAbility_Show(self.ability.id, pet:GetStats())
		FloatingPetBattleAbilityTooltip:ClearAllPoints()
		FloatingPetBattleAbilityTooltip:SetPoint('TOPLEFT', self, 'TOPRIGHT', 5, 0)
		FloatingPetBattleAbilityTooltip = real
	end
end

function Ability:OnLeave()
	PetBattlePrimaryAbilityTooltip:Hide()
end
