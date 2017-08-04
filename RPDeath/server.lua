players = {}

RegisterServerEvent('RPD:addPlayer')
AddEventHandler('RPD:addPlayer', function()
	players[source] = true
end)

AddEventHandler('playerDropped',function(reason)
	players[source] = nil
end)


AddEventHandler('chatMessage', function(from,name,message)
	if(message:sub(1,1) == "/") then

		local args = stringsplit(message, " ")
		local cmd = args[1]


		if (cmd == "/respawn") then
			CancelEvent()
			TriggerClientEvent('RPD:allowRespawn', from)
		end

		if (cmd == "/toggleDeath") then
			CancelEvent()
			TriggerClientEvent('RPD:toggleDeath', from)
		end

		if (cmd == "/revive") then
			CancelEvent()

			if (args[2] ~= nil) then
				local playerID = tonumber(args[2])

				if(playerID == nil or players[playerID] == nil) then
					TriggerClientEvent('chatMessage', from, "RPDeath", {200,0,0} , "Invalid PlayerID")
					return
				end

				TriggerClientEvent('RPD:allowRevive', playerID)

				TriggerClientEvent('chatMessage', from, "RPDeath", {200,0,0} , "Player revived")
			else
				TriggerClientEvent('RPD:allowRevive', from)
			end
		end
	end
end)


-- String splits by the separator.
function stringsplit(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
    end
    return t
end
