//This defines all the built-in commands
//input[1] = first argument, input[2] = second, etc...

//it seems sticking a bracket in console_print will fuck it up, great parsing game maker as always

console_addCommand("help", "
var command;
command=Console.input[1]

if command == ''{
    var key;
    //User didn't ask any specific command, just give the general command list and infos.
    console_print('DSM '+string(DSM_VERSION_STRING)+' console;');
    console_print('');
    console_print('-Usage: Type in the wanted command followed by its arguments in this syntax: command argument1 argument2 argument3');
    //console_print('');
    console_print('-If an argument contains spaces, please surround it with '+chr(34)+' '+chr(34)+'.');
    console_print('-Some commands require Player IDs, the command '+chr(34)+'listPlayers'+chr(34)+' can show them to you.');
    console_print('-All commands are camel case, beginning with a lower case letter.');
    //console_print('');
    console_print('-The current command list:');
    key = ds_map_find_first(global.DSM_commandMap);
    console_print(key);
    for (i=0; i<ds_map_size(global.DSM_commandMap)-1; i+=1){
        key = ds_map_find_next(global.DSM_commandMap, key);
        console_print(key);
    }
    console_print('')
    console_print('For more details on each command, enter '+chr(34)+'help commandName'+chr(34)+'.')
    console_print('----------------------------------------------------------------------------------');
}else{
    if ds_map_exists(global.DSM_documentationMap, command){
        execute_string(ds_map_find_value(global.DSM_documentationMap, command));
    }else{
        console_print('No documentation could be found for that command.');
    }
}
", "
console_print('Try entering help once, not twice.');
");


console_addCommand("kick", "
//Check whether we are the host before anything else
if not global.isHost{
    console_print('Only the host can use this command.');
    exit;
}
var player;
//Check whether a name or a ID was given
if string_letters(input[1]) == ''{
    //No letters were given
    //First check whether that ID is even valid
    if floor(real(string_digits(input[1]))) < ds_list_size(global.players) and floor(real(string_digits(input[1]))) > 0{
        //Valid ID, kick that player
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
        //Can't kick yourself
        console_print('The host cannot be kicked.');
    }
}
//If that system above did not work, try checking names
with Player{
    if name == other.input[1]{
        //Don't kick the host
        if id == global.myself{
            console_print('The host cannot be kicked.');
            continue;
        }
        //Found the name, kick that player
        socket_destroy_abortive(socket);
        socket = -1;
        console_print(string_replace_all(name, '/:/', '/;/')+' has been kicked successfully.');
        global.playerNameC=name
        kickMessage()
        exit;
    }
}
//We failed
console_print('Could not find a player with that ID or name.');

", "
console_print('Syntax: kick <playerID/playerName>')
console_print('Use: Kicks the designed player from the game, disconnecting him but not banning him.')
console_print('Warning: IDs will be considered before names, so if a name of player x is equal to')
console_print('         the ID of player y, player y will get kicked.')
console_print('         Also, attempting to kick the host will have no effect.')");


console_addCommand("ban", "
//Check whether we are the host before anything else
if not global.isHost{
    console_print('Only the host can use this command.');
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

console_addCommand("tempBan", "
//Check whether we are the host before anything else
if not global.isHost{
    console_print('Only the host can use this command.');
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

console_addCommand("listBans", "
var text,textips;
text=file_text_open_read('Banned_IPs.txt')
textips=file_text_read_string(text)
console_print(string(textips))
file_text_close(text);
", "
console_print('Syntax: listBans')
console_print('Use: Shows every IP in your ban list.)
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
    clearScreenTimer = 36//Makes text zoom up instead of just disappearing
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
    notice.message = message;
}
", "
console_print('Syntax: broadcast <message to be sent>');
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

console_addCommand("execute", "
execute_string(input[1]);
", "
console_print('Syntax: execute '<code>');
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
console_print('Syntax: nextMap <map name>')
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
if class=='scout' or class=='runner' or class=='r'{ //Scout
    global.classlimits[CLASS_SCOUT]=number
    console_print('Scout limit changed to '+string(number)+'.')
}else if class=='pyro' or class=='firebug' or class=='p'{ //Pyro
    global.classlimits[CLASS_PYRO]=number
    console_print('Pyro limit changed to '+string(number)+'.')
}else if class=='soldier' or class=='rocketman' or class=='so'{ //Soldier
    global.classlimits[CLASS_SOLDIER]=number
    console_print('Soldier limit changed to '+string(number)+'.')
}else if class=='heavy' or class=='overweight' or class=='h'{ //Heavy
    global.classlimits[CLASS_HEAVY]=number
    console_print('Heavy limit changed to '+string(number)+'.')
}else if class=='demoman' or class=='detonator' or class=='demo' or class=='deto' or class=='d'{ //Demoman
    global.classlimits[CLASS_DEMOMAN]=number
    console_print('Demoman limit changed to '+string(number)+'.')
}else if class=='medic' or class=='healer' or class=='med' or class=='m'{ //Medic
    global.classlimits[CLASS_MEDIC]=number
    console_print('Medic limit changed to '+string(number)+'.')
}else if class=='engineer' or class=='constructor' or class=='engie' or class=='e'{ //Engie
    global.classlimits[CLASS_ENGINEER]=number
     console_print('Engineer limit changed to '+string(number)+'.')
}else if class=='spy' or class=='infiltrator' or class=='i'{ //Spy
    global.classlimits[CLASS_SPY]=number
    console_print('Spy limit changed to '+string(number)+'.')
}else if class=='sniper' or class=='rifleman' or class=='s'{ //Sniper
    global.classlimits[CLASS_SNIPER]=number
    console_print('Sniper limit changed to '+string(number)+'.')
}else if class=='quote' or class=='curly' or class=='qc' or class=='q/c'{ //Q/C
    global.classlimits[CLASS_QUOTE]=number
    console_print('Quote/Curly limit changed to '+string(number)+'.')
}else if class=='all' or class=='a'{
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
console_print('Syntax: classlimit <class name> <number>')
console_print('Use: Set classlimits in-game.')
console_print('Warning: Might not sync with clients properly. The settings will not be saved to the gg2.ini file, meaning they will not carry over between startups.')
console_print('')
console_print('List of possible names:')
console_print('Scout/Runner: scout, runner, r')
console_print('Pyro/Firebug: pyro, firebug, p')
console_print('Soldier/Rocketman: soldier, rocketman, so')
console_print('Heavy/Overweight: heavy, overweight, h')
console_print('Demoman/Detonator: demoman, detonator, demo, deto, d')
console_print('Medic/Healer: medic, healer, med, m')
console_print('Engineer/Constructor: engineer, constructor, engie, e')
console_print('Spy/Infiltrator: spy, infiltrator, i')
console_print('Sniper/Rifleman: sniper, rifleman, s')
console_print('Quote/Curly: quote, curly, qc, q/c')
console_print('All Classes: all, a')
")

console_addCommand("dropIntel", "
if not global.isHost{
    console_print('Only the host can use this command.')
    exit
}

var player;
//Check whether a name or a ID was given
if string_letters(input[1]) == ''{
    //No letters were given
    //First check whether that ID is even valid
    //if floor(real(string_digits(input[1]))) < ds_list_size(global.players) and floor(real(string_digits(input[1]))) > 0{
        //Valid ID, force intel drop
        player = ds_list_find_value(global.players, floor(real(string_digits(input[1]))));
        if (player.object.intel=true) and (player.object!=-1){
            write_byte(global.serverSocket, DROP_INTEL)
            sendEventDropIntel(player);
            doEventDropIntel(player);
            console_print(string_replace_all(player.name, '/:/', '/;/')+' was forced to drop the intel.');
        }else{
            console_print(string_replace_all(player.name, '/:/', '/;/')+' does not have the intel.');
        }
        exit;
    //}
}
//If that system above did not work, try checking names
with Player{
    if name == other.input[1]{
        //Found the name, force intel drop
        if (object.intel=true) and (object!=-1){
            write_byte(global.serverSocket, DROP_INTEL)
            sendEventDropIntel(Player);
            doEventDropIntel(Player);
            console_print(string_replace_all(name, '/:/', '/;/')+' was forced to drop the intel.');
        }else{
            console_print(string_replace_all(name, '/:/', '/;/')+' does not have the intel.');
        }
        exit;
    }
}
//We failed
console_print('Could not find a player with that ID or name.');
", "
console_print('Syntax: dropIntel <playerID/playerName>')
console_print('Use: Forces a player to drop the intel.')
")

console_addCommand("kill", "
if not global.isHost{
    console_print('Only the host can use this command.')
    exit
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

console_addCommand("time", "
if not global.isHost{
    console_print('Only the host can use this command.')
    exit
}

var time;
time=floor(real(input[1]))*30*60

with(HUD){
    if instance_exists(CTFHUD){
        CTFHUD.timer=time
        GameServer.syncTimer=1
    }
    if instance_exists(ControlPointHUD){
        ControlPointHUD.timer=time
        GameServer.syncTimer=1
    }
    if instance_exists(DKothHUD){
        DKothHUD.timer=time
        GameServer.syncTimer=1
    }
    if instance_exists(KothHUD){
        KothHUD.timer=time
        GameServer.syncTimer=1
    }
    if instance_exists(GeneratorHUD){
        GeneratorHUD.timer=time
        GameServer.syncTimer=1
    }
    if instance_exists(TeamDeathmatchHUD){
        TeamDeathmatchHUD.timer=time
        GameServer.syncTimer=1
    }
    if instance_exists(InvasionHUD){
        InvasionHUD.timer=time
        GameServer.syncTimer=1
    }
}
", "
console_print('Syntax: time <number of minutes>')
console_print('Use: Changes current time to defined time in minutes.')
")

console_addCommand("lock", "
if not global.isHost{
    console_print('Only the host can use this command.')
    exit
}

if input[1]=='red'{
    global.locked_red=1
    console_print('Locked red team.')
}else if input[1]=='blue'{
    global.locked_blue=1
    console_print('Locked blue team.')
}else if input[1]=='scout' or input[1]=='runner' or input[1]=='r'{
    global.locked_scout=1
    console_print('Locked Scout.')
}else if input[1]=='pyro' or input[1]=='firebug' or input[1]=='p'{
    global.locked_pyro=1
    console_print('Locked Pyro.')
}else if input[1]=='soldier' or input[1]=='rocketman' or input[1]=='so'{
    global.locked_soldier=1
    console_print('Locked Soldier.')
}else if input[1]=='heavy' or input[1]=='overweight' or input[1]=='h'{
    global.locked_heavy=1
    console_print('Locked Heavy.')
}else if input[1]=='demoman' or input[1]=='detonator' or input[1]=='demo' or input[1]=='deto' or input[1]=='d'{
    global.locked_demoman=1
    console_print('Locked Demoman.')
}else if input[1]=='medic' or input[1]=='healer' or input[1]=='med' or input[1]=='m'{
    global.locked_medic=1
    console_print('Locked Medic.')
}else if input[1]=='engineer' or input[1]=='constructor' or input[1]=='engie' or input[1]=='e'{
    global.locked_engie=1
    console_print('Locked Engineer.')
}else if input[1]=='spy' or input[1]=='infiltrator' or input[1]=='i'{
    global.locked_spy=1
    console_print('Locked Spy.')
}else if input[1]=='sniper' or input[1]=='rifleman' or input[1]=='s'{
    global.locked_sniper=1
    console_print('Locked Sniper.')
}else if input[1]=='quote' or input[1]=='curly' or input[1]=='qc' or input[1]=='q/c'{
    global.locked_quote=1
    console_print('Locked Quote/Curly.')
}else{
    console_print('This is not a valid team or class.')
}
", "
console_print('Syntax: lock <team/class>')
console_print('Use: Prevent any new players from joining that team or using that class.')
console_print('These are accepted inputs for teams: red, blue')
console_print('These are accepted inputs for classes:')
console_print('Scout/Runner: scout, runner, r')
console_print('Pyro/Firebug: pyro, firebug, p')
console_print('Soldier/Rocketman: soldier, rocketman, so')
console_print('Heavy/Overweight: heavy, overweight, h')
console_print('Demoman/Detonator: demoman, detonator, demo, deto, d')
console_print('Medic/Healer: medic, healer, med, m')
console_print('Engineer/Constructor: engineer, constructor, engie, e')
console_print('Spy/Infiltrator: spy, infiltrator, i')
console_print('Sniper/Rifleman: sniper, rifleman, s')
console_print('Quote/Curly: quote, curly, qc, q/c')
")

//Just a copy of the above command, but backwards
console_addCommand("unlock", "
if not global.isHost{
    console_print('Only the host can use this command.')
    exit
}

if input[1]=='red'{
    global.locked_red=0
    console_print('Unlocked red team.')
}else if input[1]=='blue'{
    global.locked_blue=0
    console_print('Unlocked blue team.')
}else if input[1]=='scout' or input[1]=='runner' or input[1]=='r'{
    global.locked_scout=0
    console_print('Unlocked Scout.')
}else if input[1]=='pyro' or input[1]=='firebug' or input[1]=='p'{
    global.locked_pyro=0
    console_print('Unlocked Pyro.')
}else if input[1]=='soldier' or input[1]=='rocketman' or input[1]=='so'{
    global.locked_soldier=0
    console_print('Unlocked Soldier.')
}else if input[1]=='heavy' or input[1]=='overweight' or input[1]=='h'{
    global.locked_heavy=0
    console_print('Unlocked Heavy.')
}else if input[1]=='demoman' or input[1]=='detonator' or input[1]=='demo' or input[1]=='deto' or input[1]=='d'{
    global.locked_demoman=0
    console_print('Unlocked Demoman.')
}else if input[1]=='medic' or input[1]=='healer' or input[1]=='med' or input[1]=='m'{
    global.locked_medic=0
    console_print('Unlocked Medic.')
}else if input[1]=='engineer' or input[1]=='constructor' or input[1]=='engie' or input[1]=='e'{
    global.locked_engie=0
    console_print('Unlocked Engineer.')
}else if input[1]=='spy' or input[1]=='infiltrator' or input[1]=='i'{
    global.locked_spy=0
    console_print('Unlocked Spy.')
}else if input[1]=='sniper' or input[1]=='rifleman' or input[1]=='s'{
    global.locked_sniper=0
    console_print('Unlocked Sniper.')
}else if input[1]=='quote' or input[1]=='curly' or input[1]=='qc' or input[1]=='q/c'{
    global.locked_quote=0
    console_print('Unlocked Quote/Curly.')
}else{
    console_print('This is not a valid team or class.')
}
", "
console_print('Syntax: unlock <team/class>')
console_print('Use: Re-allows any new players from joining that team or using that class.')
console_print('These are accepted inputs for teams: red, blue')
console_print('These are accepted inputs for classes:')
console_print('Scout/Runner: scout, runner, r')
console_print('Pyro/Firebug: pyro, firebug, p')
console_print('Soldier/Rocketman: soldier, rocketman, so')
console_print('Heavy/Overweight: heavy, overweight, h')
console_print('Demoman/Detonator: demoman, detonator, demo, deto, d')
console_print('Medic/Healer: medic, healer, med, m')
console_print('Engineer/Constructor: engineer, constructor, engie, e')
console_print('Spy/Infiltrator: spy, infiltrator, i')
console_print('Sniper/Rifleman: sniper, rifleman, s')
console_print('Quote/Curly: quote, curly, qc, q/c')
")

console_addCommand("bind", "
var bind, command;
bind=string_upper(input[1])
command=string(input[2])

if (ds_list_find_index(global.dsmBinds,ord(bind))==-1){
    ds_list_add(global.dsmBinds,ord(bind))
    ds_list_add(global.dsmBindCommands,command)
    write_binds_to_file()
    console_print('Binded '+string(ord(bind))+' to '+command)
    exit;
}else{
    ds_list_replace(global.dsmBindCommands,ds_list_find_index(global.dsmBinds,ord(bind)),command)
    write_binds_to_file()
    console_print('Overwrote '+string(ord(bind))+' to '+command)
    exit;
}
//Somehow we failed...
console_print('Binding failed. Make sure the command is encased in quotes.')
", "
console_print('Syntax: bind <key> <command>')
console_print('Use: Binds a console command to a key.')
console_print('Warning: May cause problems with the chat plugin, use carefully.')
")

console_addCommand("unbind","
var bind;
bind=string_upper(input[1])

for (i = 0; i < ds_list_size(global.dsmBinds); i+=1){
    if real(ds_list_find_value(global.dsmBinds,i))==real(ord(bind)){
        ds_list_delete(global.dsmBinds,i)
        ds_list_delete(global.dsmBindCommands,i)
        write_binds_to_file()
        console_print('Removed bind: '+string(ord(bind)))
        exit;
    }
}
//User tried to remove a bind that does not exist, or just failed the command.
console_print('Bind: '+string(bind)+' does not exist. Type listBinds for a list of all current binds.')
", "
console_print('Syntax: unbind <key>')
console_print('Use: Removes a specified bind.')
")



console_addCommand("listBinds","
var bindListSize,index;
bindListSize=ds_list_size(global.dsmBinds)
index=0
while(index<bindListSize){
    console_print(string(chr(real(ds_list_find_value(global.dsmBinds,index))))+string(' ')+string(ds_list_find_value(global.dsmBindCommands,index)))
    index+=1
}
", "
console_print('Syntax: listBinds')
console_print('Use: Lists all binds assigned by the user.')
")
