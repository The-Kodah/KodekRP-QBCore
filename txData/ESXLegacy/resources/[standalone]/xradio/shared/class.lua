Locales = {}

-- this is for translation
function _U(str, ...)
    if type(Locales) ~= "table" then
        return string.format("[%s] the locales is wrong type, it is not a table..", GetCurrentResourceName())
    end
    if not Locales[Config.Locale] then
        return string.format("[%s] The language does not exists: %s", GetCurrentResourceName(), Config.Locale)
    end
    if not Locales[Config.Locale][str] then
        return string.format("[%s] There isnt such [%s] translation", GetCurrentResourceName(), str)
    end
    return string.format(Locales[Config.Locale][str], ...)
end

-- Will register a key bind for action defined in "fc" argument name
--- @param fc delegate
--- @param uniqid string
--- @param description string
--- @param key string
--- @param device string
function RegisterKey(fc, uniqid, description, key, device)
    RegisterCommand(uniqid, fc, false)
    RegisterKeyMapping(uniqid, description, device or 'keyboard', key)
end

function GetEsxObject()
    local promise_ = promise:new()
    local obj
    xpcall(function()
        obj = exports["es_extended"]['getSharedObject']()
        promise_:resolve(obj)
    end, function(error)
        TriggerEvent(Config.ESX or "esx:getSharedObject", function(module)
            obj = module
            promise_:resolve(obj)
        end)
    end)

    Citizen.Await(obj)
    return obj
end

function ExtractDomainNameFromURL(url)
    local domain = url:match("^https?://([^/]+)")
    if not domain then
        domain = url:match("^(%w+%.%w+)")
    end
    if domain then
        return domain
    else
        return ""
    end
end

function IsMusicWhitelisted(URL)
    local domain = ExtractDomainNameFromURL(URL)
    for _, whitelistURL in pairs(Config.WhitelistedURL) do
        if string.find(domain, whitelistURL, 1, true) then
            return true
        end
    end
    return false
end