if global.dsmUseDSMChat==0 exit;

global.chatSendBuffer = buffer_create();
global.chatPacketID = global.dsmChatID
global.chatLog = ds_list_create();
ds_list_add(global.chatLog,"OWelcome to the DSM "+string(DSM_VERSION_STRING)+" Chat!");
ds_list_add(global.chatLog,"OPress T to show/hide,");
ds_list_add(global.chatLog,"OPress Y for global chat, and U for team chat.");
global.chatBanlist = ds_list_create();
global.consoleFont = font_add("Lucida Console",8,0,0,32,127);

//create chatbox object
object_event_add(PlayerControl,ev_step,ev_step_begin,'
if !instance_exists(DSM_Chatbox){
    instance_create(0,0,DSM_Chatbox)
}
');

object_event_add(PlayerControl,ev_create,0,'
    //send a message to the server to tell that we have chat
    if !global.isHost {
        write_ubyte(global.chatSendBuffer,0); //hello
        PluginPacketSend(global.chatPacketID,global.chatSendBuffer);
        buffer_clear(global.chatSendBuffer);
    }
');

//create a cheaty cheat object to prevent you from moving and opening chat menus while typing :p
global.cheatycheat = object_add();
object_set_parent(global.cheatycheat,InGameMenuController);
object_event_add(global.cheatycheat,ev_step,ev_step_normal,'//no');
object_event_add(global.cheatycheat,ev_draw,0,'//no');
object_event_add(global.cheatycheat,ev_keypress,vk_enter,'//no');
object_event_add(global.cheatycheat,ev_keypress,vk_escape,'
    with(global.chatWindow) open = false;
    instance_create(0,0,InGameMenuController);
    instance_destroy();
');
