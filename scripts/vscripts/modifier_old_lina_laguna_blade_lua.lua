modifier_old_lina_laguna_blade_lua = class ({})

--------------------------------------------------------------------------------

function modifier_old_lina_laguna_blade_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_old_lina_laguna_blade_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_old_lina_laguna_blade_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_old_lina_laguna_blade_lua:OnDestroy()
	if IsServer() then
		local nDamage = self:GetAbility():GetSpecialValueFor( "damage" )
		if self:GetCaster():HasScepter() then
			nDamage = self:GetAbility():GetSpecialValueFor( "damage_scepter" )
		end

		local damage = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = nDamage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility()
		}

		ApplyDamage( damage )
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
