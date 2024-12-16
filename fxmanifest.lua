fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'FRSK Utils - Utility functions for RedM scripts'
version '1.0.0'

client_scripts {
    'config.lua',
    'client/main.lua'
}

server_scripts {
    './server/server.lua'
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
    'HidePrompt'
}