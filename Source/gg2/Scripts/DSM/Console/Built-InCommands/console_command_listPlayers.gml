console_addCommand("listplayers", "
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

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
    RCONPlayer=ds_list_find_value(global.RCONList,i)
    if player==RCONPlayer{
        console_print('/:/'+COLOR_RED+string_replace_all(player.name, '/:/', '/;/')+':    ID='+string(ds_list_find_index(global.players, player.id))+' | RCON');
    }else{
        console_print('/:/'+COLOR_RED+string_replace_all(player.name, '/:/', '/;/')+':    ID='+string(ds_list_find_index(global.players, player.id)));
    }
}
for (i=0; i<ds_list_size(blueteam); i+=1){
    player = ds_list_find_value(blueteam, i);
    RCONPlayer=ds_list_find_value(global.RCONList,i)
    if player==RCONPlayer{
        console_print('/:/'+COLOR_BLUE+string_replace_all(player.name, '/:/', '/;/')+':    ID='+string(ds_list_find_index(global.players, player.id))+' | RCON');
    }else{
        console_print('/:/'+COLOR_BLUE+string_replace_all(player.name, '/:/', '/;/')+':    ID='+string(ds_list_find_index(global.players, player.id)));
    }
}
for (i=0; i<ds_list_size(specteam); i+=1){
    player = ds_list_find_value(specteam, i);
    RCONPlayer=ds_list_find_value(global.RCONList,i)
    if player==RCONPlayer{
        console_print('/:/'+COLOR_GREEN+string_replace_all(player.name, '/:/', '/;/')+':    ID='+string(ds_list_find_index(global.players, player.id))+' | RCON');
    }else{
        console_print('/:/'+COLOR_GREEN+string_replace_all(player.name, '/:/', '/;/')+':    ID='+string(ds_list_find_index(global.players, player.id)));
    }
}
", "
console_print('Syntax: listPlayers')
console_print('Use: Prints a color-coded list of the IDs of all the players in the game.')
console_print('These IDs are necessary for anything requiring a specific player, like kicking.')");
