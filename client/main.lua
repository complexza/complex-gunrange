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

    obj = CreateObject(model, x, y, z, true, true, true)
    SetEntityProofs(obj, false, true, false, false, false, false, 0, false)
    SetEntityRotation(obj, GetEntityRotation(obj) + vector3(-90, 0.0, 0))
    PlaySoundFrontend(-1, "SHOOTING_RANGE_ROUND_OVER", "HUD_AWARDS", 1)
    RotateEntity(obj, 90, 1)

    local fin = 0

    while shot < a do
        Wait(0)
        fin = fin + 1
        if IsPedShooting(cache.ped) and (fin <= v or HasEntityBeenDamagedByWeapon(obj, 0, 2)) then
            PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
            shot = shot + 1
            totalScore = totalScore + (fin > v and 0 or 1)
            ClearEntityLastDamageEntity(obj)
        elseif fin > v then
            shot = a
        end
    end

    RotateEntity(obj, -90, -5)
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

    local difficultySettings = {
        {time = Config.DifficultySettings.easymodetime, reaction = 100, targets = 10},
        {time = Config.DifficultySettings.mediummodetime, reaction = 75, targets = 15},
        {time = Config.DifficultySettings.hardmodetime, reaction = 50, targets = 20}
    }
    local settings = difficultySettings[difficultyLevel] or difficultySettings[1]
    T = settings.time
    R = settings.reaction
    Debug('Timer Set ', T)

    for i = 1, settings.targets do
        local currentTarget = getRandomTargetLocation(Config.TargetLocations)
        TargetSpawn(currentTarget.x, currentTarget.y, 29.45, 1, R)
        updateScore()
        Wait(T)
    end

    finalScore()
end

local function openTestMenu()
    lib.hideTextUI()
    lib.showContext('main_firearms_menu')
end

function openDifficultyMenu()
    lib.showContext('difficulty_firearms_menu') 
end

function RotateEntity(entity, degrees, step)
    local rotation = 0
    while rotation ~= degrees do
        SetEntityRotation(entity, GetEntityRotation(entity) + vector3(step, 0.0, 0))
        rotation = rotation + step
        Wait(1)
    end
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
