Config = {}

-- locales
Config.Locale = "en"

-- 0 standalone
-- 1 ESX
-- 2 QBCore
Config.FrameWork = 1

-- this is domain name so allow anything that you would like to be allowed
Config.WhitelistedURL = {
    "youtube",
    "youtu",
    "discordapp",
    "actve",
    "streamtheworld",
    "play",
}

-- ox inv
Config.ox_inv = true

-- codem-inv option
Config.codem_inventory = false

-- ESX shared object
Config.ESX_Object = "esx:getSharedObject"

Config.GetQBCoreObject = function()
    -- Choose your objectType or made here your own.
    local objectType = 1

    if objectType == 1 then
        return exports['qb-core']:GetCoreObject()
    end

    if objectType == 2 then
        return exports['qb-core']:GetSharedObject()
    end

    if objectType == 3 then
        local QBCore = nil
        local breakPoint = 0
        while not QBCore do
            Wait(100)
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)

            breakPoint = breakPoint + 1
            if breakPoint == 25 then
                print(string.format("^1[%s]^7 Could not load the sharedobject, are you sure it is called ^1˙QBCore:GetObject˙^7?", GetCurrentResourceName()))
                break
            end
        end

        return QBCore
    end
end

-- if you're using no framework you can specify how many radios will player have in "pocket"
Config.DefaultRadioCountInInventory = 2

-- what object to spawn as a radio?
Config.RadioObject = "prop_boombox_01"

-- Custom menu?
Config.CustomMenu = false
--[[

You need to implement this logic by your self for your custom menu.

AddEventHandler("xradio:menuOpened", function(type)
    if type == "ground" then
        TriggerEvent("xradio:openRadio") -- will open the radio UI on ground
        TriggerEvent("xradio:radioOnShoulder") -- will equip the radio to shoulder
        TriggerEvent("xradio:deleteRadioOnGround") -- will remove the radio from ground
    end

    if type == "shoulder" then
        TriggerEvent("xradio:openShoulderUi") -- will open the radio UI on shoulder
        TriggerEvent("xradio:hideShoulderRadio") -- will remove the radio from user shoulder
        TriggerEvent("xradio:putRadioBackGround") -- will put radio back to the ground
    end
end)
--]]

-- Animation for holding radio on shoulder
Config.Animations = {
    PlacingRadio = {
        dic = "anim@heists@money_grab@briefcase",
        anim = "put_down_case",
    },
    HoldingRadio = {
        dic = "missfinale_c2mcs_1",
        anim = "fin_c2_mcs_1_camman",
    }
}

-- Is radio on shoulder enabled?
Config.radioOnShoulder = true

-- default settings.
Config.Distance = 15
Config.volume = 0.5
Config.VolumeAdjust = 0.05

-- how close player has to be to radio to something happen
Config.distanceFromRadio = 3.0

-- only who spawned can interact
Config.onlyAutor = false

-- an item name.
Config.itemName = "boombox"

-- Menu properties
Config.MenuProperties = {
    float = "right",
    position = "middle",
}

-- Change to true if your item doesnt have a weight.
Config.oldEsxInventory = false

-- a key what you will open the radio with.
Config.KeyRadio = "M"

--if you enable command the keyRadio will not work. It will be only for a command
Config.enableCommand = false
Config.commandOpen = "boombox"

Config.defaultStation = {
    "http://ice.actve.net/fm-evropa2-128",
    "https://20423.live.streamtheworld.com/FAJN_RADIO_128.mp3",
    "http://icecast6.play.cz/cesky-impuls.mp3",
    "https://19993.live.streamtheworld.com/HITRADIO_ORION_128.mp3",
}

--For devs only, do not change it unless you know what you're doing
Config.removeDistance = 3.0

-- How much ofter the player position is updated ?
Config.RefreshTime = 300

-- how much close player has to be to the sound before starting updating position ?
Config.distanceBeforeUpdatingPos = 40

-- Message list
Config.Messages = {
    ["streamer_on"]  = "Streamer mode is on. From now you will not hear any music/sound.",
    ["streamer_off"] = "Streamer mode is off. From now you will be able to listen to music that players might play.",
}

-- use external xsound?
Config.UseExternalxSound = false

-- if you want to use high_3dsounds
Config.UseHighSound = false

-- name of the lib
Config.xSoundName = "xsound"

if Config.UseHighSound then
    Config.xSoundName = "high_3dsounds"
    Config.UseExternalxSound = true
end