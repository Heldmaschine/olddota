modifier_old_razor_stormseeker_effect_lua = class({})

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_effect_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_effect_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_effect_lua:OnCreated( kv )
	self.damage = self:GetAbility():GetSpecialValueFor( "aura_damage_per_tick" )
end

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_effect_lua:OnRefresh( kv )
	self.damage = self:GetAbility():GetSpecialValueFor( "aura_damage_per_tick" )
end

---------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_effect_lua:OnIntervalThink()
	if IsServer() then
		print("DAMAGE_TYPE_MAGICAL")
		if self:GetAbility():GetCaster():IsAlive() then
			local damage = {
				victim = self:GetParent(),
				attacker = self:GetAbility():GetCaster(),
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self:GetAbility()
			}
			EmitSoundOn("Hero_Razor.Storm.Cast", self:GetParent())
			local nFXIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_static_field.vpcf", PATTACH_ABSORIGIN, self:GetParent())
			self:AddParticle( nFXIndex, false, false, -1, false, true )
			ApplyDamage( damage )
		end
	end
end
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------