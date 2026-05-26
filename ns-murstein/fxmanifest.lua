fx_version  'cerulean'
game        'gta5'
lua54       'yes'

name        'ns-pedalbrick'
description 'Brick on vehicle pedal.'
author      'Birdy113 / alex'

version '1.3.4'

files {
    'client.lua',
    'server.lua'
}

shared_script {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua', -- Comment if you don't use QBox.
    'locales/*.lua',
    'config.lua'
}

client_script {
    '@qbx_core/modules/playerdata.lua', -- Comment if you don't use QBox.
    'client.lua',
}

server_script {
    'server.lua',

}

escrow_ignore {
	"config.lua",
}