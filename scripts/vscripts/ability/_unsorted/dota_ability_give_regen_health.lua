dota_ability_give_regen_health = class({})
LinkLuaModifier("dota_modifier_give_regen_health","ability/_unsorted/dota_ability_give_regen_health",LUA_MODIFIER_MOTION_NONE)

function dota_ability_give_regen_health:OnToggle()
    if self:GetToggleState() then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "dota_modifier_give_regen_health", nil)
    else
        self:GetCaster():RemoveModifierByName("dota_modifier_give_regen_health")
    end
end

dota_modifier_give_regen_health = class({})
function dota_modifier_give_regen_health:DeclareFunctions()
    local funcs =
    {
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
        MODIFIER_EVENT_ON_ATTACK,
    }
    return funcs
end

function dota_modifier_give_regen_health:OnCreated(kv)
    if IsServer() then
        self.damage_per_lasthit = self:GetAbility():GetSpecialValueFor("damage_per_lasthit")
    end
end

function dota_modifier_give_regen_health:OnAttack(params)
    if IsServer() then
        if self:GetCaster() == params.attacker then
            self:GetCaster():SpendMana(self:GetAbility():GetManaCost(-1),self:GetAbility())
        end
    end
end

function dota_modifier_give_regen_health:GetModifierBaseAttack_BonusDamage(params)
    if IsServer() then
        local DamageBonus = self.damage_per_lasthit * self:GetCaster():GetLastHits() --self.damage_per_lasthit * self:GetCaster():GetKills()
        return DamageBonus
    end
end
