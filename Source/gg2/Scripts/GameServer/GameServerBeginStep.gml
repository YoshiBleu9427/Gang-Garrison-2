move_all_bullets();
move_all_gore();

if(serverbalance != 0)
    balancecounter += 1;

// Register with Lobby Server every 30 seconds
if((frame mod 900) == 0 and global.run_virtual_ticks)
    sendLobbyRegistration();
    
if(global.run_virtual_ticks)
    frame += 1;

// TrainingMod - input
runDialogs();

// Service all players
var i;
for(i=0; i < ds_list_size(global.players); i+=1)
{
    var player;
    player = ds_list_find_value(global.players, i);
    
    if(player.object_index != Player) { // TODO: fix is_ancestor
        // process NPCs keybyte input
        with(player.object)
        {
            event_user(1);
        }
    } else {
        if(socket_has_error(player.socket) or player.kicked)
        {
            removePlayer(player);
            ServerPlayerLeave(i, global.sendBuffer);
            ServerBalanceTeams();
            i -= 1;
        }
        else
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
        global.nextMap = nextMapInRotation();
    }
    
    global.mapchanging = true;
    impendingMapChange = 300; // in 300 ticks (ten seconds), we'll do a map change
    
    write_ubyte(global.sendBuffer, MAP_END);
    // IMPORTANT NETWORKING CHANGE: REMOVED A STRING (global.nextMap being sent)
    write_ubyte(global.sendBuffer, global.winners);
    write_ubyte(global.sendBuffer, global.currentMapArea);
    
    if(!instance_exists(ScoreTableController))
        instance_create(0,0,ScoreTableController);
    instance_create(0,0,WinBanner);
}
// if map change timer hits 0, do a map change
if(impendingMapChange == 0)
{
    if(global.restart) {
        ServerChangeMap(global.currentMap, global.currentMapMD5, global.sendBuffer);
        serverGotoMap(global.currentMap);
    } else {
        sendSetupRoom();
        doSetupRoom();
    }
    
    global.mapchanging = false;
    impendingMapChange = -1;
    
    with(Player)
    {
        if(global.currentMapArea == 1)
        {
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
