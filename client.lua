local showingIDs = false

local function draw3DText(coords, text)
    SetDrawOrigin(coords.x, coords.y, coords.z - 0.2, 0)
    SetTextScale(Config.Text.scale, Config.Text.scale)
    SetTextFont(Config.Text.font)
    SetTextProportional(true)
    SetTextColour(Config.Text.color[1], Config.Text.color[2], Config.Text.color[3], Config.Text.color[4])
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

local function toggleIDDisplay()
    showingIDs = not showingIDs

    if showingIDs then
        CreateThread(function()
            while showingIDs do
                local playerPed = cache.ped
                local playerCoords = GetEntityCoords(playerPed)
                local players = GetActivePlayers()

                for i = 1, #players do
                    local player = players[i]
                    local targetPed = GetPlayerPed(player)

                    if targetPed then
                        local targetCoords = GetEntityCoords(targetPed)
                        local dist = Vdist(playerCoords, targetCoords)

                        if targetPed == playerPed or (dist <= Config.MaxDistance and HasEntityClearLosToEntity(playerPed, targetPed, 17)) then
                            local serverId = GetPlayerServerId(player)  
                            draw3DText(targetCoords + vector3(0.0, 0.0, Config.Text.offsetZ),
                                ("ID: %d"):format(serverId))
                        end                        
                    end
                end

                Wait(Config.UpdateInterval)
            end
        end)
    end
end

lib.addKeybind({
    name = 'id_peek',
    description = 'Toggle ID Peek',
    defaultKey = Config.Keybind,
    onPressed = toggleIDDisplay
})
