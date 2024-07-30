fx_version 'cerulean'
games { 'gta5' }

version "1.0.2"

dependencies {
    '/server:4752',
    '/onesync',
}

shared_scripts {
    "shared/class.lua",
}

client_scripts {
    "locales/*.lua",

    "config.lua",

    "MenuAPI/exports/*.lua",
    "MenuAPI/system/*.lua",
    "MenuAPI/module/*.lua",
    "MenuAPI/*.lua",

    "xSound/effects/*.lua",
    "xSound/exports/*.lua",
    "xSound/*.lua",

    "utils/client.lua",
    "client/*.lua",
}

server_scripts {
    "locales/*.lua",

    "config.lua",
    "utils/server.lua",
    "server/*.lua",
}

escrow_ignore {
    "locales/*.lua",
    "config.lua",
    "utils/*.lua",
    "shared/class.lua",

    "xSound/effects/*.lua",
    "xSound/exports/*.lua",
    "xSound/*.lua",

    "MenuAPI/exports/*.lua",
    "MenuAPI/system/*.lua",
    "MenuAPI/module/*.lua",
    "MenuAPI/*.lua",
}

lua54 "yes"

ui_page "html/index.html"

files {
    "html/*.html",
    "html/css/*.css",

    "html/scripts/*.js",

    "html/MenuAPI/*.js",
    "html/MenuAPI/*.html",
    "html/MenuAPI/*.css",

    "html/xSound/*.js",
    "html/xSound/*.html",
    "html/xSound/*.css",

    "html/css/img/*.png",
}
dependency '/assetpacks'