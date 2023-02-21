local fps = false
local laststreet = 0

Citizen.CreateThread( function()
	local lastStreetA = 0
	local lastStreetB = 0

	while true do
		Citizen.Wait(0)

		local playerPos = GetEntityCoords(PlayerPedId(), true)
		local streetA, streetB = GetStreetNameAtCoord(playerPos.x, playerPos.y, playerPos.z)
		street = {}

		if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
			lastStreetA = streetA
			lastStreetB = streetB
		end

		if lastStreetA ~= 0 then
			table.insert(street, GetStreetNameFromHashKey(lastStreetA))
		end

		if lastStreetB ~= 0 then
			table.insert(street, GetStreetNameFromHashKey(lastStreetB))
		end

		street = table.concat(street, " & ")

		if street ~= laststreet then
			SendNUIMessage({action = "display", type = street})
			Citizen.Wait(100)
		end
		laststreet = street
		Citizen.Wait(1000)
	end
end)


Citizen.CreateThread(function()
  while true do 


    Wait(wait)
    local degree = degreesToIntercardinalDirection()
      local ped = GetPlayerPed(-1)
      local vehicle = GetVehiclePedIsIn(ped)
      local IsPedInAnyVehicle2 = IsPedInAnyVehicle(ped)
      local fuelLevel  = 0
      local speedLevel = 0
      local damagelevel = 0
      local damage = GetVehicleEngineHealth(vehicle) / 10
      
      if IsPedSittingInAnyVehicle(ped) and not IsPlayerDead(ped) then

          DisplayRadar(true)

      elseif not IsPedSittingInAnyVehicle(ped) then

          DisplayRadar(false)

      end
      
      if IsPauseMenuActive() and not pause then
        pause = true
        SendNUIMessage({
            action = "hide";
        })
    elseif not IsPauseMenuActive() and pause and IsPedInAnyVehicle(ped, false) then
        pause = false
        SendNUIMessage({
            action = "show";
        })
    end

      if (IsPedInAnyVehicle2) and not IsPauseMenuActive()then
        if fps then
            wait = 500
        else
            wait = 100
        end

        local gearlevel = GetVehicleCurrentGear(GetVehiclePedIsIn(PlayerPedId(), false))

          damagelevel = math.floor(damage)
          fuelLevel = math.floor(GetVehicleFuelLevel(vehicle))
          speedLevel = math.ceil(GetEntitySpeed(vehicle) * 3.6)
          SendNUIMessage({
          action = 'show';
          isInVehicle = IsPedInAnyVehicle2;
          speed = speedLevel;
          fuelLevel = fuelLevel;
          damagelevel = damagelevel;
          gearlevel = gearlevel;
          laststreet = laststreet;
          degree = degree;
  
        })
      else
        SendNUIMessage({
            action = "hide";
        })
        damagelevel= 0
        fuelLevel = 0
          speedLevel = 0
          gearlevel = 0
      end
    
 


    
      
end

end)


function degreesToIntercardinalDirection( dgr )
    playerHeadingDegrees = 360.0 - GetEntityHeading( GetPlayerPed( -1 ) )

	dgr = playerHeadingDegrees
	
	if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
		return "NE" -- Originally E
	elseif dgr >= 22.5 and dgr < 67.5 then
		return "E" -- Originally SE
	elseif dgr >= 67.5 and dgr < 112.5 then
		return "SE" -- Originally S
	elseif dgr >= 112.5 and dgr < 157.5 then
		return "S" -- Originally SW
	elseif dgr >= 157.5 and dgr < 202.5 then
		return "SW" -- Originally W
	elseif dgr >= 202.5 and dgr < 247.5 then
		return "W" -- Originally NW
	elseif dgr >= 247.5 and dgr < 292.5 then
		return "NW" -- Originally N
	elseif dgr >= 292.5 and dgr < 337.5 then
		return "N" -- Originally NE
	end
end
RegisterCommand('hudfps', function ()
    if fps then
        fps = false
    else
        fps = true
    end
end)

