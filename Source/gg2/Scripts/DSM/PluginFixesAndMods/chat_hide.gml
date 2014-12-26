object_event_add(global.chatWindow,ev_draw,0,'
if global.chatHide==1{ //and global.chatHideJustChanged==1{
    idle=true
    global.chatHideJustChanged=0
}
if global.chatHide==0 and global.chatHideJustChanged==1{
    idle=false
    global.chatHideJustChanged=0
}
//if keyboard_check_pressed(global.dsmChatHideButton){
//    alarm[0]=120
//}
')
