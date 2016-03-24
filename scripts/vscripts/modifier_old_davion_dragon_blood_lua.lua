modifier_old_davion_dragon_blood_lua = class({})

--------------------------------------------------------------------------------

function modifier_old_davion_dragon_blood_lua:IsPassive()
	return true
end
--------------------------------------------------------------------------------

function modifier_old_davion_dragon_blood_lua:IsHidden()
	return true
end
--------------------------------------------------------------------------------
function modifier_old_davion_dragon_blood_lua:OnCreated( kv )
	self.bonus_armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )
	self.multiplier = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
	if IsServer() then
		self:StartIntervalThink( 0.1 )
	end
end

--------------------------------------------------------------------------------

function modifier_old_davion_dragon_blood_lua:OnRefresh( kv )
	self.bonus_armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )
	self.multiplier = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
end

--------------------------------------------------------------------------------

function modifier_old_davion_dragon_blood_lua:OnIntervalThink()
	self.bonus_regen = nil
	local base_regen = self:GetCaster():GetHealthRegen()
	self.bonus_regen = (self.multiplier/100) * base_regen
end

--------------------------------------------------------------------------------

function modifier_old_davion_dragon_blood_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_old_davion_dragon_blood_lua:GetModifierPhysicalArmorBonus( params )
	if self:GetCaster():PassivesDisabled() then
		return 0
	end
	return self.bonus_armor
end
--------------------------------------------------------------------------------

function modifier_old_davion_dragon_blood_lua:GetModifierConstantHealthRegen( params )
	if self:GetCaster():PassivesDisabled() then
		return 0
	end
	return self.bonus_regen
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------