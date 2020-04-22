custom_ability_axe_culling_blade = class({})
LinkLuaModifier( "custom_modifier_axe_culling_blade", "ability/axe/custom_ability_axe_culling_blade", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function custom_ability_axe_culling_blade:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local damage = self:GetSpecialValueFor("damage")
	local threshold = self:GetSpecialValueFor("kill_threshold")
	local radius = self:GetSpecialValueFor("speed_aoe")
	local duration = self:GetSpecialValueFor("speed_duration")

	-- Check success / not
	local success = false
	if target:GetHealth()<=threshold and target:IsHero() then success = true end

	-- effects
	self:PlayEffects( target, success )

	if success then
		-- Success:
		-- Damage as HPLoss 
		if target:FindModifierByName("custom_modifier_finnick_invulnerability") ~= nil then
			target:SetHealth(1)
		else
			if target:HasModifier("modifier_dazzle_shallow_grave") then
				target:RemoveModifierByName("modifier_dazzle_shallow_grave")
			end
			if target:HasModifier("modifier_abaddon_borrowed_time") then
				target:RemoveModifierByName("modifier_abaddon_borrowed_time")
			end
			local damageTable = {
				victim = target,
				attacker = caster,
				damage = threshold,
				damage_type = DAMAGE_TYPE_PURE,
				ability = self, --Optional.
				damage_flags = DOTA_DAMAGE_FLAG_HPLOSS --Optional.
			}
			ApplyDamage(damageTable)
		end

		-- Resets cooldown
		self:EndCooldown()

		-- Apply modifier
		local allies = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			caster:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)
		for _,ally in pairs(allies) do
			ally:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"custom_modifier_axe_culling_blade", -- modifier name
				{ duration = duration } -- kv
			)
		end
	else
		-- Failed
		-- Magical damage
		local damageTable = {
			victim = target,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self, --Optional.
		}
		ApplyDamage(damageTable)		
	end
end

--------------------------------------------------------------------------------
function custom_ability_axe_culling_blade:PlayEffects( target, success )
	-- Get Resources
	local particle_cast = ""
	local sound_cast = ""
	if success then
		particle_cast = "particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf"
		sound_cast = "Hero_Axe.Culling_Blade_Success"
	else
		particle_cast = "particles/units/heroes/hero_axe/axe_culling_blade.vpcf"
		sound_cast = "Hero_Axe.Culling_Blade_Fail"
	end

	-- load data
	local direction = (target:GetOrigin()-self:GetCaster():GetOrigin()):Normalized()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 4, target:GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 3, direction )
	ParticleManager:SetParticleControlForward( effect_cast, 4, direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end

custom_modifier_axe_culling_blade = class({})

function custom_modifier_axe_culling_blade:IsHidden()
	return false
end

function custom_modifier_axe_culling_blade:IsDebuff()
	return false
end

function custom_modifier_axe_culling_blade:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function custom_modifier_axe_culling_blade:OnCreated( kv )
	-- references
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "atk_speed_bonus_tooltip" ) -- special value
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" ) -- special value
end

function custom_modifier_axe_culling_blade:OnRefresh( kv )
	-- references
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "atk_speed_bonus_tooltip" ) -- special value
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" ) -- special value
end

function custom_modifier_axe_culling_blade:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function custom_modifier_axe_culling_blade:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end
function custom_modifier_axe_culling_blade:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus
end
function custom_modifier_axe_culling_blade:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function custom_modifier_axe_culling_blade:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_cullingblade_sprint.vpcf"
end

function custom_modifier_axe_culling_blade:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

