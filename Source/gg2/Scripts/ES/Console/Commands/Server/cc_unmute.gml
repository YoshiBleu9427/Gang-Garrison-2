console_addCommand("unmute", "
/*
//HOST ONLY
*/
if global.RCONSentCommand=1{
    console_print(C_PINK+'RCON: '+global.RCONSentCommand_PlayerName+' sent this command:')
    console_print(C_ORNGE+global.RCONCommand_out)
    exit
}

if !global.isHost{
    console_print('Only the host can use this command.')
    exit;
}

trueID=floor(real(string_digits(input[1])))

//Check ID
var player;
if string_letters(input[1])==''{
    if (trueID<ds_list_size(global.players)){
        player=ds_list_find_value(global.players,trueID)
        
        if player==-1{
            console_print('Could not find a player with that ID or name.')
            exit;
        }
        ds_list_delete(global.chatBanList,ds_list_find_index(global.chatBanList,player))
        
        console_print(c_filter(player.name)+' has been unmuted.')
        var color;
        color=getPlayerColor(player, true);
        global.srvMsgChatPrint=global.chatPrintPrefix+color+c_filter(player.name)+C_WHITE+' has been unmuted.'
        console_sendmsg()
        exit;
    }
}

//ID failed, check names
with Player{
    if name == other.input[1]{
        ds_list_delete(global.chatBanList,ds_list_find_index(global.chatBanList,id))
        
        console_print(c_filter(name)+' has been unmuted.')
        var color;
        color=getPlayerColor(Player, true)
        global.srvMsgChatPrint=global.chatPrintPrefix+color+c_filter(name)+C_WHITE+' has been unmuted.'
        console_sendmsg()
        exit;
    }
}

//Could not find a player from info given
console_print('Could not find a player with that ID or name.')
", "
console_print('Syntax: unmute <Player ID/Player Name>')
console_print('Allows the selected player to talk again. IDs are considered before names.')
");
