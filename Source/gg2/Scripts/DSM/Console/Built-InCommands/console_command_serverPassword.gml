console_addCommand("serverPassword", "
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

if !global.isHost{
    console_print('Only the host can use this command.')
    exit;
}

var newPass;
newPass=input[1]
global.serverPassword=newPass
//Write the new password to the ini.
ini_open('gg2.ini')
    ini_write_string('Server','Password',newPass)
ini_close()
console_print('The password has been set to: '+global.serverPassword)
", "
console_print('Syntax: serverPassword '+chr(34)+'password'+chr(34))
console_print('Use: Changes the sever password. It does write to the .ini.')
")
