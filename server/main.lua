local QBCore = exports['qb-core']:GetCoreObject()  -- Imports the QBCore Stuff

-- Sets Range In Use
RegisterNetEvent('complex-gunrange:server:setInUse', function()
    TriggerClientEvent('complex-gunrange:setInUse', -1)
end)

-- Event to Give Results Receipt
RegisterNetEvent('complex-gunrange:giveResultReceipt', function(score)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local date = os.date('%Y-%m-%d %H:%M')
    local fullname = ''..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..''
    local info = {
        citizenname = fullname,
        score = score,
        date = date,
    }
    if not Player.Functions.AddItem('gunrangereceipt', 1, false, info) then
        TriggerClientEvent('ox_lib:notify', src, {
            id = 'range_item_sent',
            title = 'Range System',
            description = 'Youre pockets was full, You couldnt receive the test results receipt!',
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
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['gunrangereceipt'], 'add')
    TriggerClientEvent('ox_lib:notify', src, {
        id = 'range_item_sent',
        title = 'Range System',
        description = 'You have received a receipt with your test results!',
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
        },
        icon = 'fas fa-exclamation',
        iconColor = '#C53030'
    })
end)