with(Player) {
    if(object != -1) {
        with(object) {
            instance_destroy();
        }
        object = -1;
    }
    
    //stat tracking array
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
    
    //statistic array for single life/arena
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
    
    timesChangedCapLimit = 0;
    
    lastKnownx=0;
    lastKnowny=0;
    
    humiliated=0;
    
    //Arena mode - used by server to check if the player can spawn
    canSpawn = 1;
    if instance_exists(ArenaHUD) {
        if ArenaHUD.roundStart == 0 canSpawn = 0;
    }
    
    //Sentries for Engies
    if(sentry != noone) {
        with(sentry) {
            instance_destroy();
        }
        sentry = noone;
    }
}

room_goto_fix(TrainingSetupRoom);
