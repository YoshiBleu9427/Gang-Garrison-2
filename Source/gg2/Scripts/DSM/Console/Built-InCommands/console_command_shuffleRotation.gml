console_addCommand("shufflerotation", "
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

if !global.isHost{
    console_print('Only the host can use this command.')
    exit;
}

ds_list_shuffle(global.map_rotation)
console_print('The map rotation has been shuffled.')
", "
console_print('Syntax: shuffleRotation')
console_print('Use: Randomly re-order the map rotation.')
")
