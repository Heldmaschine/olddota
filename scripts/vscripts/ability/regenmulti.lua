-- multipies regen by percentage and adds it to current
function MultiplyRegen( keys )
	keys.caster:Heal(keys.caster:GetHealthRegen() * (keys.Multiplyer / 100) * keys.HealInterval, keys.caster)
end