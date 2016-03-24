modifier_old_lina_ultimate_lua = class({})

--------------------------------------------------------------------------------

function modifier_old_lina_ultimate_lua:OnCreated( kv )
	self.fiery_soul_attack_speed_bonus = self:GetAbility():GetSpecialValueFor( "ultimate_attack_speed_bonus" )

	if IsServer() then
		self.nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_fiery_soul.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl( self.nFXIndex, 1, Vector( self:GetAbility():GetLevel(), 0, 0 ) )
		self:AddParticle( self.nFXIndex, false, false, -1, false, false )
	end
end

--------------------------------------------------------------------------------

function modifier_old_lina_ultimate_lua:OnRefresh( kv )
	self.ultimate_attack_speed_bonus = self:GetAbility():GetSpecialValueFor( "ultimate_attack_speed_bonus" )

	if IsServer() then
		ParticleManager:SetParticleControl( self.nFXIndex, 1, Vector( self:GetAbility():GetLevel(), 0, 0 ) ) 
	end
end

--------------------------------------------------------------------------------

function modifier_old_lina_ultimate_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_old_lina_ultimate_lua:GetModifierAttackSpeedBonus_Constant( params )
	return self.ultimate_attack_speed_bonus
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------