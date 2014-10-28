console_addCommand("showRotation", "
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

if !global.isHost{
    console_print('Only the host can use this command.')
    exit;
}

for (i=0; i<ds_list_size(global.map_rotation); i+=1){
    if i == GameServer.currentMapIndex{
        console_print(ds_list_find_value(global.map_rotation,i)+'<');
    }else{
        console_print(ds_list_find_value(global.map_rotation,i));
    }
}

", "
console_print('Syntax: showMapRotation');
console_print('Use: Shows a list of the maps in rotation. < denotes the current map.');
");
