hooksecurefunc('PetBattleUnitTooltip_UpdateForUnit', function(self, ...)
	local pet = Battle:Get(...)
	local icon = Icons[self] or self:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	icon:SetPoint('CENTER', self.Icon, 'TOPLEFT', 3, -2)
	icon:SetText(Addon:GetBreedIcon(pet:GetBreed(), .9))
	Icons[self] = icon

	self.CollectedText:SetText(pet:GetOwnedText() or NORMAL_FONT_COLOR_CODE .. L.NoneCollected .. FONT_COLOR_CODE_CLOSE)
end)

hooksecurefunc("PetBattleUnitFrame_UpdateDisplay", function(self)
	local frame = self:GetName() or ''
	local breed = Battle:Get(self.petOwner, self.petIndex):GetBreed()

	if self.Name and not frame:find('Tooltip') then
		self.Name:SetText((self.Name:GetText() or '') .. ' ' .. Addon:GetBreedIcon(breed, .8))
	end
end)
