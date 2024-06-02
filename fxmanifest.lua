fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'PirateScripts'
description 'Hidden mission to steal cars'
version '1.0.0'

shared_script {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua',
}

client_script {
    'client/client.lua',
}

server_script {
    'server/server.lua',
}