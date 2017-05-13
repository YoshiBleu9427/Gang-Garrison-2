console_addCommand("classlimits", "
var command;
command=input[0]+' '+input[1]+' '+input[2]
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
