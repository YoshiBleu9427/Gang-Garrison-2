console_addCommand("listBans", "
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

if !global.isHost{
    console_print('Only the host can use this command.')
    exit;
}

var text,textips;
text=file_text_open_read('Banned_IPs.txt')
textips=file_text_read_string(text)
console_print(string(textips))
file_text_close(text);
", "
console_print('Syntax: listBans')
console_print('Use: Shows every IP in your ban list.)
");
