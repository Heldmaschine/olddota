old_antimage_blink = class({})

LinkLuaModifier( "modifier_old_antimage_blink","old_antimage_blink_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function old_antimage_blink_lua:OnAbilityPhaseStart()
	self.vTargetPosition = self:GetCursorPosition()



	local kv = {
		duration = self:GetCastPoint(),
		target_x = self.vTargetPosition.x,
		target_y = self.vTargetPosition.y,
		target_z = self.vTargetPosition.z
	}

	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_old_antimage_blink_lua", kv )


	return true;
end

------------------------------------------------------------------------------
--[[

function old_antimage_blink_lua:OnAbilityPhaseInterrupted()
	ParticleManager:SetParticleControl( self.nFXIndexStart, 2, Vector( 0, 0, 0 ) )
	ParticleManager:SetParticleControl( self.nFXIndexEnd, 2, Vector( 0, 0, 0 ) )
	ParticleManager:SetParticleControl( self.nFXIndexEndTeam, 2, Vector( 0, 0, 0 ) )

	ParticleManager:DestroyParticle( self.nFXIndexStart, false )
	ParticleManager:DestroyParticle( self.nFXIndexEnd, false )
	ParticleManager:DestroyParticle( self.nFXIndexEndTeam, false )

	self:GetCaster():RemoveModifierByName( "modifier_old_antimage_blink_lua" )
end
]]
--------------------------------------------------------------------------------

function old_antimage_blink_lua:OnSpellStart()
	ProjectileManager:ProjectileDodge( self:GetCaster() )
	self.nFXIndexStart = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_blink_start.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControl( self.nFXIndexStart, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( self.nFXIndexStart, 2, Vector( 1, 0, 0 ) )

	self.nFXIndexEnd = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_blink_end.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl( self.nFXIndexEnd, 1, self.vTargetPosition )
	ParticleManager:SetParticleControl( self.nFXIndexEnd, 2, Vector ( 1, 0, 0 ) )
	

	FindClearSpaceForUnit( self:GetCaster(), self.vTargetPosition, true )

	ParticleManager:DestroyParticle( self.nFXIndexStart, false )
	ParticleManager:DestroyParticle( self.nFXIndexEnd, false )
	ParticleManager:DestroyParticle( self.nFXIndexEndTeam, false )
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

modifier_old_antimage_blink_lua = class({})

--------------------------------------------------------------------------------

function modifier_old_antimage_blink_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
function modifier_old_antimage_blink_lua:IsHidden()
	return false
end

--------------------------------------------------------------------------------

function modifier_old_antimage_blink_lua:OnCreated( kv )
	if IsServer() then
		self.vStartPos = self:GetParent():GetOrigin()
		self.vEndPos = Vector( kv["target_x"], kv["target_y"], kv["target_y"] )

		EmitSoundOnLocationWithCaster( self.vStartPos, "Hero_Antimage.blink_out", self:GetCaster() )
		EmitSoundOnLocationWithCaster( self.vEndPos, "Hero_Antimage.blink_in", self:GetCaster() )
	end
end

--------------------------------------------------------------------------------

function modifier_old_antimage_blink_lua:OnDestroy()
	if IsServer() then
		StopSoundOn( "Hero_Antimage.blink_out", self:GetCaster() )
		StopSoundOn( "Hero_Antimage.blink_in", self:GetCaster() )
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
