local fps = false
Citizen.CreateThread(function()
  while true do 
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
    
 

if fps then
    wait = 500
else
    wait = 50
end

      Citizen.Wait(wait)
      
end

end)

RegisterCommand('hudfps', function ()
    if fps then
        fps = false
    else
        fps = true
    end
end)