old_sven_toughness_aura_lua = class({})
LinkLuaModifier( "modifier_old_sven_toughness_aura_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_old_sven_toughness_aura_emitter_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function old_sven_toughness_aura_lua:GetIntrinsicModifierName()
	return "modifier_old_sven_toughness_aura_emitter_lua"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------