Config = {}

-- Debug Options
Config.Debug = false
function Debug(...)
    if Config.Debug then
        print(...)
    end
end

-- Main Blip Settings // WIP
Config.Blip = {
    enabled = false, -- true / false
    location = vector3(821.46, -2163.57, 29.66), -- Coords for the Blip
    sprite = 147, -- Sprite Settings
    scale = 0.5, -- Scale of the Blip
    label = 'Ammunation Test' -- Blip Label
}

-- Main Zone Settings
Config.ZoneSettings = {
    location = vec4(821.46, -2163.57, 29.66, 181), -- Main Middle Point (This location is for the ammunation by bobcat area)
    size = vec3(2, 4, 3), -- Size of Poly Zone X Y Z
    rotation = 90 -- Heading Of Poly Zone
}

Config.DifficultySettings = { -- Less Time == Harder
    easymodetime = 1000,
    mediummodetime = 500,
    hardmodetime = 250,
}

Config.TargetLocations = { -- Popup Locations for Targets.
    { x = 826.701, y = -2171.449 },
    { x = 824.588, y = -2171.393 },
    { x = 822.058, y = -2171.258 },
    { x = 819.853, y = -2171.35 },
    { x = 817.223, y = -2171.293 },
    { x = 816.428, y = -2180.542 },
    { x = 818.678, y = -2180.556 },
    { x = 821.051, y = -2180.49 },
    { x = 823.112, y = -2180.499 },
    { x = 825.06, y = -2180.514 },
    { x = 826.297, y = -2180.558 },
    { x = 826.784, y = -2191.586 },
    { x = 824.875, y = -2191.548 },
    { x = 823.196, y = -2191.56 },
    { x = 821.123, y = -2191.599 },
    { x = 819.525, y = -2191.561 },
    { x = 818.209, y = -2191.575 },
    { x = 816.858, y = -2191.564 }
}
