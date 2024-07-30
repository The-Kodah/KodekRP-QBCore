-- Taken from es_extended
function CreateRadioObject(model, pos, cb)
    local model = (type(model) == 'number' and model or GetHashKey(model))

    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(100)
    end

    local obj = CreateObject(model, pos.x, pos.y, pos.z, true, false, false)
    if cb then
        cb(obj)
    end
end

-- custom notification setup
function ShowNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(0, 1)
end

-- Attaching radio to player
function AttachRadioToPed(object, ped)
    AttachEntityToEntity(object, ped, GetPedBoneIndex(GetPlayerPed(PlayerId()), 40269), -0.25, 0.1, 0.05, -65.0, 0.0, 90.0, 1, 1, 0, 1, 0, 1)
end

-- this will affect who can use radio, it wont affect who can place the radio.
-- if you want affect who can place the radio do it in "utils/server.lua"
function YourOwnPermission()
    return true
end