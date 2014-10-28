console_addCommand("kill", "
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

var player;
//Check whether a name or a ID was given
if string_letters(input[1]) == ''{
    //No letters were given
    //First check whether that ID is even valid
    //if floor(real(string_digits(input[1]))) < ds_list_size(global.players) and floor(real(string_digits(input[1]))) > 0{
        //Valid ID, kill
        player = ds_list_find_value(global.players, floor(real(string_digits(input[1]))));
        if(player.object!=-1){
            player.object.hp = -9999
            console_print(string_replace_all(player.name, '/:/', '/;/')+' was killed.');
        }else{
            console_print(string_replace_all(player.name, '/:/', '/;/')+' is not alive.');
        }
        exit;
    //}
}
//If that system above did not work, try checking names
with Player{
    if name == other.input[1]{
        //Found the name, kill
        if(object!=-1){
            object.hp = -9999
            console_print(string_replace_all(name, '/:/', '/;/')+' was killed.');
        }else{
            console_print(string_replace_all(name, '/:/', '/;/')+' is not alive.');
        }
        exit;
    }
}
//We failed
console_print('Could not find a player with that ID or name.');
", "
console_print('Syntax: kill <playerID/playerName>')
console_print('Use: Kills selected player.')
")
