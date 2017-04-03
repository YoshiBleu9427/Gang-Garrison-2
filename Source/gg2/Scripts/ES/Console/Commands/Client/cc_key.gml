console_addCommand("key", "
/*
//CLIENT
*/
if global.RCONSentCommand=1{
    console_print(C_PINK+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print(C_ORNGE+global.RCONCommand_out)
    exit
}

console_print('Checking key code...')
show_message('Press any key.')
console_print(keyboard_lastkey)
", "
console_print('Syntax: key')
console_print('Used to check the key code for a key')
")

