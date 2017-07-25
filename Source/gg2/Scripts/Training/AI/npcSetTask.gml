/**
 *  Sets the actions a NPC will do.
 *
 *  argument0: a NPC task
 *  argument1: the object related to the task (of noone if no argument needed)
 *
 *  NPC_TASK_IDLE           Stay here, don't do anything
 *  NPC_TASK_SPYCHECK       Stay around, fire random bullets
 *  NPC_TASK_CHASE          Seek and destroy (if argument1 != noone, will only chase player argument1)
 *  NPC_TASK_CAMP           Stay on the nearest sniper spot, shoot everything you see
 *  NPC_TASK_PET            Follow the player argument1
 *  NPC_TASK_STAY           Stay here, shoot everything you see
 */
 
var arg;
task = argument0;
arg = argument1;

if(arg == 0) arg = noone;
forcePath = false;
forceAim  = false;

var argIsntNoone;
argIsntNoone = (arg != noone);

switch(task) {
    case NPC_TASK_IDLE:
        pathPoint = noone;
        aimObject = noone;
        forcePath = true;
        forceAim  = true;
        break;
    case NPC_TASK_SPYCHECK:
        pathPoint = noone;
        aimObject = noone;
        break;
    case NPC_TASK_CHASE:
        pathPoint = arg;
        aimObject = arg;
        forcePath = argIsntNoone;
        forceAim  = argIsntNoone;
        break;
    case NPC_TASK_CAMP:
        pathPoint = instance_nearest(x,y,NPCSniperSpot);
        aimObject = arg;
        forceAim  = argIsntNoone;
        break;
    case NPC_TASK_PET:
        pathPoint = arg;
        aimObject = noone;
        forcePath = argIsntNoone;
        break;
    case NPC_TASK_SENTRY:
        pathPoint = instance_nearest(x,y,NPCSentrySpot);
        aimObject = noone;
        break;
    case NPC_TASK_STAY:
        pathPoint = noone;
        aimObject = noone;
        break;
}
