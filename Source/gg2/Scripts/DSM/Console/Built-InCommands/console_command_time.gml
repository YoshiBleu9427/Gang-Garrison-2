console_addCommand("time", "
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
