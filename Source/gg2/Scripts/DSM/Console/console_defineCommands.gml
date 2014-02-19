//This defines all the built-in commands
//input[1] = first argument, input[2] = second, etc...

//it seems sticking a bracket in console_print will fuck it up, great parsing game maker as always

console_addCommand("help", "
var command;
command=Console.input[1]

if command == ''{
    var key;
    // User didn't ask any specific command, just give the general command list and infos.
    console_print('DSM '+string(DSM_VERSION_STRING)+' console;');
    console_print('');
    console_print('Usage: Type in the wanted command followed by its arguments in this syntax:');
    console_print('command argument1 argument2 argument3')
    console_print('');
    console_print('If an argument contains spaces, please surround it with '+chr(34)+' '+chr(34)+'.');
    console_print('Some commands require Player IDs, the command '+chr(34)+'listPlayers'+chr(34)+' can show them to you.');
    console_print('All commands are camel case, beginning with a lower case letter.');
    console_print('');
    console_print('The current command list:');
    key = ds_map_find_first(global.commandMap_DSM);
    console_print(key);
    for (i=0; i<ds_map_size(global.commandMap_DSM)-1; i+=1){
        key = ds_map_find_next(global.commandMap_DSM, key);
        console_print(key);
    }
    console_print('')
    console_print('For more details on each command, enter '+chr(34)+'help commandName'+chr(34)+'.')
    console_print('----------------------------------------------------------------------------------');
}else{
    if ds_map_exists(global.documentationMap, command){
        execute_string(ds_map_find_value(global.documentationMap, command));
    }else{
        console_print('No documentation could be found for that command.');
    }
}
", "
console_print('Try entering help once, not twice.');
");


console_addCommand("kick", "
// Check whether we are the host before anything else
if not global.isHost{
    console_print('Only the host can use this command.');
    exit;
}
var player;
// Check whether a name or a ID was given
if string_letters(input[1]) == ''{
    // No letters were given
    // First check whether that ID is even valid
    if floor(real(string_digits(input[1]))) < ds_list_size(global.players) and floor(real(string_digits(input[1]))) > 0{
        // Valid ID, kick that player
        player = ds_list_find_value(global.players, floor(real(string_digits(input[1]))));
        with player{
            socket_destroy_abortive(socket);
            socket = -1;
        }
        console_print(string_replace_all(player.name, '/:/', '/;/')+' has been kicked successfully.');
        global.playerNameC=player.name
        kickMessage()
        exit;
    }else if floor(real(string_digits(input[1]))) == 0{
        // Can't kick yourself
        console_print('The host cannot be kicked.');
    }
}
// If that system above did not work, try checking names
with Player{
    if name == other.input[1]{
        // Don't kick the host
        if id == global.myself{
            console_print('The host cannot be kicked.');
            continue;
        }
        // Found the name, kick that player
        socket_destroy_abortive(socket);
        socket = -1;
        console_print(string_replace_all(name, '/:/', '/;/')+' has been kicked successfully.');
        global.playerNameC=name
        kickMessage()
        exit;
    }
}
// We failed
console_print('Could not find a player with that ID or name.');

", "
console_print('Syntax: kick playerID/playerName')
console_print('Use: Kicks the designed player from the game, disconnecting him but not banning him.')
console_print('Warning: IDs will be considered before names, so if a name of player x is equal to')
console_print('         the ID of player y, player y will get kicked.')
console_print('         Also, attempting to kick the host will have no effect.')");


console_addCommand("ban", "
// Check whether we are the host before anything else
if not global.isHost{
    console_print('Only the host can use this command.');
    exit;
}
var player;
// Check whether a name or a ID was given
if string_letters(input[1]) == ''{
    // No letters were given
    // First check whether that ID is even valid
    if floor(real(string_digits(input[1]))) < ds_list_size(global.players) and floor(real(string_digits(input[1]))) > 0{
        // Valid ID, ban that player
        player = ds_list_find_value(global.players, floor(real(string_digits(input[1]))));
        ds_list_add(global.banned_ips, socket_remote_ip(player.socket));
        with player{
            socket_destroy_abortive(socket);
            socket = -1;
        }
        // Write it now in a file
        var text, str, i;
        str = ''
        for (i=0; i<ds_list_size(global.banned_ips); i+=1){
            // chr(10) == newline
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
        // Can't ban yourself
        console_print('The host cannot be banned.');
    }
}
// If that system above did not work, try checking names
with Player{
    if name == other.input[1]{
        // Don't ban the host
        if id == global.myself{
            console_print('The host cannot be banned.');
            continue;
        }
        // Found the name, ban that player
        ds_list_add(global.banned_ips, socket_remote_ip(socket));
        socket_destroy_abortive(socket);
        socket = -1;
        
        // Write it now in a file
        var text, str, i;
        str = ''
        for (i=0; i<ds_list_size(global.banned_ips); i+=1){
            // chr(10) == newline
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
// We failed
console_print('Could not find a player with that ID or name.');

", "
console_print('Syntax: ban playerID/playerName')
console_print('Use: Bans the designed player from the game, disconnecting him and preventing him from ever joining again.')
console_print('Warning: IDs will be considered before names, so if a name of player x is equal to')
console_print('         the ID of player y, player y will get banned.')
console_print('         Also, attempting to ban the host will have no effect.')
console_print('You can unban a person by removing their ip from the banlist, this will not take effect until the server is restarted.')");

console_addCommand("tempBan", "
// Check whether we are the host before anything else
if not global.isHost{
    console_print('Only the host can use this command.');
    exit;
}
var player;
// Check whether a name or a ID was given
if string_letters(input[1]) == ''{
    // No letters were given
    // First check whether that ID is even valid
    if floor(real(string_digits(input[1]))) < ds_list_size(global.players) and floor(real(string_digits(input[1]))) > 0{
        // Valid ID, ban that player
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
        // Can't ban yourself
        console_print('The host cannot be banned.');
    }
}
// If that system above did not work, try checking names
with Player{
    if name == other.input[1]{
        // Don't ban the host
        if id == global.myself{
            console_print('The host cannot be banned.');
            continue;
        }
        // Found the name, ban that player
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
// We failed
console_print('Could not find a player with that ID or name.');

", "
console_print('Syntax: tempBan playerID/playerName')
console_print('Use: Bans the designed player from the game, disconnecting him and preventing him from joining until the server is restarted.')
console_print('Warning: IDs will be considered before names, so if a name of player x is equal to')
console_print('         the ID of player y, player y will get banned.')
console_print('         Also, attempting to ban the host will have no effect.')
console_print('The player will be banned from the server until it is restarted as their ip is not written to the ban list.')
");

console_addCommand("listBans", "
var text,textips;
text=file_text_open_read('Banned_IPs.txt')
textips=file_text_read_string(text)
console_print(string(textips))
file_text_close(text);
", "
console_print('Syntax: listBans')
console_print('Use: Shows every IP in the players ban list, ban lists aren't sent to clients so it just shows yours.)
");

console_addCommand("listPlayers", "
var redteam, blueteam, specteam, player;
redteam = ds_list_create();
blueteam = ds_list_create();
specteam = ds_list_create();

with Player{
    if team == TEAM_RED{
        ds_list_add(redteam, id);
    }else if team == TEAM_BLUE{
        ds_list_add(blueteam, id);
    }else{
        ds_list_add(specteam, id);
    }
}

console_print('')
console_print('Current Player list:')

for (i=0; i<ds_list_size(redteam); i+=1){
    player = ds_list_find_value(redteam, i);
    //dsmPlayer=ds_list_find_value(global.dsmPlayers,i)
    //if dsmPlayer==true{
        //console_print('/:/'+COLOR_RED+string_replace_all(player.name, '/:/', '/;/')+':    ID='+string(ds_list_find_index(global.players, player.id))+'/:/'+COLOR_RED+'   |   DSM');
    //}else{
        console_print('/:/'+COLOR_RED+string_replace_all(player.name, '/:/', '/;/')+':    ID='+string(ds_list_find_index(global.players, player.id)));
    //}
}
for (i=0; i<ds_list_size(blueteam); i+=1){
    player = ds_list_find_value(blueteam, i);
    //dsmPlayer=ds_list_find_value(global.dsmPlayers,i)
    //if dsmPlayer==true{
        //console_print('/:/'+COLOR_BLUE+string_replace_all(player.name, '/:/', '/;/')+':    ID='+string(ds_list_find_index(global.players, player.id))+'/:/'+COLOR_BLUE+'   |   DSM');
    //}else{
        console_print('/:/'+COLOR_BLUE+string_replace_all(player.name, '/:/', '/;/')+':    ID='+string(ds_list_find_index(global.players, player.id)));
    //}
}
for (i=0; i<ds_list_size(specteam); i+=1){
    player = ds_list_find_value(specteam, i);
    //dsmPlayer=ds_list_find_value(global.dsmPlayers,i)
    //if dsmPlayer==true{
        //console_print('/:/'+COLOR_GREEN+string_replace_all(player.name, '/:/', '/;/')+':    ID='+string(ds_list_find_index(global.players, player.id))+'/:/'+COLOR_GREEN+'   |   DSM');
    //}else{
        console_print('/:/'+COLOR_GREEN+string_replace_all(player.name, '/:/', '/;/')+':    ID='+string(ds_list_find_index(global.players, player.id)));
    //}
}
", "
console_print('Syntax: listPlayers')
console_print('Use: Prints a color-coded list of the IDs of all the players in the game.')
console_print('These IDs are necessary for anything requiring a specific player, like kicking.')");


console_addCommand("clearScreen", "
with Console{
    clearScreenTimer = 36// Makes text zoom up instead of just disappearing
}
", "
console_print('Syntax: clearScreen')
console_print('Use: Clears the console.')");


console_addCommand("broadcast", "
if not global.isHost{
    console_print('Only the host can use this command.');
    exit;
}

if input[1] != ''{
    var message;
    message = input[1];
    if string_copy(message, 0, 1) == chr(34){
        // Cut off starting and ending quotes
        message = string_copy(message, 2, string_length(message)-2);
    }
    message = string_copy(message, 0, 255);
    
    // Send it to everyone
    write_ubyte(global.sendBuffer, MESSAGE_STRING);
    write_ubyte(global.sendBuffer, string_length(message));
    write_string(global.sendBuffer, message);
    // Show it for the host as well
    var notice;
    with NoticeO instance_destroy();
    notice = instance_create(0, 0, NoticeO);
    notice.notice = NOTICE_CUSTOM;
    notice.message = message;
}
", "
console_print('Syntax: broadcast '+chr(34)+'message to be sent'+chr(34));
console_print('Use: Makes all clients receive a notification bearing the message.');
console_print('Warning: If spaces are in the message, remember to surround the message in double-quotes!');
");

console_addCommand("shuffleRotation", "
if not global.isHost{
    console_print('Only the host can use this command.')
    exit
}
ds_list_shuffle(global.map_rotation)
console_print('The map rotation has been shuffled.')
", "
console_print('Syntax: shuffleRotation')
console_print('Use: Randomly re-order the map rotation.')
")

console_addCommand("endRound", "
if not global.isHost{
    console_print('Only the host can use this command.')
    exit
}
global.winners=TEAM_SPECTATOR
console_print('The round has been ended.')
", "
console_print('Syntax: endRound')
console_print('Use: End the round as a draw.')
")

console_addCommand("serverPassword", "
if not global.isHost{
    console_print('Only the host can use this command.')
    exit
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
console_addCommand("fps", "
if global.displayingFPS==0{
    instance_create(0,0,fpsDisplay)
    console_print('FPS display turned on.')
}else{
    global.displayingFPS=0
    console_print('FPS display turned off.')
}
", "
console_print('Syntax: fps')
console_print('Use: Displays the user's current FPS at the top of the screen.')
console_print('Entering the command will toggle the FPS display.')
")

console_addCommand("ping", "
if global.displayingPing==0{
    instance_create(0,0,pingDisplay)
    console_print('Ping display turned on.')
}else{
    global.displayingPing=0
    console_print('Ping display turned off.')
}
", "
console_print('Syntax: ping')
console_print('Use: Displays the user's current ping at the bottom of the screen.')
console_print('Entering the command will toggle the ping display.')
")

console_addCommand("execute", "
execute_string(input[1]);
", "
console_print('Syntax: execute '+chr(34)+'<code>'+chr(34));
console_print('Use: Executes the given code immediately.');
console_print('Warning: Can cause crashes, use at own responsibility!');
");

console_addCommand("quit", "
game_end()
", "
console_print('Syntax: quit')
console_print('Use: Closes the game.')
")

console_addCommand("nextMap", "
if not global.isHost{
    console_print('Only the host can use this command.')
    exit
}
var nextMap;
nextMap=input[1]

if!(findInternalMapRoom(nextMap) or file_exists('Maps/' + nextMap + '.png')){
    console_print(nextMap+' is not a valid map name. Ensure you have the map in your maps folder and have spelt it correctly.')
    exit;
}

ds_list_insert(global.map_rotation,GameServer.currentMapIndex,nextMap)
global.nextMap=nextMap
global.dsmMapChange=1
GameServer.currentMapIndex+=1
console_print('The next map is: '+nextMap)
", "
console_print('Syntax: nextMap '+chr(34)+'<map name>'+chr(34))
console_print('Use: Sets the next map to the desired map.')
console_print('Warning: An incorrect map name may lead to the server crashing; check your maps first.')
")

console_addCommand("classlimits", "
if not global.isHost{
    console_print('Only the host can use this command.')
    exit
}

var class, number;
//In case they don't get set
class=''
number=1

//What we want
class=input[1]
number=input[2]

//To make sure it works fine
class=string(class)
number=real(number)


//Get the class name
if class=='Scout' or class=='scout' or class=='Runner' or class=='runner' or class=='Jello' or class=='jello' or class=='Sc' or class=='sc'  or class=='Ru'  or class=='ru'{ //Scout
    global.classlimits[CLASS_SCOUT]=number
    console_print('Scout limit changed to '+string(number)+'.')
}else if class=='Pyro' or class=='pyro' or class=='Firebug' or class=='firebug' or class=='Fire' or class=='fire' or class=='F' or class=='f'  or class=='P'  or class=='p'{ //Pyro
    global.classlimits[CLASS_PYRO]=number
    console_print('Pyro limit changed to '+string(number)+'.')
}else if class=='Soldier' or class=='soldier' or class=='Rocketman' or class=='rocketman' or class=='Solly' or class=='solly' or class=='So' or class=='so'  or class=='Ro'  or class=='ro'{ //Soldier
    global.classlimits[CLASS_SOLDIER]=number
    console_print('Soldier limit changed to '+string(number)+'.')
}else if class=='Heavy' or class=='heavy' or class=='Overweight' or class=='overweight' or class=='Fat' or class=='fat' or class=='H' or class=='h'  or class=='O'  or class=='o'{ //Heavy
    global.classlimits[CLASS_HEAVY]=number
    console_print('Heavy limit changed to '+string(number)+'.')
}else if class=='Demoman' or class=='demoman' or class=='Detonator' or class=='detonator' or class=='Demo' or class=='demo' or class=='Deto' or class=='deto' or class=='D' or class=='d'{ //Demoman
    global.classlimits[CLASS_DEMOMAN]=number
    console_print('Demoman limit changed to '+string(number)+'.')
}else if class=='Medic' or class=='medic' or class=='Healer' or class=='healer' or class=='Med' or class=='med' or class=='M' or class=='m'  or class=='He'  or class=='he'{ //Medic
    global.classlimits[CLASS_MEDIC]=number
    console_print('Medic limit changed to '+string(number)+'.')
}else if class=='Engineer' or class=='engineer' or class=='Constructor' or class=='constructor' or class=='Engie' or class=='engie' or class=='E' or class=='e'  or class=='C'  or class=='c'{ //Engie
    global.classlimits[CLASS_ENGINEER]=number
     console_print('Engineer limit changed to '+string(number)+'.')
}else if class=='Spy' or class=='spy' or class=='Infiltrator' or class=='infiltrator' or class=='Sp' or class=='sp' or class=='I'  or class=='i'{ //Spy
    global.classlimits[CLASS_SPY]=number
    console_print('Spy limit changed to '+string(number)+'.')
}else if class=='Sniper' or class=='sniper' or class=='Rifleman' or class=='rifleman' or class=='Sn' or class=='sn'  or class=='R'  or class=='r'{ //Sniper
    global.classlimits[CLASS_SNIPER]=number
    console_print('Sniper limit changed to '+string(number)+'.')
}else if class=='Quote' or class=='quote' or class=='Curly' or class=='curly' or class=='QC' or class=='qc' or class=='Q/C' or class=='q/c' or class=='Q'  or class=='Cu'  or class=='q'  or class=='cu'{ //Q/C
    global.classlimits[CLASS_QUOTE]=number
    console_print('Quote/Curly limit changed to '+string(number)+'.')
}else if class=='All' or class=='all' or class=='A' or class=='a' or class=='Every' or class=='every' or class=='Ev' or class=='ev'{
    global.classlimits[CLASS_SCOUT]=number
    global.classlimits[CLASS_PYRO]=number
    global.classlimits[CLASS_SOLDIER]=number
    global.classlimits[CLASS_HEAVY]=number
    global.classlimits[CLASS_DEMOMAN]=number
    global.classlimits[CLASS_MEDIC]=number
    global.classlimits[CLASS_ENGINEER]=number
    global.classlimits[CLASS_SPY]=number
    global.classlimits[CLASS_SNIPER]=number
    global.classlimits[CLASS_QUOTE]=number
    console_print('All limits changed to '+string(number)+'.')
}else{
    console_print(class+' is not a valid class. For a list of possible class names type '+chr(34)+'help classlimits'+chr(34)+'.')
}

","
console_print('Syntax: classlimit '+chr(34)+'<class name> <number>'+chr(34)+')
console_print('Use: Set classlimits in-game.')
console_print('Warning: Might not sync with clients properly. The settings will not be saved to the gg2.ini file, meaning they will not carry over between startups.')
//So extensive :P
console_print('List of possible names:')
console_print('Scout/Runner: Scout, scout, Runner, runner, Jello, jello, Sc, sc, Ru, ru')
console_print('Pyro/Firebug: Pyro, pyro, Firebug, firebug, Fire, fire, F, f, P, p')
console_print('Soldier/Rocketman: Soldier, soldier, Rocketman, rocketman, Solly, solly, So, so, Ro, ro')
console_print('Heavy/Overweight: Heavy, heavy, Overweight, overweight, Fat, fat, H, h, O, o')
console_print('Demoman/Detonator: Demoman, demoman, Detonator, detonator, Demo, demo, Deto, deto, D, d')
console_print('Medic/Healer: Medic, medic, Healer, healer, Med, med, M, m, He, he')
console_print('Engineer/Constructor: Engineer, engineer, Constructor, constructor, Engie, engie, E, e, C, c')
console_print('Spy/Infiltrator: Spy, spy, Infiltrator, infiltrator, Sp, sp, I, i')
console_print('Sniper/Rifleman: Sniper, sniper, Rifleman, rifleman, Sn, sn, R, r')
console_print('Quote/Curly: Quote, quote, Curly, curly, QC, qc, Q/C, q/c, Q, Cu, q, cu')
console_print('All/Every: All, all, A, a, Every, every, Ev, ev')
")

