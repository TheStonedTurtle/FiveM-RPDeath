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

		local args = splitString(message, " ")
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


function splitString(self, delimiter)
	local words = self:Split(delimiter)
	local output = {}
	for i = 0, #words - 1 do
		table.insert(output, words[i])
	end

	return output
end