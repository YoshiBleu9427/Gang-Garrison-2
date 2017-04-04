move_all_bullets();
move_all_gore();

if(serverbalance != 0)
    balancecounter += 1;

// Register with Lobby Server every 30 seconds
if((frame mod 900) == 0 and global.run_virtual_ticks)
    sendLobbyRegistration();
    
if(global.run_virtual_ticks)
    frame += 1;

// Service all players
var i;
for(i=0; i < ds_list_size(global.players); i+=1)
{
    var player;
    player = ds_list_find_value(global.players, i);
    if(socket_has_error(player.socket) or player.kicked or player.banned){
        with(ModController){
            event_user(0)
        }
        if global.chatPBF_2==1 and global.srvMsgChatPrint==""{
            //Get disconnect reason
            var dcMessage, dcColour;
            dcColour=C_ORNGE
            
            if player.dcReason==DC_REASON_USER{
                dcMessage="Disconnect by user"
            }else if player.dcReason==KICK_ADMIN_KICK{
                dcMessage="Kicked by admin"
            }else if player.dcReason==KICK_BANNED{
                dcMessage="Banned by admin"
                dcColour=P_RED
            }else if player.dcReason==KICK_TEMP_BANNED{
                dcMessage="Temporarily banned by admin"
                dcColour=P_RED
            }else{ //Assume player crashed/timed out, should be the only other way for them to leave that isn't checked
                dcMessage="User timed out"
            }
            
            var message, color;
            color = getPlayerColor(player, true);
            message = global.chatPrintPrefix+color+c_filter(player.name)+C_WHITE+" has left - "+dcColour+dcMessage+"."
            write_ubyte(global.publicChatBuffer, CHAT_PUBLIC_MESSAGE);
            write_ushort(global.publicChatBuffer, string_length(message));
            write_string(global.publicChatBuffer, message);
            write_byte(global.publicChatBuffer,-1);
            print_to_chat(message);// For the host
        }
        
        ds_list_delete(global.chatBanList,player)
        
        removePlayer(player);
        ServerPlayerLeave(i, global.sendBuffer);
        ServerBalanceTeams();
        i -= 1;
    }else{
        processClientCommands(player, i);
    }
}

if(syncTimer == 1 || ((frame mod 3600)==0) || global.setupTimer == 180 and global.run_virtual_ticks)
{
    serializeState(CAPS_UPDATE, global.sendBuffer);
    syncTimer = 0;
}

if(global.run_virtual_ticks)
{
    if((frame mod 7) == 0)
        serializeState(QUICK_UPDATE, global.sendBuffer);
    else
        serializeState(INPUTSTATE, global.sendBuffer);
}

if(impendingMapChange > 0 and global.run_virtual_ticks)
    impendingMapChange -= 1; // countdown until a map change

if(global.winners != -1 and !global.mapchanging)
{
    if(global.winners == TEAM_RED and global.currentMapArea < global.totalMapAreas)
    {
        global.currentMapArea += 1;
        global.nextMap = global.currentMap;
    }
    else
    {
        global.currentMapArea = 1;
        if global.consoleMapChange==0{
            global.nextMap = nextMapInRotation();
        }
    }
    
    global.mapchanging = true;
    impendingMapChange = 300; // in 300 ticks (ten seconds), we'll do a map change
    
    with(ModController){
        event_user(0)
    }
    if global.chatPBF_32==1{
        var message, color;
        message = global.chatPrintPrefix+C_WHITE+"Next map: "+C_GREEN+global.nextMap+C_WHITE+"."
        write_ubyte(global.publicChatBuffer, CHAT_PUBLIC_MESSAGE);
        write_ushort(global.publicChatBuffer, string_length(message));
        write_string(global.publicChatBuffer, message);
        write_byte(global.publicChatBuffer,-1)
        print_to_chat(message);// For the host
    }
    
    write_ubyte(global.sendBuffer, MAP_END);
    write_ubyte(global.sendBuffer, string_length(global.nextMap));
    write_string(global.sendBuffer, global.nextMap);
    write_ubyte(global.sendBuffer, global.winners);
    write_ubyte(global.sendBuffer, global.currentMapArea);
    
    if(!instance_exists(ScoreTableController))
        instance_create(0,0,ScoreTableController);
    instance_create(0,0,WinBanner);
}

// if map change timer hits 0, do a map change
if(impendingMapChange == 0){
    global.mapchanging = false;
    serverGotoMap(global.nextMap);
    ServerChangeMap(global.currentMap, global.currentMapMD5, global.sendBuffer);
    impendingMapChange = -1;
    global.consoleMapChange=0
    
    global.jumpMode=0
    if global.jumpMapMode==1{
        global.jumpMode=1
    }else if global.jumpMapMode==2{
        prefixIndex[0]="rj"
        prefixIndex[1]="dj"
        prefixIndex[2]="rr"
        prefixIndex[3]="sj"
        prefixIndex[4]="ej"
        prefixIndex[5]="qr"
        prefixIndex[6]="pj"
        prefixIndex[7]="jt"
        prefixIndex[8]="surf"
        prefixIndex[9]="jump"
        for (i=0; i<10; i+=1){
            if string_pos(prefixIndex[i],string_lower(global.nextMap))==1{
                global.jumpMode=1
            }
        }
    }
    
    with(ReadyUpController){
        event_user(1)
    }
    
    with(Player){
        if(global.currentMapArea == 1){
            stats[KILLS] = 0;
            stats[DEATHS] = 0;
            stats[CAPS] = 0;
            stats[ASSISTS] = 0;
            stats[DESTRUCTION] = 0;
            stats[STABS] = 0;
            stats[HEALING] = 0;
            stats[DEFENSES] = 0;
            stats[INVULNS] = 0;
            stats[BONUS] = 0;
            stats[DOMINATIONS] = 0;
            stats[REVENGE] = 0;
            stats[POINTS] = 0;
            roundStats[KILLS] = 0;
            roundStats[DEATHS] = 0;
            roundStats[CAPS] = 0;
            roundStats[ASSISTS] = 0;
            roundStats[DESTRUCTION] = 0;
            roundStats[STABS] = 0;
            roundStats[HEALING] = 0;
            roundStats[DEFENSES] = 0;
            roundStats[INVULNS] = 0;
            roundStats[BONUS] = 0;
            roundStats[DOMINATIONS] = 0;
            roundStats[REVENGE] = 0;
            roundStats[POINTS] = 0;
            team = TEAM_SPECTATOR;
        }
        timesChangedCapLimit = 0;
        alarm[5] = 1;
    }
    // message lobby to update map name
    sendLobbyRegistration();
}

var i;
for(i=1; i<ds_list_size(global.players); i+=1){
    var player;
    player = ds_list_find_value(global.players, i);
    write_buffer(player.socket, global.sendBuffer);
    write_buffer(player.socket, global.publicChatBuffer);
    
    if player.team == TEAM_RED{
        write_buffer(player.socket, global.privChatRedBuffer);
    }else if player.team == TEAM_BLUE{
        write_buffer(player.socket, global.privChatBlueBuffer);
    }else if player.team == TEAM_SPECTATOR and global.specReadChat==1{
        write_buffer(player.socket, global.privChatRedBuffer);
        write_buffer(player.socket, global.privChatBlueBuffer);
        write_buffer(player.socket, global.privChatSpecBuffer);
    }else{
        write_buffer(player.socket, global.privChatSpecBuffer);
    }
}
buffer_clear(global.sendBuffer);
buffer_clear(global.privChatRedBuffer);
buffer_clear(global.privChatBlueBuffer);
buffer_clear(global.privChatSpecBuffer);
buffer_clear(global.publicChatBuffer);
