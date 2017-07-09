// Executes EVENT_CUSTOM_1, EVENT_CUSTOM_2 or EVENT_CUSTOM_3 according to argument0 (1, 2 or 3)

var eventNo;
eventNo = argument0;

with(EventManager) {
    switch(eventNo) {
        case 1:
            event_user(15);
            break;
        case 2:
            event_user(14);
            break;
        case 3:
            event_user(13);   
            break; 
    }
}
