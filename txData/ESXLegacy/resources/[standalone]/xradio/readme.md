---

if you see error:  Bad binary format or syntax error near </1>

Read this guide: 
https://documentation.rcore.cz/cfx-auth-system/error-syntax-error-near-less-than-1-greater-than

i see "you lack the entitlement to run this resource"
Follow this guide: https://documentation.rcore.cz/cfx-auth-system/you-lack-the-entitlement

### ox inv

```LUA
['boombox'] = {
    label = 'boombox',
    weight = 250,
    close = true,
    consume = 1,
    client = {},
    server = {
        export = 'xradio.boombox',
    },
},
```

### qbcore inv

```LUA
['boombox'] = {
    ['name'] = 'boombox',
    ['label'] = 'boombox',
    ['weight'] = 500,
    ['type'] = 'item',
    ['image'] = 'boombox.png',
    ['unique'] = false,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'boombox'
},
```

### esx 1.1

```SQL
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES ('boombox', 'boombox', '5', '0', '1');
```

### esx 1.2 and above

```SQL
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('boombox', 'boombox', '1', '0', '1');
```

### Optional API to use

---

All of these functions are client sided only.

---

Something like a jukebox

- AddVirtualRadio(vector, uniqid)

```LUA
CreateThread(function()
    -- uniq ID must be same for each client or the information wont be synced.
    -- if you type /radio or hit the E key (depends whats in config) it will open
    -- "virtual" radio
    exports.xradio:AddVirtualRadio(vector3(-32, -1106, 26), "pdm_shop")
end)
```


Basic functions from xradio (all of them are exports)

- IsRadioClose() -- return true / false
- IsRadioOnShoulder() -- return true / false
- DeleteShoulderRadio() -- will delete the radio on player shoulder, and give the radio back to his inventory.

Menu events

```LUA
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
```

Real example on MenuAPI from https://github.com/Xogy/MenuAPI

```LUA
AddEventHandler("xradio:menuOpened", function(type)
    if type == "ground" then
        local menu = Menu:CreateMenu("identifier")

        menu.SetMenuTitle("Radio")

        menu.SetProperties(Config.MenuProperties)

        menu.AddItem(1, _T("open_radio") or "open radio", function()
            menu.Close()
            TriggerEvent("xradio:openRadio")
        end)

        menu.AddItem(2, _T("take_radio") or "pick radio", function()
            menu.Close()
            TriggerEvent("xradio:deleteRadioOnGround")
        end)

        if Config.radioOnShoulder then
            menu.AddItem(3, _T("radio_shoulder") or "Radio on shoulder", function()
                menu.Close()
                TriggerEvent("xradio:radioOnShoulder")
            end)
        end
        menu.Open()
    end

    if type == "shoulder" then
        local menu = Menu:CreateMenu("identifier")

        menu.SetMenuTitle("Radio")

        menu.SetProperties(Config.MenuProperties)

        menu.AddItem(1, _T("shoulder_open_radio") or "open radio", function()
            menu.Close()
            TriggerEvent("xradio:openShoulderUi")
        end)

        menu.AddItem(2, _T("shoulder_hide_radio") or "hide radio", function()
            menu.Close()
            TriggerEvent("xradio:hideShoulderRadio")
        end)

        menu.AddItem(3, _T("put_back_radio") or "Put back radio on ground", function()
            menu.Close()
            TriggerEvent("xradio:putRadioBackGround")
        end)


        menu.Open()
    end
end)
```

---