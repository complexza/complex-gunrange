fx_version 'cerulean'
game 'gta5'
author 'complexza'
description 'Gun Range Test Script for FiveM'
version '1.0'

client_script {
    'client/*.lua'
}

server_script {
    'server/*.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua'
}

lua54 'yes'