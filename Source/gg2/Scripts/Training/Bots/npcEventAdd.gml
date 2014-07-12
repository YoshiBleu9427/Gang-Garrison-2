/*
 *  Adds a script to be executed when a custom event is performed.
 *  Shortcut for object_event_add.
 *  TO BE CALLED FROM A NPC OR EventManager
 *  Untested from object
 *
 *  Example:
 *      with(npcNext(x,y)) {
 *          npcEventAdd(NPC_EVENT_MEET, '
 *              addDialog("Hello");
 *          ');
 *      }
 */
 
object_event_add(object_index, ev_other, argument0, argument1);
