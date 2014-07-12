
    global.playerDeathSound=sound_add("Music/playerDeathSound.wav", 1, true);
    global.gameOverSound=sound_add("Music/gameOverSound.wav", 1, true);
    global.actionMusic=sound_add("Music/actionmusic.wav", 1, true);
    if(global.actionMusic != -1)
        sound_volume(global.actionMusic, 0.8);
        
        
    // Training data
    global.class = CLASS_SCOUT;     // TODO: I want to redo that. Bad.
    global.team = TEAM_RED;
    global.dialogList = noone; // defined in GameServer creation
    global.respawntime = 15 * 30;
    global.restart = false; // restart the map, ingamemenucontroller
    
    instance_create(0,0, NPCManager);
