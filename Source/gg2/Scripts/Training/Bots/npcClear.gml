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
    object_event_clear(object_index, ev_step, ev_step_begin);
    object_event_clear(object_index, ev_step, ev_step_end);
    object_event_clear(object_index, ev_draw, 0);
    object_event_clear(object_index, ev_alarm, 2);
    object_event_clear(object_index, ev_alarm, 3);
    object_event_clear(object_index, ev_alarm, 4);
    object_event_clear(object_index, ev_alarm, 6);
    object_event_clear(object_index, ev_alarm, 7);
    object_event_clear(object_index, ev_alarm, 8);
    object_event_clear(object_index, ev_alarm, 9);
    object_event_clear(object_index, ev_alarm, 10);
    object_event_clear(object_index, ev_alarm, 11);
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
    object_event_clear(object_index, ev_step, ev_step_begin);
    object_event_clear(object_index, ev_step, ev_step_normal);
    object_event_clear(object_index, ev_step, ev_step_end);
    object_event_clear(object_index, ev_draw, 0);
    object_event_clear(object_index, ev_alarm, 0);
    object_event_clear(object_index, ev_alarm, 1);
    object_event_clear(object_index, ev_alarm, 2);
    object_event_clear(object_index, ev_alarm, 3);
    object_event_clear(object_index, ev_alarm, 4);
    object_event_clear(object_index, ev_alarm, 5);
    object_event_clear(object_index, ev_alarm, 6);
    object_event_clear(object_index, ev_alarm, 7);
    object_event_clear(object_index, ev_alarm, 8);
    object_event_clear(object_index, ev_alarm, 9);
    object_event_clear(object_index, ev_alarm, 10);
    object_event_clear(object_index, ev_alarm, 11);
}

with(NPCManager) {
    currentIndex = 0;
}
