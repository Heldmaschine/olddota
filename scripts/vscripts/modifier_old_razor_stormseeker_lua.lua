modifier_old_razor_stormseeker_lua = class({})

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_lua:IsHidden()
	return false
end

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_lua:IsAura()
	return true
end

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_lua:GetModifierAura()
	return "modifier_old_razor_stormseeker_effect_lua"
end

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_lua:GetAuraRadius()
	return self.aura_radius
end

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_lua:OnCreated( kv )
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "aura_radius" )
	self.interval = self:GetAbility():GetSpecialValueFor( "aura_damage_interval" )
	self.damage = self:GetAbility():GetSpecialValueFor( "aura_damage_per_tick" )
	if IsServer() then
		if self:GetParent() == self:GetCaster() then
			local nFXIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_razor/razor_rain_storm.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
			ParticleManager:SetParticleControlEnt( nFXIndex, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_head", self:GetCaster():GetOrigin(), true )
			self:AddParticle( nFXIndex, false, false, -1, false, true )
			EmitSoundOn("Hero_Razor.Storm.Loop", self:GetCaster())
		end
		self:StartIntervalThink( self.interval )
	end
end

--------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_lua:OnRefresh( kv )
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "aura_radius" )
	self.interval = self:GetAbility():GetSpecialValueFor( "aura_damage_interval" )
	self.damage = self:GetAbility():GetSpecialValueFor( "aura_damage_per_tick" )
end

---------------------------------------------------------------------------------

function modifier_old_razor_stormseeker_lua:OnIntervalThink()
	if IsServer() then--and self:GetParent() ~= self:GetCaster() then
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber() , self:GetCaster():GetOrigin() , nil , self:GetAuraRadius(), self:GetAuraSearchTeam(), self:GetAuraSearchFlags(), self:GetAuraSearchFlags(), 0, false)
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				local debuff = enemy:FindModifierByName("modifier_old_razor_stormseeker_effect_lua")
				if debuff ~= nil then
					debuff:OnIntervalThink()
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------