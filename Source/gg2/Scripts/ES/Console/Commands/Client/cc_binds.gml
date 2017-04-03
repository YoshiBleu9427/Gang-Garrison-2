console_addCommand("binds","
/*
//CLIENT
*/
if global.RCONSentCommand=1{
    console_print(C_PINK+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print(C_ORNGE+global.RCONCommand_out)
    exit
}

var bindListSize,index;
bindListSize=ds_list_size(global.binds)
index=0
while(index<bindListSize){
    console_print(string(chr(34))+string(chr(real(ds_list_find_value(global.binds,index))))+string(chr(34))+string(' ')+string(ds_list_find_value(global.bindCommands,index)))
    index+=1
}
", "
console_print('Syntax: binds')
console_print('Lists all binds assigned by the user.')
")
