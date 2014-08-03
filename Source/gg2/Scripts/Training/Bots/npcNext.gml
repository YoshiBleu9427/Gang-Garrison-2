/*
 *  Creates the next NPC instance at specified position.
 *  This function enables dynamic use of NPC objects. Use this
 * instead of NPC01, NPC02... to generate NPCs.
 *
 *  Example:
 *      with(nextNpc(x,y)) {
 *          name = "Bot";
 *          object_event_add(object_index, ev_other, NPC_EVENT_MEET, '
 *              addDialog("Hello");
 *          ');
 *      }
 */

var xPos, yPos;
xPos = argument0;
yPos = argument1;

var nextNPC;

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

return instance_create(xPos, yPos, nextNPC);
