console_addCommand("listBinds","
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

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
