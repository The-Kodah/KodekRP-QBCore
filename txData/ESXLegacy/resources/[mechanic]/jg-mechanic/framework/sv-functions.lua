---@param src integer
---@param msg string
---@param type "success" | "warning" | "error"
function Framework.Server.Notify(src, msg, type)
  TriggerClientEvent("jg-mechanic:client:notify", src, msg, type, 5000)
end

---@param src integer
---@returns boolean
function Framework.Server.IsAdmin(src)
  return IsPlayerAceAllowed(tostring(src), "command") or false
end

lib.callback.register("jg-mechanic:server:is-admin", function(src)
  return Framework.Server.IsAdmin(src)
end)

---@param vehicle integer
---@return string | false plate 
function Framework.Server.GetPlate(vehicle)
  local plate = GetVehicleNumberPlateText(vehicle)
  if not plate or plate == nil or plate == "" then return false end

  if GetResourceState("brazzers-fakeplates") == "started" then
    local result = MySQL.scalar.await("SELECT plate FROM player_vehicles WHERE fakeplate = ?", {fakeplate})
    if result then return result end
  end

  local trPlate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
  return trPlate
end

lib.callback.register("jg-mechanic:brazzers-fakeplates:getPlateFromFakePlate", function(_, fakeplate)
  local result = MySQL.scalar.await("SELECT plate FROM player_vehicles WHERE fakeplate = ?", {fakeplate})
  if result then return result end
  return false
end)

-- 
-- Inventory Items
--

---@param itemName string
---@param cb function
function Framework.Server.RegisterUsableItem(itemName, cb)
  if (Config.Inventory == "auto" and GetResourceState("ox_inventory") == "started") or Config.Inventory == "ox_inventory" then
    -- Blank intentionally - this is not required, and is done via items.lua
  elseif Config.Framework == "QBCore" or Config.Inventory == "qb-inventory" then
    QBCore.Functions.CreateUseableItem(itemName, cb)
  elseif Config.Framework == "ESX" or Config.Inventory == "esx_inventory" then
    ESX.RegisterUsableItem(itemName, cb)
  end
end

---@param src integer
---@param itemName string
---@param qty? integer
function Framework.Server.HasItem(src, itemName, qty)
  local itemCount = 0
  qty = qty or 1

  if (Config.Inventory == "auto" and GetResourceState("ox_inventory") == "started") or Config.Inventory == "ox_inventory" then
    itemCount = exports.ox_inventory:GetItem(src, itemName, nil, true) --[[@as number]]
  elseif Config.Framework == "QBCore" or Config.Inventory == "qb-inventory" then
    local Player = Framework.Server.GetPlayer(src)
    itemCount = Player.Functions.GetItemByName(itemName)?.amount or 0
  elseif Config.Framework == "ESX" or Config.Inventory == "esx_inventory" then
    local xPlayer = ESX.GetPlayerFromId(src)
    itemCount = xPlayer.getInventoryItem(itemName)?.count or 0
  else
    return false
  end

  if not itemCount or itemCount < qty then
    Framework.Server.Notify(src, Locale.itemNotInInventory:format(qty, Locale[itemName] or itemName), "error")
    return false
  end

  return true
end

lib.callback.register("jg-mechanic:server:has-item", Framework.Server.HasItem)

---@param src integer
---@param itemName string
---@param qty? integer
function Framework.Server.GiveItem(src, itemName, qty)
  qty = qty or 1

  if (Config.Inventory == "auto" and GetResourceState("ox_inventory") == "started") or Config.Inventory == "ox_inventory" then
    local added = exports.ox_inventory:AddItem(src, itemName, qty)
    if not added then return false end
  elseif Config.Framework == "QBCore" or Config.Inventory == "qb-inventory" then
    local Player = Framework.Server.GetPlayer(src)
    local added = Player.Functions.AddItem(itemName, qty)
    if not added then return false end
  elseif Config.Framework == "ESX" or Config.Inventory == "esx_inventory" then
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.addInventoryItem(itemName, qty)
  else
    return false
  end

  return true
end

---@param src integer
---@param itemName string
---@param qty? integer
function Framework.Server.RemoveItem(src, itemName, qty)
  qty = qty or 1

  local hasItem = Framework.Server.HasItem(src, itemName, qty)
  if not hasItem then return false end

  if (Config.Inventory == "auto" and GetResourceState("ox_inventory") == "started") or Config.Inventory == "ox_inventory" then
    local removed = exports.ox_inventory:RemoveItem(src, itemName, qty)
    if not removed then return false end
  elseif Config.Framework == "QBCore" or Config.Inventory == "qb-inventory" then
    local Player = Framework.Server.GetPlayer(src)
    local removed = Player.Functions.RemoveItem(itemName, qty)
    if not removed then return false end
  elseif Config.Framework == "ESX" or Config.Inventory == "esx_inventory" then
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeInventoryItem(itemName, qty)
  else
    return false
  end

  return true
end

RegisterNetEvent("jg-mechanic:server:remove-item", function(...)
  Framework.Server.RemoveItem(source, ...)
end)

--
-- Player
--

---@param src integer
function Framework.Server.GetPlayer(src)
  if Config.Framework == "QBCore" then
    return QBCore.Functions.GetPlayer(src)
  elseif Config.Framework == "Qbox" then
    return exports.qbx_core:GetPlayer(src)
  elseif Config.Framework == "ESX" then
    return ESX.GetPlayerFromId(src)
  end
end

---@param src integer
function Framework.Server.GetPlayerInfo(src)
  local player = Framework.Server.GetPlayer(src)
  if not player then return false end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return {
      name = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    }
  elseif Config.Framework == "ESX" then
    return {
      name = player.getName()
    }
  end
end

---@param identifier string
function Framework.Server.GetPlayerInfoFromIdentifier(identifier)
  local player = MySQL.single.await("SELECT * FROM " .. Framework.PlayersTable .. " WHERE " .. Framework.PlayersTableId .. " = ?", {identifier})
  if not player then return false end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local charinfo = json.decode(player.charinfo)
    return {
      name = charinfo.firstname .. " " .. charinfo.lastname
    }
  elseif Config.Framework == "ESX" then
    return {
      name = player.firstname .. " " .. player.lastname
    }
  end
end

---@param src integer
function Framework.Server.GetPlayerIdentifier(src)
  local player = Framework.Server.GetPlayer(src)
  if not player then return false end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return player.PlayerData.citizenid
  elseif Config.Framework == "ESX" then
    return player.getIdentifier()
  end
end

---@param identifier string
---@return integer | false src
function Framework.Server.GetPlayerFromIdentifier(identifier)
  if Config.Framework == "QBCore" then
    local player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    if not player then return false end
    return player.PlayerData.source
  elseif Config.Framework == "Qbox" then
    local player = exports.qbx_core:GetPlayerByCitizenId(identifier)
    if not player then return false end
    return player.PlayerData.source
  elseif Config.Framework == "ESX" then
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if not xPlayer then return false end
    return xPlayer.source
  end

  return false
end

-- 
-- Player Money
--

---@param src integer
---@param type "cash" | "bank" | "money"
function Framework.Server.GetPlayerBalance(src, type)
  local player = Framework.Server.GetPlayer(src)
  if not player then return 0 end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return player.PlayerData.money[type]
  elseif Config.Framework == "ESX" then
    if type == "cash" then type = "money" end

    for i, acc in pairs(player.getAccounts()) do
      if acc.name == type then
        return acc.money
      end
    end

    return 0
  end
end

---@param src integer
---@param amount number
---@param account "cash" | "bank" | "money"
function Framework.Server.PlayerAddMoney(src, amount, account)
  local player = Framework.Server.GetPlayer(src)
  account = account or "bank"

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    player.Functions.AddMoney(account, round(amount, 0))
  elseif Config.Framework == "ESX" then
    if account == "cash" then account = "money" end
    player.addAccountMoney(account, round(amount, 0))
  end
end

---@param src integer
---@param amount number
---@param account "cash" | "bank" | "money"
function Framework.Server.PlayerRemoveMoney(src, amount, account)
  local player = Framework.Server.GetPlayer(src)
  account = account or "bank"

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    player.Functions.RemoveMoney(account, round(amount, 0))
  elseif Config.Framework == "ESX" then
    if account == "cash" then account = "money" end
    player.removeAccountMoney(account, round(amount, 0))
  end
end

---For refunds - bank only
---@param identifier string
---@param amount number
function Framework.Server.PlayerAddMoneyOffline(identifier, amount)
  local src = Framework.Server.GetPlayerFromIdentifier(identifier)
  if src then
    return Framework.Server.PlayerAddMoney(src, amount, "bank")
  end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local money = MySQL.scalar.await("SELECT money FROM players WHERE citizenid = ?", {
      identifier
    })
    if not money then return false end

    local moneyData = json.decode(money)
    moneyData.bank = (moneyData.bank or 0) + amount

    MySQL.update.await("UPDATE players SET money = ? WHERE citizenid = ?", {
      json.encode(moneyData), identifier
    })
  elseif Config.Framework == "ESX" then
    local accounts = MySQL.scalar.await("SELECT accounts FROM users WHERE identifier = ?", {
      identifier
    })
    if not accounts then return false end

    local accountsData = json.decode(accounts)
    accountsData.bank = (accountsData.bank or 0) + amount

    MySQL.update.await("UPDATE users SET accounts = ? WHERE identifier = ?", {
      json.encode(accountsData), identifier
    })
  end
end

--
-- Player Job
--

---@param src integer
---@param job string
---@param role "manager" | "mechanic" | number
function Framework.Server.PlayerSetJob(src, job, role)
  local player = Framework.Server.GetPlayer(src)

  -- Adjust this as necessary for your job setup
  local rank = role
  if role == "Service Writer" then rank = 1 end
  if role == "Mechanic Apprentice" then rank = 2 end
  if role == "Mechanic" then rank = 3 end
  if role == "Manager" then rank = 4 end
  if role == "Owner" then rank = 5 end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    player.Functions.SetJob(job, rank)
  elseif Config.Framework == "ESX" then
    player.setJob(job, rank)
  end
end

---@param identifier string
---@param job string
---@param role "manager" | "mechanic" | number
function Framework.Server.PlayerSetJobOffline(identifier, job, role)
  -- Adjust this as necessary for your job setup
  local rank = role
  if role == "Service Writer" then rank = 1 end
  if role == "Mechanic Apprentice" then rank = 2 end
  if role == "Mechanic" then rank = 3 end
  if role == "Manager" then rank = 4 end
  if role == "Owner" then rank = 5 end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local jobsList = {}
    if Config.Framework == "QBCore" then jobsList = QBCore.Shared.Jobs
    elseif Config.Framework == "Qbox" then jobsList = exports.qbx_core:GetJobs() end

    if not jobsList[job] then return false end

    local jobData = {
      name = job,
      label = jobsList[job].label,
      onduty = jobsList[job].defaultDuty,
      type = jobsList[job].type or 'none',
      grade = {
        name = 'Service Writer',
        level = 1,
      },
      payment = 20,
      isboss = false
    }

    local jobData = {
      name = job,
      label = jobsList[job].label,
      onduty = jobsList[job].defaultDuty,
      type = jobsList[job].type or 'none',
      grade = {
        name = 'Mechanic Apprentice',
        level = 2,
      },
      payment = 40,
      isboss = false
    }

    local jobData = {
      name = job,
      label = jobsList[job].label,
      onduty = jobsList[job].defaultDuty,
      type = jobsList[job].type or 'none',
      grade = {
        name = 'Mechanic',
        level = 3,
      },
      payment = 80,
      isboss = false
    }

    local jobData = {
      name = job,
      label = jobsList[job].label,
      onduty = jobsList[job].defaultDuty,
      type = jobsList[job].type or 'none',
      grade = {
        name = 'Manager',
        level = 4,
      },
      payment = 200,
      isboss = false
    }

    local jobData = {
      name = job,
      label = jobsList[job].label,
      onduty = jobsList[job].defaultDuty,
      type = jobsList[job].type or 'none',
      grade = {
        name = 'Owner',
        level = 5,
      },
      payment = 500,
      isboss = true
    }

    if jobsList[job].grades[tostring(rank)] then
      local jobgrade = jobsList[job].grades[tostring(rank)]
      jobData.grade = {}
      jobData.grade.name = jobgrade.name
      jobData.grade.level = rank
      jobData.payment = jobgrade.payment or 30
      jobData.isboss = jobgrade.isboss or false
    end

    MySQL.update.await("UPDATE players SET job = ? WHERE citizenid = ?", {json.encode(jobData), identifier})
  elseif Config.Framework == "ESX" then
    MySQL.update.await("UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?", {job, rank, identifier})
  end
end

---@param toggle boolean
function Framework.Server.PlayerToggleJobDuty(src, toggle)
  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local Player = Framework.Server.GetPlayer(src)
    if Player.PlayerData.job.onduty then
      Player.Functions.SetJobDuty(false)
    else
      Player.Functions.SetJobDuty(true)
    end
    TriggerClientEvent('QBCore:Client:SetDuty', src, Player.PlayerData.job.onduty)
  elseif Config.Framework == "ESX" then
    -- Not supported natively in ESX, if you have a job script that supports it though add the export here!
  end
end

lib.callback.register("jg-mechanic:server:toggle-duty", function(src, toggle)
  Framework.Server.PlayerToggleJobDuty(src, toggle)
end)

--
-- Vehicle
--

---@param src integer
---@param vehicleHash number
lib.callback.register("jg-mechanic:server:dealerships-vehicle-value", function(src, vehicleHash)
  if not vehicleHash or GetResourceState("jg-dealerships") ~= "started" then return false end

  local price = MySQL.scalar.await("SELECT price FROM dealership_vehicles WHERE hashkey = ?", {vehicleHash})

  if not price or price == nil then return false end
  return price
end)

---@param src integer
---@param plate string
---@param props table
lib.callback.register("jg-mechanic:server:save-vehicle-props", function(src, plate, props)
  if not plate or not props or type(props) ~= "table" then
    return false
  end

  MySQL.update.await(
    "UPDATE " .. Framework.VehiclesTable .. " SET " .. Framework.VehProps .. " = ? WHERE plate = ?",
    { json.encode(props), plate }
  )

  return true
end)