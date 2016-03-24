old_razor_chain_lightning_lua = class({})
--LinkLuaModifier( "modifier_old_razor_chain_lightning_thinker_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function old_razor_chain_lightning_lua:OnSpellStart()
	self.hTarget = self:GetCursorTarget()
	self.vTargetPos = self.hTarget:GetOrigin()

	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.max_targets = self:GetAbility():GetSpecialValueFor( "jump_count" )
	self.damage_percent_add = self:GetAbility():GetSpecialValueFor( "damage_percent_add" )
	self.jump_delay = self:GetAbility():GetSpecialValueFor( "jump_delay" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	self.hTargetsHit = {}

	local info = 
	{
		EffectName = "particles/units/heroes/hero_zuus/zuus_arc_lightning_.vpcf",
		Ability = self,
		iMoveSpeed = self:FindProjectileSpeed(self:GetCaster() , hTarget , self.jump_delay)
		Source = self:GetCaster(),
		Target = hTarget,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2
	}
	ProjectileManager:CreateTrackingProjectile( info )

end
--------------------------------------------------------------------------------

function old_razor_chain_lightning_lua:FindProjectileSpeed( hSource, hTarget, fDelay)
	local fDistance = (hSource:GetAbsOrigin() - hTarget:GetAbsOrigin()):Length2D()
	local fSpeed = fDistance / fDelay
	return fSpeed
end

--------------------------------------------------------------------------------

function old_razor_chain_lightning_lua:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil and ( not hTarget:IsInvulnerable() ) and ( not hTarget:TriggerSpellAbsorb( self ) ) and ( not hTarget:IsMagicImmune() ) then
		--EmitSoundOn( "Hero_VengefulSpirit.MagicMissileImpact", hTarget )

	local nTargetsHit = 0
	if self.hTargetsHit ~= nil then
		nTargetsHit = #self.hTargetsHit
	end
	local flDamagePct = math.pow( 1.0 + ( self.damage_percent_add / 100.0 ), nTargetsHit )
	local flDamage = self.damage

	flDamage = flDamage * flDamagePct

	local damage = {
		victim = hTarget,
		attacker = self:GetCaster(),
		damage = flDamage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility()
	}

	ApplyDamage( damage )
	table.insert( self.hTargetsHit, hTarget )
	if not #self.hTargetsHit >= nMaxTargets then
		local hNextTarget = self:GetNextTarget( hTarget )
	local info = 
	{
		EffectName = "particles/units/heroes/hero_zuus/zuus_arc_lightning_.vpcf",
		Ability = self,
		iMoveSpeed = self:FindProjectileSpeed(hTarget , hNextTarget , self.jump_delay)
		Source = hTarget,
		Target = hNextTarget,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2
	}
	ProjectileManager:CreateTrackingProjectile( info )

	end

	return true
end

--------------------------------------------------------------------------------

function modifier_old_razor_chain_lightning_thinker_lua:GetNextTarget( hTarget )
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), hTarget:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	local hClosestTarget = nil
	local flClosestDist = 0.0
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil then
				local bHitByChain = false

				if self.hTargetsHit ~= nil then
					for _,hHitEnemy in ipairs(self.hTargetsHit) do
						if enemy == hHitEnemy then
							bHitByChain = true
						end 
					end
				end

				if bHitByChain == false then
					local vToTarget = enemy:GetOrigin() - hTarget:GetOrigin()
					local flDistToTarget = vToTarget:Length()

					if hClosestTarget == nil or flDistToTarget < flClosestDist then
						hClosestTarget = enemy
						flClosestDist = flDistToTarget
					end
				end			
			end
		end
	end

	return hClosestTarget
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------