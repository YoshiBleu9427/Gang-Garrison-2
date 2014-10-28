console_addCommand("nextMap", "
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
var _nextMap;
_nextMap=input[1]

if!(findInternalMapRoom(_nextMap) or file_exists('Maps/' + _nextMap + '.png')){
    console_print(_nextMap+' is not a valid map name. Ensure you have the map in your maps folder and have spelt it correctly.')
    exit;
}

global.nextMap=_nextMap
global.dsmMapChange=1

console_print('The next map is: '+_nextMap)
", "
console_print('Syntax: nextMap <map name>')
console_print('Use: Sets the next map to the desired map.')
console_print('Warning: An incorrect map name may lead to the server crashing; check your maps first.')
")
