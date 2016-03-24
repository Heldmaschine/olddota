old_razor_chain_lightning_lua = class({})
LinkLuaModifier( "modifier_old_razor_chain_lightning_thinker_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function old_razor_chain_lightning_lua:OnSpellStart()
	self.hTarget = self:GetCursorTarget()
	self.vTargetPos = self.hTarget:GetOrigin()

	EmitSoundOn( "Hero_Furion.WrathOfNature_Cast", self:GetCaster() )

	CreateModifierThinker( self:GetCaster(), self, "modifier_old_razor_chain_lightning_thinker_lua", kv, self.vTargetPos, self:GetCaster():GetTeamNumber(), false )
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------