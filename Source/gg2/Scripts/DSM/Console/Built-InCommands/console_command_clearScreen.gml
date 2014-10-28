console_addCommand("clearScreen", "
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

with Console{
    clearScreenTimer = 36//Makes text zoom up instead of just disappearing
}
", "
console_print('Syntax: clearScreen')
console_print('Use: Clears the console.')");
