if ChatCommand == nil then
	TypicalDota.ChatCommand = class({})
	ChatCommand = TypicalDota.ChatCommand
	print("Create ChatCommand")
end

function ChatCommand:CheckChat(keys)
	--DeepPrintTable(keys)
	local textlow = string.lower(keys.text)
	if string.find(textlow,"-") == 1 then
		if (string.find(textlow,"-changecolor") == 1) then CreatorClass:ChangeColor(keys.playerid,textlow)
		elseif (string.find(textlow,"-pick") == 1) then ChatCommand:PickHero(keys.playerid,textlow)
		elseif (string.find(textlow,"-lua") == 1) then
			local doit = load(keys.text:sub(6))
			MyPlayer = PlayerResource:GetPlayer(keys.playerid)
			MyHero = MyPlayer:GetAssignedHero()
			status, err = pcall(doit)
			if not status then SendToServerConsole("say "..err) print(err) end
		end
	end

end


function ChatCommand:PickHero(playerid,text)
	print(string.sub(text, 7))
	PlayerResource:ReplaceHeroWith(playerid,string.sub(text, 7),0,0) --Изначально использовал этот способ.
end

function ChatCommand:InitModule()
	print("ChatCommand is loaded")
	ListenToGameEvent('player_chat', Dynamic_Wrap(ChatCommand, 'CheckChat'), self)
end
--[[
-changecolor true healthbar
]]--