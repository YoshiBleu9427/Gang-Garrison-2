/*
 *  Creates the next NPC instance at specified position.
 *  This function enables dynamic use of NPC objects. Use this
 * instead of NPC01, NPC02... to generate NPCs.
 *
 *  Note that this will NOT spawn the object. Call npcCreateObject
 * in a with() block to define the class and team of the NPC, and
 * spawn its object.
 *  
 *
 *  Example:
 *      with(nextNpc(x,y)) {
 *          name = "Bot";
 *          object_event_add(object_index, ev_other, NPC_EVENT_MEET, '
 *              addDialog("Hello");
 *          ');
 *          npcCreateObject(team, class);
 *      }
 */

var xPos, yPos, team, class;
xPos = argument0;
yPos = argument1;
team = argument2;
class = argument3;

var nextNPC, instance, teamOffset;


// Retrieve the next NPC object (or allocate if needed)
with(NPCManager) {
    if(currentCount >= nbAllocated) {
        npcArray[currentCount] = object_add();
        object_set_parent(npcArray[currentCount], NPC);
        object_set_persistent(npcArray[currentCount], true);
        nbAllocated += 1;
    }
    nextNPC = npcArray[currentCount];
    currentCount += 1;
}

instance = instance_create(xPos, yPos, nextNPC);

return instance;
