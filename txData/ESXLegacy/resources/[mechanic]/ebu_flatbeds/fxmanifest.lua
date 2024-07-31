fx_version 'adamant'
game 'gta5'
lua54 'yes'

description 'Flatbeds Winch Script'
author 'Theebu'

version '0.7.2'

shared_scripts {
	'config.lua',
}

client_scripts {
	'client/utils.lua',
	'client/client.lua'
}

server_scripts {
	'server/server.lua'
}

escrow_ignore {
	'config.lua',
	'client/utils.lua'
}
dependency '/assetpacks'