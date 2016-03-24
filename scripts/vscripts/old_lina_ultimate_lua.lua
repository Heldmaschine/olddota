old_lina_ultimate_lua = class({})
LinkLuaModifier( "modifier_old_lina_ultimate_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function old_lina_ultimate_lua:OnSpellStart()
	local ultimate_duration = self:GetSpecialValueFor( "duration_tooltip" )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_old_lina_ultimate_lua", { duration = ultimate_duration })
	--EmitSoundOn( "", self.GetCaster())
	self:GetCaster():StartGesture( ACT_DOTA_OVERRIDE_ABILITY_2 );
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
