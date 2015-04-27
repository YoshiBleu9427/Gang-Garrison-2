console_addCommand("unmute","
var command;
command=input[0]
if global.isRCON==1 and !global.isHost{
    //Parse string
    var stringLength;
    stringLength=string_length(string(command))
        
    write_ubyte(global.serverSocket,DSM_RCON_COMMAND)
    write_ubyte(global.serverSocket,stringLength) //command length
    write_string(global.serverSocket,command) //string
    socket_send(global.serverSocket)
    exit;
}else if !global.isHost{
    console_print('Only the host/RCON can use this command.')
    exit;
}

if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
}
if !global.isHost{
    console_print('Only the host/RCON can use this command.')
    exit;
}
//arctic a shit
with(Player){
    if (ds_list_find_value(global.chatBanlist,socket_remote_ip(socket))){
        hasChat=true
    }
}
ds_list_clear(global.chatBanlist)
console_print('Mute list cleared.')
", "
console_print('Syntax: unmute');
console_print('Use: Unmutes all players on the server. Only use this with the chat/chat_v2 server sent plugin.');
");
