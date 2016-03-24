old_furion_sprout_lua = class({})

--------------------------------------------------------------------------------
function old_furion_sprout_lua:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	if hTarget:IsAncient() then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter( hTarget, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_NONE, self:GetCaster():GetTeamNumber() )
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

--------------------------------------------------------------------------------

function old_furion_sprout_lua:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	if hTarget:IsAncient() then
		return "#dota_hud_error_cant_cast_on_ancient"
	end

	if hTarget:IsMagicImmune() then
		return "#dota_hud_error_cant_cast_on_spell_immune"
	end

	return ""
end

---------------------------------------------------------------------------------

function old_furion_sprout_lua:OnSpellStart()
	self.duration = self:GetSpecialValueFor( "duration" )
	self.radius = self:GetSpecialValueFor( "radius" )
	self.vision_range = self:GetSpecialValueFor( "vision_range" )

	local hTarget = self:GetCursorTarget()

	if  hTarget ~= nil and ( not hTarget:TriggerSpellAbsorb( self ) ) then
		local vTargetPosition = hTarget:GetOrigin()


		local r = self.radius 
		local c = math.sqrt( 2 ) * 0.5 * r 
		local x_offset = { -r, -c, 0.0, c, r, c, 0.0, -c }
		local y_offset = { 0.0, c, r, c, 0.0, -c, -r, -c }

		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_furion/furion_sprout.vpcf", PATTACH_CUSTOMORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, vTargetPosition )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 0.0, r, 0.0 ) )
		ParticleManager:ReleaseParticleIndex( nFXIndex )

		for i = 1,8 do
			CreateTempTree( vTargetPosition + Vector( x_offset[i], y_offset[i], 0.0 ), self.duration )
		end

		for i = 1,8 do
			ResolveNPCPositions( vTargetPosition + Vector( x_offset[i], y_offset[i], 0.0 ), 64.0 ) --Tree Radius
		end

		AddFOWViewer( self:GetCaster():GetTeamNumber(), vTargetPosition, self.vision_range, self.duration, false )
		EmitSoundOnLocationWithCaster( vTargetPosition, "Hero_Furion.Sprout", self:GetCaster() )
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------