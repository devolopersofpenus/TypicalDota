custom_item_fervor_yasha = class({})
LinkLuaModifier( "custom_modifier_fervor_yasha", "item/custom_item_fervor_yasha.lua", LUA_MODIFIER_MOTION_NONE )
--LinkLuaModifier( "custom_modifier_fervor_yasha_speed", "item/custom_item_fervor_yasha.lua", LUA_MODIFIER_MOTION_NONE )

function custom_item_fervor_yasha:GetIntrinsicModifierName()
  return "custom_modifier_fervor_yasha"
end


custom_modifier_fervor_yasha = class({})

function custom_modifier_fervor_yasha:IsHidden() return true end


function custom_modifier_fervor_yasha:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		--MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		--MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	} return funcs
end

function custom_modifier_fervor_yasha:OnAttackLanded(keys)
	DeepPrintTable(keys)
	--keys.attacker:AddNewModifier(keys.attacker,self,"custom_modifier_fervor_yasha_speed",{duration = 2.0, attacker = keys.attacker,})
end

--custom_modifier_fervor_yasha = class({})
