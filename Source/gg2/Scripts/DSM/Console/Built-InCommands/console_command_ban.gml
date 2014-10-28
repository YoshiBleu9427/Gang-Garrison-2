console_addCommand("ban", "
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

if !global.isHost{
    console_print('Only the host can use this command.')
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
        //Write it now in a file
        var text, str, i;
        str = ''
        for (i=0; i<ds_list_size(global.banned_ips); i+=1){
            //chr(10) == newline
            str += ds_list_find_value(global.banned_ips, i) + chr(10);
        }
        text = file_text_open_write('Banned_IPs.txt');
        file_text_write_string(text, str);
        file_text_close(text);
        
        console_print(string_replace_all(player.name, '/:/', '/;/')+' has been banned successfully.');
        global.playerNameC=player.name
        banMessage()
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
        
        //Write it now in a file
        var text, str, i;
        str = ''
        for (i=0; i<ds_list_size(global.banned_ips); i+=1){
            //chr(10) == newline
            str += ds_list_find_value(global.banned_ips, i) + chr(10);
        }
        text = file_text_open_write('Banned_IPs.txt');
        file_text_write_string(text, str);
        file_text_close(text);
        
        console_print(string_replace_all(name, '/:/', '/;/')+' has been banned successfully.');
        global.playerNameC=name
        banMessage()
        exit;
    }
}
//We failed
console_print('Could not find a player with that ID or name.');

", "
console_print('Syntax: ban <playerID/playerName>')
console_print('Use: Bans the designed player from the game, disconnecting him and preventing him from ever joining again.')
console_print('Warning: IDs will be considered before names, so if a name of player x is equal to')
console_print('         the ID of player y, player y will get banned.')
console_print('         Also, attempting to ban the host will have no effect.')
console_print('You can unban a person by removing their ip from the banlist, this will not take effect until the server is restarted.')");
