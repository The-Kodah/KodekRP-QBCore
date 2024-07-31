-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

-- Customize this to customize text UI accross all Wasabi Scripts

-- Text UI
local textUI = false

-- Show text UI
function WSB.showTextUI(msg)
    -- EDIT: Customize with your own text UI system
    if GetResourceState('wasabi_textui') == 'started' then
        exports.wasabi_textui:showTextUI(msg)
        textUI = msg
        return
    end

    if GetResourceState('ox_lib') == 'started' then
        exports.ox_lib:showTextUI(msg)
        textUI = msg
        return
    end
    
    print('^0[^3WARNING^0] No TextUI system detected! Please add ox_lib OR customize at customize/client/textUI.lua^0')
end

-- Hide text UI
function WSB.hideTextUI()
    if GetResourceState('wasabi_textui') == 'started' then
        exports.wasabi_textui:hideTextUI()
        textUI = false
        return
    end

    if GetResourceState('ox_lib') == 'started' then
        exports.ox_lib:hideTextUI()
        textUI = false
        return
    end

    print('^0[^3WARNING^0] No TextUI system detected! Please add ox_lib OR customize at customize/client/textUI.lua^0')

    -- EDIT: Customize with your own text UI system
end

-- Checking for text UI
function WSB.isTextUIOpen()
    return textUI and true or false, textUI or false
end
