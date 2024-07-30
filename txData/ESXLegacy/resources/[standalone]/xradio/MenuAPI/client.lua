CachedMenu = {}
--------------
-- Sending info about changing item in menu
--------------
RegisterKey(function()
    SendNUIMessage({ type_menu = "up" })
end, "menuapiup_xradioo", "menu go up", "UP")

RegisterKey(function()
    SendNUIMessage({ type_menu = "down" })
end, "menuapidown_xradioo", "menu go down", "DOWN")

-----

RegisterKey(function()
    SendNUIMessage({ type_menu = "up" })
end, "menuapiup_xradiomouse.", "menu go up", "IOM_WHEEL_UP", "MOUSE_WHEEL")

RegisterKey(function()
    SendNUIMessage({ type_menu = "down" })
end, "menuapidown_xradiomouse.", "menu go down", "IOM_WHEEL_DOWN", "MOUSE_WHEEL")
--------------
-- Sending info about selecting item
--------------
RegisterKey(function()
    SendNUIMessage({ type_menu = "enter" })
end, "menuapie_xradio_mouseaa", "Mouse right", "MOUSE_LEFT", "MOUSE_BUTTON")

RegisterKey(function()
    SendNUIMessage({ type_menu = "enter" })
end, "menuapie_xradio", "Key E", "E")

RegisterKey(function()
    SendNUIMessage({ type_menu = "enter" })
end, "menuapienter_xradio", "Key ENTER", "RETURN")
--------------
-- closing menu keys
--------------
RegisterKey(function()
    ExitAllOpenedMenu()
end, "menuapiesc_xradio", "Key ESC", "escape")

RegisterKey(function()
    ExitAllOpenedMenu()
end, "menuapiescaper_xradio", "Key backspace", "back")
--------------