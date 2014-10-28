console_addCommand("rcon","
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

if input[1]='login'{
    if global.isHost{
        console_print('Only clients can use this command.');
        exit;
    }
    var password;
    password=string(input[2])
    write_ubyte(global.serverSocket,DSM_RCON_LOGIN)
    write_ubyte(global.serverSocket,string_length(password)) //command length
    write_string(global.serverSocket,password) //password string
    socket_send(global.serverSocket)
}

if input[1]='add'{
    if !global.isHost{
        console_print('Only the host can use this command.');
        exit;
    }
    var player;
    //Check whether a name or a ID was given
    if string_letters(input[2]) == ''{
        //No letters were given
        //First check whether that ID is even valid
        if floor(real(string_digits(input[2]))) < ds_list_size(global.players) and floor(real(string_digits(input[2]))) > 0{
            //Valid ID, kick that player
            player = ds_list_find_value(global.players, floor(real(string_digits(input[2]))));
        
            write_ubyte(player.socket,DSM_RCON_LOGIN)
            write_ubyte(player.socket,DSM_RCON_LOGIN_SUCCESSFUL)
            ds_list_add(global.RCONList,player)
            console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+player.name+' is now a RCON.')
            exit;
        }else if floor(real(string_digits(input[2]))) == 0{
            //Can't kick yourself
            console_print('The host cannot be made a RCON.');
        }
    }
    //If that system above did not work, try checking names
    with Player{
        if name == other.input[2]{
            //Don't kick the host
            if id == global.myself{
                console_print('The host cannot be made a RCON.');
                continue;
            }
            //Found the name, kick that player
            write_ubyte(player.socket,DSM_RCON_LOGIN)
            write_ubyte(player.socket,DSM_RCON_LOGIN_SUCCESSFUL)
            ds_list_add(global.RCONList,player)
            console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+name+' is now a RCON.')
            exit;
        }
    }
    //We failed
    console_print('Could not find a player with that ID or name.');
    exit;
}

if input[1]='remove'{
    if !global.isHost{
        console_print('Only the host can use this command.');
        exit;
    }
    var player;
    //Check whether a name or a ID was given
    if string_letters(input[2]) == ''{
        //No letters were given
        //First check whether that ID is even valid
        if floor(real(string_digits(input[2]))) < ds_list_size(global.players) and floor(real(string_digits(input[2]))) > 0{
            //Valid ID, kick that player
            player = ds_list_find_value(global.players, floor(real(string_digits(input[2]))));
            if ds_list_find_value(global.RCONList, floor(real(string_digits(input[2]))))!=-1{
            
                write_ubyte(player.socket,DSM_RCON_LOGIN)
                write_ubyte(player.socket,DSM_RCON_LOGIN_FAILED)
                ds_list_delete(global.RCONList,ds_list_find_index(global.RCONList,player))
                console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+player.name+' is no longer a RCON.')
                exit;
            }
        }else if floor(real(string_digits(input[2]))) == 0{
            //Can't kick yourself
            console_print('The host cannot be made a RCON.');
        }
    }
    //If that system above did not work, try checking names
    with Player{
        if name == other.input[2]{
            //Don't kick the host
            if id == global.myself{
                console_print('The host cannot be made a RCON.');
                continue;
            }
            //Found the name, kick that player

            if ds_list_find_value(global.RCONList, floor(real(string_digits(input[2]))))!=-1{
                write_ubyte(player.socket,DSM_RCON_LOGIN)
                write_ubyte(player.socket,DSM_RCON_LOGIN_FAILED)
                ds_list_delete(global.RCONList,ds_list_find_index(global.RCONList,player))
                console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+name+' is no longer a RCON.')
                exit;
            }
        }
    }
    //We failed
    console_print('Could not find a player with that ID or name.');
    exit;
}
", "
console_print('Syntax: rcon login <password>')
console_print('Use: Clients request to be made a RCON on the server by sending the correct password.')
console_print('')
console_print('Syntax: rcon <add/remove> <playerID/playerName>')
console_print('Use: Host can add or remove RCONs.')
");
