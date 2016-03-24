modifier_old_sven_toughness_aura_lua = class({})
--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_lua:OnCreated( kv )
	self.warcry_armor = self:GetAbility():GetSpecialValueFor( "warcry_armor" )
	if IsServer() then
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_sven/sven_warcry_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControlEnt( nFXIndex, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_head", self:GetCaster():GetOrigin(), true )
		self:AddParticle( nFXIndex, false, false, -1, false, true )
	end
end

--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_lua:OnRefresh( kv )
	self.warcry_armor = self:GetAbility():GetSpecialValueFor( "warcry_armor" )
end

--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end
--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_lua:GetModifierPhysicalArmorBonus( params )
	return self.warcry_armor
end

--------------------------------------------------------------------------------