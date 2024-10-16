fx_version 'cerulean'
game 'gta5'

name "lumberjack"
author "Berry"
version "1.0.0"

lua54 'yes'
use_experimental_fxv2_oal 'yes'

shared_scripts {
	"@ox_lib/init.lua",
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}
