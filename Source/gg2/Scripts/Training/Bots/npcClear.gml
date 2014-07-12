/*
 *  Destroys all NPCs and clears custom events.
 *  Also resets the npc count in NPCManager.
 *  Called on round end.
 */

with(NPC) {
    object_event_clear(object_index, ev_other, ev_user0);
    object_event_clear(object_index, ev_other, ev_user1);
    object_event_clear(object_index, ev_other, ev_user2);
    object_event_clear(object_index, ev_other, ev_user3);
    object_event_clear(object_index, ev_other, ev_user4);
    object_event_clear(object_index, ev_other, ev_user5);
    object_event_clear(object_index, ev_other, ev_user6);
    object_event_clear(object_index, ev_other, ev_user7);
    object_event_clear(object_index, ev_other, ev_user8);
    object_event_clear(object_index, ev_other, ev_user9);
    object_event_clear(object_index, ev_other, ev_user10);
    object_event_clear(object_index, ev_other, ev_user11);
    object_event_clear(object_index, ev_other, ev_user12);
    object_event_clear(object_index, ev_other, ev_user13);
    object_event_clear(object_index, ev_other, ev_user14);
    object_event_clear(object_index, ev_other, ev_user15);
    instance_destroy();
}
with(EventManager) {
    object_event_clear(object_index, ev_other, ev_user0);
    object_event_clear(object_index, ev_other, ev_user1);
    object_event_clear(object_index, ev_other, ev_user2);
    object_event_clear(object_index, ev_other, ev_user3);
    object_event_clear(object_index, ev_other, ev_user4);
    object_event_clear(object_index, ev_other, ev_user5);
    object_event_clear(object_index, ev_other, ev_user6);
    object_event_clear(object_index, ev_other, ev_user7);
    object_event_clear(object_index, ev_other, ev_user8);
    object_event_clear(object_index, ev_other, ev_user9);
    object_event_clear(object_index, ev_other, ev_user10);
    object_event_clear(object_index, ev_other, ev_user11);
    object_event_clear(object_index, ev_other, ev_user12);
    object_event_clear(object_index, ev_other, ev_user13);
    object_event_clear(object_index, ev_other, ev_user14);
    object_event_clear(object_index, ev_other, ev_user15);
}

with(NPCManager) {
    currentIndex = 0;
}
