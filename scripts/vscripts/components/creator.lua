if CreatorClass == nil then
	_G.CreatorClass = class({})
	print("Create CreatomClass")
end

local steamid = {
	friendly_spy = "76561198126455179",
	--keks = "76561198145261463",
	--teran = "76561198169121138"

}



local color = {
	["r"] = 255,
	["g"] = 0,
	["b"] = 0,
}

local speed = 1/30

function CreatorClass:OnNPCSpawned(keys)
	local unit = EntIndexToHScript(keys.entindex)
	if unit:IsHero() or unit:IsIllusion() then
		for _,v in pairs(steamid) do
			if (tostring(PlayerResource:GetSteamID(unit:GetPlayerID())) == v) and (unit.creator == nil) then
				unit.creator = true;
				unit.customcolor = {
					["r"] = 255,
					["b"] = 0,
					["g"] = 0,
				}
				unit.customcolor.Color = {255, 0, 0}
				unit.customcolor.Permision = {true,true,true}
				unit.customcolor.ChangeColor = true
				unit.customcolor.Default = true
				if dev == nil then dev = {} end
				dev[unit:GetPlayerID()] = unit
			end
		end
	end

end

function CreatorClass:OnThink()
	--print("CreatorClass Think")
	if dev ~= nil then
		if color.r == 255 and color.g < 255 and color.b == 0 then
			color.g = color.g + 5
		elseif color.r > 0 and color.g == 255 and color.b == 0 then
			color.r = color.r - 5
		elseif color.r == 0 and color.g == 255 and color.b < 255 then
			color.b = color.b + 5
		elseif color.r == 0 and color.g > 0 and color.b == 255 then
			color.g = color.g - 5
		elseif color.r < 255 and color.g == 0 and color.b == 255 then
			color.r = color.r + 5
		elseif color.r == 255 and color.g == 0 and color.b > 0 then
			color.b = color.b - 5
		end
		for _,v in pairs(dev) do
			if v.customcolor.Default == false then
				if v.customcolor.ChangeColor == true then v.customcolor.Color = {color.r, color.g, color.b} end
				if v.customcolor.Permision[1] == true then
					PlayerResource:SetCustomPlayerColor(v:GetPlayerID(), v.customcolor.Color[1], v.customcolor.Color[2], v.customcolor.Color[3])
				end
				if v.customcolor.Permision[2] == true then 
					v:SetRenderColor(v.customcolor.Color[1], v.customcolor.Color[2], v.customcolor.Color[3])
				end
				if v.customcolor.Permision[3] == true then
					SetTeamCustomHealthbarColor(v:GetTeam(), v.customcolor.Color[1], v.customcolor.Color[2], v.customcolor.Color[3])
				end
			else
				v:SetRenderColor(255,255,255)
				ClearTeamCustomHealthbarColor(v:GetTeam())
			end
		end

	return speed
	end
	return 1/30
end

function CreatorClass:ChangeColor( playerid,text )-- -changecolor
	for k,v in pairs(dev) do 
		if k == playerid then
			--DeepPrintTable(v)
			if (string.find(text, "true", 14) == 14) then
				--true
				if (string.find(text, "player", 19) == 19) then v.customcolor.Permision[1] = true v.customcolor.Default = false
				elseif (string.find(text, "model", 19) == 19) then v.customcolor.Permision[2] = true v.customcolor.Default = false
				elseif (string.find(text, "healthbar", 19) == 19) then v.customcolor.Permision[3] = true v.customcolor.Default = false
				elseif string.len(text) == 17 then v.customcolor.ChangeColor = true v.customcolor.Default = false end 
			elseif (string.find(text, "false", 14) == 14) then
				--false
				if (string.find(text, "player", 20) == 20) then v.customcolor.Permision[1] = false
				elseif (string.find(text, "model", 20) == 20) then v.customcolor.Permision[2] = false
				elseif (string.find(text, "healthbar", 20) == 20) then v.customcolor.Permision[3] = false
				elseif string.len(text) == 18 then v.customcolor.ChangeColor = false end
			elseif (string.find(text, "speed", 14) == 14) then self.speed = (tonumber(string.sub(text,20)) or 1/32)
				--speed
			elseif (string.find(text, "color", 14) == 14) then
				--color
				v.customcolor.Color[1] = (tonumber(string.sub(text,20,22)) or 255)
				v.customcolor.Color[2] = (tonumber(string.sub(text,24,26)) or 255)
				v.customcolor.Color[3] = (tonumber(string.sub(text,28,30)) or 255)
			elseif (string.find(text, "default", 14) == 14) then
				--default
				v.customcolor.Default = true	
			end
		end
	end
end



function CreatorClass:InitModule()
	print("CreatorClass is loaded")
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(CreatorClass, 'OnNPCSpawned'), self)
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "CreatorThink", 1 )
end