instance = argument0;
team = argument1;
class = argument2;

// prepare instance, and spawn object
instance.team = team;
instance.class = class;

with (instance) {
    subFace = 0;
    task = NPC_TASK_IDLE;
    if (class == CLASS_QUOTE) {
        if(team == TEAM_RED) {
            name = "Quote";
            face = QuerlyRedS;
        } else {
            name = "Curly";
            face = QuerlyBlueS;
        }
    } else {
        face = ClassSelectPortraitS;
        if (team == global.myself.team) {
            name = global.npcNames[class];
        } else {
            name = "Enemy " + classname(class);
        }
        var teamOffset;
        if(team == TEAM_BLUE) teamOffset = 10
        else teamOffset = 0;
        subFace = global.npcPortraitOffsets[class] + teamOffset;
    }
    ds_list_add(global.players, id);
    doEventSpawnPos(id,x,y);
    
    // class specific attributes
    switch(class) {
        case CLASS_SCOUT:
            maxModifier = 15;
            break;
        case CLASS_PYRO:
            maxModifier = 2;
            spyReactTime = 25;
            break;
        case CLASS_SOLDIER:
            maxModifier = 5;
            break;
        case CLASS_HEAVY:
            spyReactTime = 50;
            break;
        case CLASS_DEMOMAN:
            maxModifier = 1;
            break;
        case CLASS_MEDIC:
            maxModifier = 1;
            break;
        case CLASS_ENGINEER:
            pathPoint = instance_nearest(x,y,NPCSentrySpot);
            task = NPC_TASK_SENTRY; // default taskuncloakTimeOnRecloak
            break;
        case CLASS_SPY:
            maxModifier = 20;
            break;
        case CLASS_SNIPER:
            pathPoint = instance_nearest(x,y,NPCSniperSpot);
            task = NPC_TASK_CAMP; // default task
            maxModifier = 10;
            spyReactTime = 60;
            seeRange = 500;
            break;
    }
}
