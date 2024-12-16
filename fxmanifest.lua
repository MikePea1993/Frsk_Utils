fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'FRSK Development'
description 'FRSK Utils - Utility functions for RedM scripts'
version '1.0.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/server.lua',
    'server/version.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/styles.css',
    'html/script.js'
}

exports {
    'CreatePrompt',
    'RemovePrompt',
    'ShowPrompt',
    'HidePrompt',
    'ShowNotification'
}

server_exports {
    'getCurrentVersion'
}