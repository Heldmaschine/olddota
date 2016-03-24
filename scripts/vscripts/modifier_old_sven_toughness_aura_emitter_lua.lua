modifier_old_sven_toughness_aura_emitter_lua = class({})

--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_emitter_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_emitter_lua:IsAura()
	return true
end

--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_emitter_lua:GetModifierAura()
	return "modifier_old_sven_toughness_aura_lua"
end

--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_emitter_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_emitter_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_MECHANICAL
end

--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_emitter_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_emitter_lua:GetAuraRadius()
	return self.aura_radius
end

--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_emitter_lua:OnCreated( kv )
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "aura_radius" )
	--[[ May not be needed since reborn
	if IsServer() then--and self:GetParent() ~= self:GetCaster() then
		self:StartIntervalThink( 0.5 )
	end]]
end

--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_emitter_lua:OnRefresh( kv )
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "aura_radius" )
end

--------------------------------------------------------------------------------

function modifier_old_sven_toughness_aura_emitter_lua:OnIntervalThink()
	if IsServer() then
	local ostick_duration = self:GetAbility():GetSpecialValueFor( "duration" )
	local allies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), self:GetCaster(), self.aura_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_MECHANICAL, 0, 0, false )
	if #allies > 0 then
		for _,ally in pairs(allies) do
			local stick_duration
			if ally:IsHero() then
				stick_duration = ostick_duration / 2 
			else
				stick_duration = ostick_duration 
			end
			ally:AddNewModifier( self:GetCaster(), self, "modifier_old_sven_toughness_aura_lua", { duration = stick_duration, tooltip_duration = stick_duration } )
		end
	end
end
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------