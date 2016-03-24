old_venge_terror_lua = class({})
LinkLuaModifier( "modifier_old_venge_terror_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------s

function old_venge_terror_lua:OnSpellStart()

	self.terror_aoe = self:GetSpecialValueFor( "terror_aoe" )
	self.tooltip_duration = self:GetSpecialValueFor( "tooltip_duration" )

	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), self:GetCaster(), self.terror_aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	if #enemies > 0 then
		for _,hTarget in pairs(enemies) do
			hTarget:AddNewModifier( self:GetCaster(), self, "modifier_old_venge_terror_lua", { duration = self.tooltip_duration } )
		end
	end
	local nFXindex = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	EmitSoundOn( "Hero_VengefulSpirit.WaveOfTerror" , self:GetCaster() )
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------