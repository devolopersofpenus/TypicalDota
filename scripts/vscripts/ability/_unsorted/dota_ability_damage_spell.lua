dota_ability_damage_spell = class({})
function dota_ability_damage_spell:OnSpellStart()
	local Caster = self:GetCaster()
	local Target = self:GetCursorTarget()

	local DealDamage = self:GetAbilityDamage()+GetManaCost(-1)
	local TypeDamage = self:GetAbilityDamageType()

	local Damage =
	{
		victim = Target,
		attacker = Caster,
		damage = DealDamage,
		damage_type = TypeDamage,
	}

	ApplyDamage(Damage) 
end