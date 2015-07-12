console_addCommand("record", "
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

if !global.isHost{
    console_print('Only the host can use this command.')
    exit;
}
if (!global.recordingReplay){
    beginRecording();
}
", "
console_print('Syntax: record')
console_print('Use: Begins/stops a replay recording.')
")
