console_addCommand("unban", "
if global.RCONSentCommand=1{
    console_print('/:/'+COLOR_LIGHTBLUE+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print('/:/'+COLOR_ORANGE+global.RCONCommand_out)
    exit
}

if !global.isHost{
    console_print('Only the host can use this command.')
    exit;
}

var playerIP,check;
playerIP=input[1]
check=ds_list_find_index(global.banned_ips,playerIP)

if check!=-1{
    ds_list_delete(global.banned_ips,check)
    
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
    
    console_print('IP: '+string(playerIP)+', successfully unbanned.')
}else{
    console_print('IP could not be found.')
}
exit
", "
console_print('Syntax: unban <IP>')
console_print('Use: Unbans players.)
");
