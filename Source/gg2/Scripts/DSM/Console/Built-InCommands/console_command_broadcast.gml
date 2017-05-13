console_addCommand("broadcast", "
var command;
command=input[0]+' '+input[1]
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

if input[1] != ''{
    var message;
    message = input[1];
    if string_copy(message, 0, 1) == chr(34){
        //Cut off starting and ending quotes
        message = string_copy(message, 2, string_length(message)-2);
    }
    message = string_copy(message, 0, 255);
    
    //Send it to everyone
    write_ubyte(global.sendBuffer, MESSAGE_STRING);
    write_ubyte(global.sendBuffer, string_length(message));
    write_string(global.sendBuffer, message);
    //Show it for the host as well
    var notice;
    with NoticeO instance_destroy();
    notice = instance_create(0, 0, NoticeO);
    notice.notice = NOTICE_CUSTOM;
    notice.message = string(message)
}
", "
console_print('Syntax: broadcast <message to be sent>');
console_print('Use: Makes all clients receive a notification bearing the message.');
console_print('Warning: If spaces are in the message, remember to surround the message in double-quotes!');
");
