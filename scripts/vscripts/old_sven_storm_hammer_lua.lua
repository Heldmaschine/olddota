old_sven_storm_hammer_lua = class({})
LinkLuaModifier( "modifier_old_sven_storm_hammer_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function old_sven_storm_hammer_lua:OnAbilityPhaseStart()
	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_sven/sven_spell_storm_bolt_lightning.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_sword", self:GetCaster():GetOrigin(), true )

	local vLightningOffset = self:GetCaster():GetOrigin() + Vector( 0, 0, 1600 )
	ParticleManager:SetParticleControl( nFXIndex, 1, vLightningOffset )

	ParticleManager:ReleaseParticleIndex( nFXIndex )

	return true
end

--------------------------------------------------------------------------------

function old_sven_storm_hammer_lua:OnSpellStart()
	local bolt_speed = self:GetSpecialValueFor( "bolt_speed" )

	local info = {
			EffectName = "particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf",
			Ability = self,
			iMoveSpeed = bolt_speed,
			Source = self:GetCaster(),
			Target = self:GetCursorTarget(),
			bDodgeable = false,
			bProvidesVision = false,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2, 
		}

	ProjectileManager:CreateTrackingProjectile( info )
	EmitSoundOn( "Hero_Sven.StormBolt", self:GetCaster() )
end

--------------------------------------------------------------------------------

function old_sven_storm_hammer_lua:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil and ( not hTarget:IsInvulnerable() ) and ( not hTarget:TriggerSpellAbsorb( self ) ) then
		EmitSoundOn( "Hero_Sven.StormBoltImpact", hTarget )
		local bolt_damage = self:GetSpecialValueFor( "bolt_damage" )
		local bolt_stun_duration = self:GetSpecialValueFor( "bolt_stun_duration" )

		local damage = {
			victim = hTarget,
			attacker = self:GetCaster(),
			damage = bolt_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		}
		ApplyDamage( damage )
		hTarget:AddNewModifier( self:GetCaster(), self, "modifier_old_sven_storm_hammer_lua", { duration = bolt_stun_duration } )
	end
	
	return true
end
--------------------------------------------------------------------------------
