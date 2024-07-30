Config = {}

Config.Locale = GetConvar('esx:locale', 'en')
Config.EnableESXIdentity = true
Config.MaxSalary = 3500

Config.BossGrades = { -- Uncomment and/or add additional grades you want to have access to the boss menu.
    ['boss'] = true,
    ['owner'] = true,
    --['staff2'] = false,
    --['staff3'] = false,
}
