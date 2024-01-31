local totalScore = 0
local alreadyInUse = false
local inFirearmsZone = false
local testActive = false
local obj = nil
local T = 0
local R = 0

local function updateScore()
	local textShow = {
        'Firearms Test  \n',
        'Status: Active  \n',
        'Current Score: ', totalScore
	}

	lib.showTextUI(table.concat(textShow))
end

local function finalScore()
    lib.hideTextUI()

	local textShow = {
        'Firearms Test  \n',
        'Status: Completed  \n',
        'Final Score: ', totalScore
	}

	lib.showTextUI(table.concat(textShow))

    FreezeEntityPosition(cache.ped, false)

    TriggerServerEvent('complex-gunrange:server:setInUse')

    TriggerServerEvent('complex-gunrange:giveResultReceipt', totalScore)
end

local function getRandomTargetLocation()
    local randomIndex = math.random(1, #Config.TargetLocations)
    return Config.TargetLocations[randomIndex]
end

local function TargetSpawn(x, y, z, a, v)
    local model = joaat("prop_range_target_01")
    local shot = 0

    lib.requestModel(model)

    local obj = CreateObject(model, x, y, z, true, true, true)
    SetEntityProofs(obj, false, true, false, false, false, false, 0, false)
    SetEntityRotation(obj, GetEntityRotation(obj) + vector3(-90, 0.0, 0))
    PlaySoundFrontend(-1, "SHOOTING_RANGE_ROUND_OVER", "HUD_AWARDS", 1)

    local r = -90
    while r ~= 0 do
        SetEntityRotation(obj, GetEntityRotation(obj) + vector3(9, 0.0, 0))
        r = r + 9
        Wait(1)
    end

    DeleteEntity(obj)

    Wait(1)

    obj = CreateObject(model, x, y, z, true, true, true)
    local fin = 0

    while shot < a do
        Wait(0)
        fin = fin + 1
        if IsPedShooting(cache.ped) then
            Wait(100)
            if fin > v or HasEntityBeenDamagedByWeapon(obj, 0, 2) then
                PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
                shot = (fin > v) and (shot + 100) or (shot + 1)
                totalScore = (fin > v and totalScore) or (totalScore + 1)
                ClearEntityLastDamageEntity(obj)
            else
                PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
                shot = shot + 1
            end
        elseif fin > v then
            PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
            shot = shot + 100
        end
    end

    while r ~= -90 do
        SetEntityRotation(obj, GetEntityRotation(obj) - vector3(5, 0.0, 0))
        r = r - 5
        Wait(1)
    end

    DeleteEntity(obj)
    SetModelAsNoLongerNeeded(model)
end

function startTest(difficultyLevel)
    Debug('Starting Test Level Choosen: ', difficultyLevel)
    if alreadyInUse then
        Debug('Range Already in Use')
        lib.notify({
            id = 'range_in_use',
            title = 'Range System',
            description = 'The Firing Range is already in use!',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
            },
            icon = 'fas fa-exclamation',
            iconColor = '#C53030'
        })
        return
    end

    local playerPed = cache.ped
    local timer = 2000

    TriggerServerEvent('complex-gunrange:server:setInUse')

    DoScreenFadeOut(timer)

    Wait(4000)

    SetEntityHeading(playerPed, 181.556)
    SetEntityCoordsNoOffset(playerPed, 821.477, -2163.663, 29.657, 0)
    FreezeEntityPosition(playerPed, true)

    lib.requestAnimDict("anim@deathmatch_intros@1hmale")

    TaskPlayAnim(playerPed, "anim@deathmatch_intros@1hmale", "intro_male_1h_d_trevor", 8.0, 5.0, -1, true, 1, 0, 0, 0)
    DoScreenFadeIn(timer)

    Wait(10000)

    ClearPedTasks(playerPed)
    RemoveAnimDict("anim@deathmatch_intros@1hmale")

    totalScore = 0

    updateScore()

    PlaySoundFrontend(-1, "Checkpoint_Hit", "GTAO_FM_Events_Soundset", 0)
    Wait(1000)
    PlaySoundFrontend(-1, "Checkpoint_Hit", "GTAO_FM_Events_Soundset", 0)
    Wait(1000)
    PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 0)
    Wait(1000)

    local currentTarget = getRandomTargetLocation(Config.TargetLocations)

    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, 100)
    updateScore()

    T = Config.DifficultySettings.easymodetime
    R = 100
    if difficultyLevel == 2 then 
        T = Config.DifficultySettings.mediummodetime
        R = 75
    elseif difficultyLevel == 3 then
        T = Config.DifficultySettings.hardmodetime
        R = 50
    end
    Debug('Timer Set ', T)
    Wait(T)
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    Wait(T)
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    Wait(T)
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    Wait(T)
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    Wait(T)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    Wait(T)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    Wait(T)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    Wait(T)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    Wait(T)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    Wait(T)
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    Wait(T)
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    Wait(T)
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    Wait(T)
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    Wait(T)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    Wait(T)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    Wait(T)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    Wait(T)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    currentTarget = getRandomTargetLocation(Config.TargetLocations)
    Wait(T)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    Wait(T)
    TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
    updateScore()
    Wait(1000)
    finalScore()
end

local function openTestMenu()
    lib.hideTextUI()
    lib.showContext('main_firearms_menu')
end

function openDifficultyMenu()
    lib.showContext('difficulty_firearms_menu') 
end

RegisterNetEvent("complex-gunrange:setInUse", function(boolean)
    alreadyInUse = not alreadyInUse
    Debug('Firing Range in use set.', alreadyInUse)
end)

function onEnter(self)
    Debug('Entered Firearms Zone', self.id)
    lib.showTextUI('[E] - Open Firearms Menu')
    inFirearmsZone = true
end
 
function onExit(self)
    Debug('Exited Firearms Zone', self.id)
    lib.hideTextUI()
    inFirearmsZone = false
end

function insideZone(self)
    if IsControlJustPressed(0, 38) and inFirearmsZone then
        if exports['qb-policejob']:IsHandcuffed() then
            QBCore.Functions.Notify("You can't do this while handcuffed.", "error")
            return
        end
        openTestMenu()
    end    
end

local firearmsZone = lib.zones.box({
    coords = Config.ZoneSettings.location,
    size = Config.ZoneSettings.size,
    rotation = Config.ZoneSettings.rotation,
    debug = Config.Debug,
    inside = insideZone,
    onEnter = onEnter,
    onExit = onExit
})