
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
    
    global.npcNames[CLASS_SCOUT]    = "Pal";
    global.npcNames[CLASS_PYRO]     = "Mmph";
    global.npcNames[CLASS_SOLDIER]  = "Sergeant";
    global.npcNames[CLASS_HEAVY]    = "Friend";
    global.npcNames[CLASS_DEMOMAN]  = "Lad";
    global.npcNames[CLASS_MEDIC]    = "Dummkopf";
    global.npcNames[CLASS_ENGINEER] = "Partner";
    global.npcNames[CLASS_SPY]      = "Ami";
    global.npcNames[CLASS_SNIPER]   = "Mate";
    
    global.npcPortraitOffsets[CLASS_SCOUT]    = 0;
    global.npcPortraitOffsets[CLASS_PYRO]     = 1;
    global.npcPortraitOffsets[CLASS_SOLDIER]  = 2;
    global.npcPortraitOffsets[CLASS_HEAVY]    = 3;
    global.npcPortraitOffsets[CLASS_DEMOMAN]  = 4;
    global.npcPortraitOffsets[CLASS_MEDIC]    = 5;
    global.npcPortraitOffsets[CLASS_ENGINEER] = 6;
    global.npcPortraitOffsets[CLASS_SPY]      = 7;
    global.npcPortraitOffsets[CLASS_SNIPER]   = 8;
    
    instance_create(0,0, NPCManager);
