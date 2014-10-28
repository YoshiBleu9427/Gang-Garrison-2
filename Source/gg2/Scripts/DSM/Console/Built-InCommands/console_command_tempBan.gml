console_addCommand("tempBan", "
//HOST+RCON ONLY
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
    if floor(real(string_digits(input[1]))) < ds_list_size(global.players) and floor(real(string_digits(input[1]))) > 0{
        //Valid ID, ban that player
        player = ds_list_find_value(global.players, floor(real(string_digits(input[1]))));
        ds_list_add(global.banned_ips, socket_remote_ip(player.socket));
        with player{
            socket_destroy_abortive(socket);
            socket = -1;
        }
        //We don't write it to a file, this way it is not permanent        
        console_print(string_replace_all(player.name, '/:/', '/;/')+' has been temporarily banned successfully.');
        global.playerNameC=player.name
        tempBanMessage()
        exit;
    }else if floor(real(string_digits(input[1]))) == 0{
        //Can't ban yourself
        console_print('The host cannot be banned.');
    }
}
//If that system above did not work, try checking names
with Player{
    if name == other.input[1]{
        //Don't ban the host
        if id == global.myself{
            console_print('The host cannot be banned.');
            continue;
        }
        //Found the name, ban that player
        ds_list_add(global.banned_ips, socket_remote_ip(socket));
        socket_destroy_abortive(socket);
        socket = -1;

        //We don't write it to a file, this way it is not permanent 

        console_print(string_replace_all(name, '/:/', '/;/')+' has been temporarily banned successfully.');
        global.playerNameC=name
        tempBanMessage()
        exit;
    }
}
//We failed
console_print('Could not find a player with that ID or name.');

", "
console_print('Syntax: tempBan <playerID/playerName>')
console_print('Use: Bans the designed player from the game, disconnecting him and preventing him from joining until the server is restarted.')
console_print('Warning: IDs will be considered before names, so if a name of player x is equal to')
console_print('         the ID of player y, player y will get banned.')
console_print('         Also, attempting to ban the host will have no effect.')
console_print('The player will be banned from the server until it is restarted as their ip is not written to the ban list.')
");
