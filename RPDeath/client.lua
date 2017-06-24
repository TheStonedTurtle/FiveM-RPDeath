RegisterNetEvent('RPD:allowRespawn')
RegisterNetEvent('RPD:allowRevive') 
RegisterNetEvent('RPD:toggleDeath') 


-- Turn off automatic respawn here instead of updating FiveM file.
AddEventHandler('onClientMapStart', function()
	Citizen.Trace("RPDeath: Disabling autospawn...")
	exports.spawnmanager:setAutoSpawn(false)
	exports.spawnmanager:spawnPlayer()
	Citizen.Trace("RPDeath: Autospawn disabled!")
end)


local allowRespawn = false
local allowRevive = false
local RPDeathEnabled = true


TriggerServerEvent('RPD:addPlayer')


AddEventHandler('RPD:allowRespawn', function(from)
	TriggerEvent('chatMessage', "RPDeath", {200,0,0}, "Respawned")
	allowRespawn = true
end)


AddEventHandler('RPD:allowRevive', function(from)
	TriggerEvent('chatMessage', "RPDeath", {200,0,0}, "Revived")
	allowRevive = true
end)

AddEventHandler('RPD:toggleDeath', function(from)
	RPDeathEnabled = not RPDeathEnabled
	if (RPDeathEnabled) then
		TriggerEvent('chatMessage', "RPDeath", {200,0,0}, "RPDeath enabled.")
	else
		TriggerEvent('chatMessage', "RPDeath", {200,0,0}, "RPDeath disabled.")
	end
end)



function revivePed(ped)
	local playerPos = GetEntityCoords(ped, true)

	NetworkResurrectLocalPlayer(playerPos, true, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
end


function respawnPed(ped,coords)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false) 

	SetPlayerInvincible(ped, false) 

	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
	ClearPedBloodDamage(ped)
end


Citizen.CreateThread(function()
	local respawnCount = 0
	local spawnPoints = {}
	local playerIndex = NetworkGetPlayerIndex(-1)


	math.randomseed(playerIndex)

	function createSpawnPoint(x1,x2,y1,y2,z,heading)
		local xValue = math.random(x1,x2) + 0.0001
		local yValue = math.random(y1,y2) + 0.0001

		local newObject = {
			x = xValue,
			y = yValue,
			z = z + 0.0001,
			heading = heading + 0.0001
		}
		table.insert(spawnPoints,newObject)
	end

	createSpawnPoint(-448, -448, -340, -329, 35.5, 0) -- Mount Zonah
	createSpawnPoint(372, 375, -596, -594, 30.0, 0)   -- Pillbox Hill
	createSpawnPoint(335, 340, -1400, -1390, 34.0, 0) -- Central Los Santos
	createSpawnPoint(1850, 1854, 3700, 3704, 35.0, 0) -- Sandy Shores
	createSpawnPoint(-247, -245, 6328, 6332, 33.5, 0) -- Paleto
	--createSpawnPoint(1152, 1156, -1525, -1521, 34.9, 0) -- St. Fiacre

	while true do
		Wait(0)
		local ped = GetPlayerPed(-1)
		
		if (RPDeathEnabled) then

			if (IsEntityDead(ped)) then


				SetPlayerInvincible(ped, true)
				SetEntityHealth(ped, 1)
				
				if (allowRespawn) then 
					local coords = spawnPoints[math.random(1,#spawnPoints)]

					respawnPed(ped, coords)

			  		allowRespawn = false
					respawnCount = respawnCount + 1
					math.randomseed( playerIndex * respawnCount )

				elseif (allowRevive) then
					revivePed(ped)

					allowRevive = false
					Wait(0)
				else
		  			Wait(0)
				end
			else
		  		allowRespawn = false
		  		allowRevive = false			
				Wait(0)
			end


		else 
			if IsEntityDead(ped) then
				Wait(3000) 

				local coords = spawnPoints[math.random(1,#spawnPoints)]

				respawnPed(ped,coords)

				respawnCount = respawnCount + 1
				math.randomseed( playerIndex * respawnCount )
				
			end
		end

	end
end)