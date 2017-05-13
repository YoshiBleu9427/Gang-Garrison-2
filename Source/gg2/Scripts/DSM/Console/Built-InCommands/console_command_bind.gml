console_addCommand("bind", "
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

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

