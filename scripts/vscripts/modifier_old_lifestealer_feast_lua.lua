modifier_old_lifestealer_feast_lua = class({})
--------------------------------------------------------------------------------

function modifier_old_lifestealer_feast_lua:OnCreated( kv )
	self.lifesteal = self:GetAbility():GetSpecialValueFor( "lifesteal_percent" )
end

--------------------------------------------------------------------------------

function modifier_old_lifestealer_feast_lua:OnRefresh( kv )
	self.lifesteal = self:GetAbility():GetSpecialValueFor( "lifesteal_percent" )
end

--------------------------------------------------------------------------------

function modifier_old_lifestealer_feast_lua:OnAttackLanded()
	if IsServer() then
		local hTarget = self:GetTarget()
		if not hTarget:IsBuilding() or not hTarget:GetInvulnCount() then
			self:GetCaster():Heal(self:GetCaster():GetDamage()*self.lifesteal,self)
			local nFXIndex = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_lifesteal_old.vpcf", PATTACH_POINT, self:GetParent() )
			--ParticleManager:SetParticleControlEnt( nFXIndex, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_head", self:GetCaster():GetOrigin(), true )
			self:AddParticle( nFXIndex, false, false, -1, false, true )
		end
	end
end

--------------------------------------------------------------------------------