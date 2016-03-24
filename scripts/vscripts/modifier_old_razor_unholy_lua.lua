modifier_old_razor_unholy_lua = class({})

--------------------------------------------------------------------------------

function modifier_old_razor_unholy_lua:IsHidden()
	return true
end
--------------------------------------------------------------------------------
function modifier_old_razor_unholy_lua:OnCreated( kv )
	self.bonus_movespeed = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed_percentage" )
	self.multiplier = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
	if IsServer() then
		self:StartIntervalThink( 0.1 )
	end
end

--------------------------------------------------------------------------------

function modifier_old_razor_unholy_lua:OnRefresh( kv )
	self.bonus_movespeed = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed_percentage" )
	self.multiplier = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
end

--------------------------------------------------------------------------------

function modifier_old_razor_unholy_lua:OnIntervalThink()
	self.bonus_regen = nil
	local base_regen = self:GetCaster():GetHealthRegen()
	self.bonus_regen = (self.multiplier/100) * base_regen
end
--------------------------------------------------------------------------------

function modifier_old_razor_unholy_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_old_razor_unholy_lua:GetModifierMoveSpeedBonus_Percentage( params )
	if self:GetCaster():PassivesDisabled() then
		return 0
	end
	return self.bonus_movespeed
end
--------------------------------------------------------------------------------

function modifier_old_razor_unholy_lua:GetModifierConstantHealthRegen( params )
	if self:GetCaster():PassivesDisabled() then
		return 0
	end
	return self.bonus_regen
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------