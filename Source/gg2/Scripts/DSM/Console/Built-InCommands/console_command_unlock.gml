console_addCommand("unlock", "
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
