function ExitAllOpenedMenu()
    for k,v in pairs(CachedMenu) do
        if v.self.IsOpen() then
            v.self.Destroy()
        end
    end
    SendNUIMessage({ type_menu = "ui", status = false })
end

function CloseAllOpenedMenu()
    for k,v in pairs(CachedMenu) do
        v.self.Close()
    end
    SendNUIMessage({ type_menu = "ui", status = false })
end

function IsAnyMenuOpen()
    for k,v in pairs(CachedMenu) do
        if v.self.IsOpen() then
            return true
        end
    end
    return false
end