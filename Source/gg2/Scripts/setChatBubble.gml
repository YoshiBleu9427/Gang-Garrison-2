if(instance_exists(argument0)) {
    if(argument0.object != -1) {
        argument0.object.bubble.image_index = argument1;
        argument0.object.bubble.alarm[0] = 60 / global.delta_factor;
        argument0.object.bubble.visible = true;
        argument0.object.bubble.bubbleAlpha = 1;
        argument0.object.bubble.fadeout = false;
        
        if (argument0 == global.myself) {
            with(EventManager) {
                event_user(5); // PLAYER_EVENT_BUBBLE
            }
        }
    }
}
