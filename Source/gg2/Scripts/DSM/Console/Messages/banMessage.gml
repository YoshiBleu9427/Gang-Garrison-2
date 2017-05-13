sendMsg='Banned:·'
global.playerNameC=string_replace_all(global.playerNameC,' ','·')
message=string(sendMsg+global.playerNameC)
broadcast=string('broadcast '+message)
console_parseInput(broadcast)
