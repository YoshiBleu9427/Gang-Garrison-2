console_addCommand("unbind","
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

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
