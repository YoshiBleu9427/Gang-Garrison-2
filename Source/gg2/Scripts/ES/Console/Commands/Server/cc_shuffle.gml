console_addCommand("shuffle", "
/*
//HOST ONLY
*/
if global.RCONSentCommand=1{
    console_print(C_PINK+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print(C_ORNGE+global.RCONCommand_out)
    exit
}

if !global.isHost{
    console_print('Only the host can use this command.')
    exit;
}

ds_list_shuffle(global.map_rotation)
console_print('Map rotation shuffled.')
", "
console_print('Syntax: shuffle')
console_print('Randomly re-orders the map rotation.')
")
