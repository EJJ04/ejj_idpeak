fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'EJJ_04'
description 'ID Peek using ox_lib'
version '1.0.0'

client_scripts {
    'config.lua',
    'client.lua'
}

shared_scripts {
    '@ox_lib/init.lua'
}

dependencies {
    'ox_lib'
}
