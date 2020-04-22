custom_ability_finnick_bonus_heal = class({})
LinkLuaModifier( "custom_modifier_finnick_bonus_heal", "abilit/finnick/custom_ability_finnick_bonus_heal", LUA_MODIFIER_MOTION_NONE )

function custom_ability_finnick_bonus_heal:OnUpgrade()
	kv_table = {}
	kv_table.hp_percentage_source = self:GetSpecialValueFor("hp_percentage_source")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "custom_modifier_finnick_bonus_heal", kv_table)
end

custom_modifier_finnick_bonus_heal = class({})

function custom_modifier_finnick_bonus_heal:OnRefresh(kv)
	if IsServer() then
		self:GetCaster().hp_percentage_source = kv.hp_percentage_source
	end
end

function custom_modifier_finnick_bonus_heal:OnCreated(kv)
	if IsServer() then
		self:GetCaster().hp_percentage_source = kv.hp_percentage_source
	end
end

function custom_modifier_finnick_bonus_heal:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
	return funcs
end

function custom_modifier_finnick_bonus_heal:GetModifierHPRegenAmplify_Percentage()
	if IsServer() then
		return self:GetCaster().hp_percentage_source * 100
	end
end