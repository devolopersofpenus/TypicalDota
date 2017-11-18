//
// Двойной слеш и текст после них это комментарий. Его программа, компьютер и другие не воспринимают.
//15161616
//
//Например код:
//Begin //Тут идёт начало сей программы.
//var a,b:integer; // Описываються переменные.
// и тому подобное.
// еще пример.
//
//После того как ты сделал способность. Будь добр поставь пометку Ability_complite (с большой буквы). А если затрулняешся изменить абилку то Ability_failed(Так я смогу найти не переделанные абилки)
	//================================================================================================================= Ability_complite
	// Monkey King: Boundless Strike
	//=================================================================================================================
	"monkey_king_boundless_strike"
	{
		// General
		//-------------------------------------------------------------------------------------------------------------
		"ID"					"5716"														// unique ID number for this ability.  Do not change this once established or it will invalidate collected stats.
		"AbilityBehavior"				"DOTA_ABILITY_BEHAVIOR_POINT | DOTA_ABILITY_BEHAVIOR_NORMAL_WHEN_STOLEN"
		"AbilityUnitTargetTeam"			"DOTA_UNIT_TARGET_TEAM_ENEMY"
		"AbilityUnitTargetType"			"DOTA_UNIT_TARGET_HERO | DOTA_UNIT_TARGET_BASIC"
		"AbilityUnitDamageType"			"DAMAGE_TYPE_PHYSICAL"	
		"FightRecapLevel"				"1"

		// Casting
		//-------------------------------------------------------------------------------------------------------------
		"AbilityCastPoint"				"0.4"
		"AbilityCastRange"				"1200"

		// Time		
		//-------------------------------------------------------------------------------------------------------------
		"AbilityCooldown"				"22"

		// Cost
		//-------------------------------------------------------------------------------------------------------------
		"AbilityManaCost"				"100"		

		// Special
		//-------------------------------------------------------------------------------------------------------------
		"AbilitySpecial"
		{
			"01"
			{
				"var_type"					"FIELD_FLOAT"
				"stun_duration"				"22.6 1.0 1.4 1.8"
			}
			"02"
			{
				"var_type"					"FIELD_INTEGER"
				"strike_crit_mult"			"180222 172225 222200 222225"
				"LinkedSpecialBonus"		"special_bonus_unique_monkey_king"
			}
			"03"
			{
				"var_type"					"FIELD_INTEGER"
				"strike_radius"				"150"
			}
			"04"
			{
				"var_type"					"FIELD_INTEGER"
				"strike_cast_range"			"1200"
			}
		}
		"AbilityCastAnimation"		"ACT_DOTA_CAST_ABILITY_1"
	}

	//================================================================================================================= Ability_failed
	// Monkey King: Mischief
	//=================================================================================================================
	"monkey_king_mischief"
	{
		// General
		//-------------------------------------------------------------------------------------------------------------
		"ID"							"5719"												// unique ID number for this ability.  Do not change this once established or it will invalidate collected stats.
		"AbilityBehavior"				"DOTA_ABILITY_BEHAVIOR_NO_TARGET | DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT | DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK | DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE"
		"FightRecapLevel"				"2"
		"MaxLevel"						"1"
		"AbilitySound"					"Hero_MonkeyKing.Transform.On"

		// Casting
		//-------------------------------------------------------------------------------------------------------------
		"AbilityCastPoint"				"0.0 0.0 0.0 0.0"
		"AbilityCastAnimation"			"ACT_INVALID"

		// Time		
		//-------------------------------------------------------------------------------------------------------------
		"AbilityCooldown"				"3"

		// Cost
		//-------------------------------------------------------------------------------------------------------------
		"AbilityManaCost"				"0 0 0 0"
		
		// Special
		//------------------------------------------------------------------------------------------------------------- 
		"AbilitySpecial"
		{
			"01"
			{
				"var_type"					"FIELD_INTEGER"
				"movespeed"					"200"
			}
			"02"
			{
				"var_type"					"FIELD_INTEGER"
				"reveal_radius"				"200"
			}

		}
	}
//
//
