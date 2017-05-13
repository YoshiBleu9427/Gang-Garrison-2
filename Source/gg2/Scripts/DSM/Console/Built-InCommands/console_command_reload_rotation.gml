console_addCommand("reloadrotation", "
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

if !global.isHost{
    console_print('Only the host can use this command.')
    exit;
}

load_map_rotation()

console_print('Reloaded map rotation from file.')

", "
console_print('Syntax: reloadrotation')
");
