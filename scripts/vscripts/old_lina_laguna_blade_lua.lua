old_lina_laguna_blade_lua = class({})
LinkLuaModifier( "modifier_old_lina_laguna_blade_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function old_lina_laguna_blade_lua:GetCastRange( vLocation, hTarget )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cast_range_scepter" )
	end

	return self.BaseClass.GetCastRange( self, vLocation, hTarget )
end

--------------------------------------------------------------------------------

function old_lina_laguna_blade_lua:GetManaCost( AbilityManaCost )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "manacost_scepter" )
	end

	return self.BaseClass.GetManaCost( self, AbilityManaCost )
end

--------------------------------------------------------------------------------

function old_lina_laguna_blade_lua:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	if hTarget ~= nil then
		if ( not hTarget:TriggerSpellAbsorb( self ) ) then
			local damage_delay = self:GetSpecialValueFor( "damage_delay" )
			hTarget:AddNewModifier( self:GetCaster(), self, "modifier_old_lina_laguna_blade_lua", { duration = damage_delay } )
			EmitSoundOn( "Ability.LagunaBladeImpact", hTarget )
		end

		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf", PATTACH_CUSTOMORIGIN, nil );
		ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetOrigin() + Vector( 0, 0, 96 ), true );
		ParticleManager:SetParticleControlEnt( nFXIndex, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetOrigin(), true );
		ParticleManager:ReleaseParticleIndex( nFXIndex );

		EmitSoundOn( "Ability.LagunaBladeImpact", self:GetCaster() )
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
