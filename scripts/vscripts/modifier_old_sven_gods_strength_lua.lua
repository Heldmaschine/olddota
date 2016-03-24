modifier_old_sven_gods_strength_lua = class({})
--------------------------------------------------------------------------------

function modifier_old_sven_gods_strength_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_old_sven_gods_strength_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_gods_strength.vpcf"
end

--------------------------------------------------------------------------------

function modifier_old_sven_gods_strength_lua:StatusEffectPriority()
	return 1000
end

--------------------------------------------------------------------------------

function modifier_old_sven_gods_strength_lua:GetHeroEffectName()
	return "particles/units/heroes/hero_sven/sven_gods_strength_hero_effect.vpcf"
end

--------------------------------------------------------------------------------

function modifier_old_sven_gods_strength_lua:HeroEffectPriority()
	return 100
end

--------------------------------------------------------------------------------

function modifier_old_sven_gods_strength_lua:OnCreated( kv )
	self.gods_strength_damage = self:GetAbility():GetSpecialValueFor( "gods_strength_damage" )

	if IsServer() then
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_sven/sven_spell_gods_strength_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_weapon" , self:GetParent():GetOrigin(), true )
		ParticleManager:SetParticleControlEnt( nFXIndex, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_head" , self:GetParent():GetOrigin(), true )
		self:AddParticle( nFXIndex, false, false, -1, false, true )
	end
end

--------------------------------------------------------------------------------

function modifier_old_sven_gods_strength_lua:OnRefresh( kv )
	self.gods_strength_damage = self:GetAbility():GetSpecialValueFor( "gods_strength_damage" )
end

--------------------------------------------------------------------------------

function modifier_old_sven_gods_strength_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_old_sven_gods_strength_lua:GetModifierBaseDamageOutgoing_Percentage()
	return self.gods_strength_damage
end

--------------------------------------------------------------------------------
