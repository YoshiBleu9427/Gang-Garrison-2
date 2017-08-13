if global.dsmUseDSMChat==0 exit;
if global.dsmChatLoaded==1 exit;

ds_list_delete(global.chatLog,1)
ds_list_delete(global.chatLog,0)
ds_list_add(global.chatLog,"OWelcome to the DSM "+string(DSM_VERSION_STRING)+" Chat!")
ds_list_add(global.chatLog,"OPress Y for global chat, and U for team chat.")
ds_list_add(global.chatLog,"OPress T to show/hide.")
object_set_depth(global.chatWindow, -120001)

object_event_clear(global.chatWindow,ev_create,0)
object_event_add(global.chatWindow,ev_create,0,'
    sprite_index = Chat2S
    
    open = false;
    hidden = true;
    team = false;
    offset = 0;
    idle = false;
    idleTime=4*30/global.delta_factor

    slider_offset = 160;
    slide = false;
    mPos_x = -1;
    mPos_y = -1;
    alpha = 1;

    //placeholderMsg="Type your chat message..."
    placeholderMsg="Type your chat message..."
    placeholderMsgGlobal="(global)"
    placeholderMsgTeam="(team)"

    alarm[0]=idleTime;
');

object_event_clear(global.chatWindow,ev_step,ev_step_end)
object_event_add(global.chatWindow,ev_step,ev_step_end,'
if (!instance_exists(InGameMenuController) && !instance_exists(OptionsController) && !instance_exists(ControlsController) && !instance_exists(HUDOptionsController)) and !instance_exists(Console) || instance_exists(global.cheatycheat) {

if keyboard_check_pressed(global.dsmChatHideButton) and open==0{
    if visible==1{
        visible=0
    }else if visible==0{
        visible=1
    }
}

if keyboard_check_pressed(global.dsmChatToggle) and !open and visible==1{
    if !open hidden = !hidden;
    idle = false;
    alarm[0]=idleTime;
}else if keyboard_check_pressed(global.dsmChatGlobal) and !open and visible==1{
    open = true;
    hidden = false;
    keyboard_string="";
    team = false;
    instance_create(0,0,global.cheatycheat);
}else if keyboard_check_pressed(global.dsmChatTeam) and /*global.myself.team != TEAM_SPECTATOR and*/ !open and visible==1 and !instance_exists(Console){
    open = true;
    hidden = false;
    keyboard_string="";
    team = true;
    instance_create(0,0,global.cheatycheat);
}else if open and keyboard_check_pressed(vk_enter) and visible==1 and !instance_exists(Console){
    with(global.cheatycheat) instance_destroy();
    if keyboard_string != ""{
        _message = keyboard_string;
        if global.isHost{
            _player = global.myself;
            if team == true _team = global.myself.team+1;
            else _team = 0
            event_user(1); //process our own message
            event_user(2); //send our own message to the clients
            event_user(4); //add our own message to the chatbox
        }else{
            _team = team;
            event_user(3); //send a message as a client
        }
        keyboard_string="";
    }
    open = false;
    team = false;
    idle = false;
    if global.dsmAutocloseChat==1{
        hidden=true
    }else{
        hidden=false
    }
    alarm[0]=idleTime;
}
}
    
if open{        
    image_index = 1;
    global.dsmTyping=1
    if (keyboard_check_pressed(vk_up) or mouse_wheel_up()) and ds_list_size(global.chatLog) > 9 offset = min(ds_list_size(global.chatLog)-10,offset+1);
    else if keyboard_check_pressed(vk_down) or mouse_wheel_down() offset = max(0,offset-1);
}else{
    image_index = 0;
    global.dsmTyping=0
}

if keyboard_check_released(vk_escape){
    keyboard_string = "";
}
    
if global.isHost{
    event_user(0); //forward messages as a host
}else event_user(6); //read messages as a client

if keyboard_check_direct(vk_control) { 
    if keyboard_check_pressed(ord("V")) keyboard_string += clipboard_get_text();
}
')

object_event_clear(global.chatWindow,ev_draw,0)
object_event_add(global.chatWindow,ev_draw,0,'
var xoffset, yoffset, xsize, ysize, index;

xoffset = view_xview[0];
yoffset = view_yview[0];
xsize = sprite_width;
ysize = sprite_height;

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_alpha(1);
if global.chatFontBold==0{
    draw_set_font(global.DSM_ConsoleFont)
}else{
    draw_set_font(global.gg2Font)
}

if !hidden{
    draw_sprite_ext(sprite_index,image_index,xoffset+5,yoffset+280,1,1,0,c_white,global.dsmChatBoxAlpha/100);
}

if !open{
    sprite_index=Chat2S
}else if open{
    sprite_index=ChatS
}

//prevent too long strings
if open{
    keyboard_string = string_copy(keyboard_string,1,230); //limit messages
    //make that the text doesnt go outside the chatwindow
    if string_length(keyboard_string)-45>0{
        index  = string_length(keyboard_string)-44;
    }else{
        index = 0;
    }
    chatmessage = string_copy(keyboard_string,index,45);
    if team == 1{
        if global.myself.team==TEAM_BLUE{
            message="B";
        }else if global.myself.team==TEAM_SPECTATOR{
            message="G";
        }else{
            message = "R";
        }
        event_user(5);
    }
    //chatmessage = string_replace_all(chatmessage,"#","\#");
    draw_text(xoffset + 18, yoffset+274+ysize-15, sanitiseNewlines(chatmessage));
    draw_set_color(c_ltgray)
    if open and keyboard_string==""{
        if team==false{
            placeholderMsg=placeholderMsgGlobal
        }else if team==true{
            placeholderMsg=placeholderMsgTeam
        }
        draw_text(xoffset + 18, yoffset+274+ysize-15, placeholderMsg);
    }
    draw_set_color(c_white)
}
    
// The drawing of the text
var amount;
draw_set_alpha(global.dsmChatTextAlpha/100)
if !hidden{
    amount = min(ds_list_size(global.chatLog),12); //number of lines to show when chat is open
}else if !idle{
    amount = min(ds_list_size(global.chatLog),global.dsmChatLineNumber); //number of lines to show when chat is closed
}else{
    amount = 0;
}
for(i=0;i<amount;i+=1){
    message = ds_list_find_value(global.chatLog, ds_list_size(global.chatLog)-amount+i-offset);
    pos = string_pos("#",message);
    if pos == 0{
        event_user(5); //read the color code
        draw_text(xoffset+20, yoffset+287+ysize-40-12*(amount-i),string_copy(message,2,255))
    }else{
        event_user(5); //read the color code
        prefix = string_copy(message,2,pos-1);
        draw_text(xoffset+20, yoffset+287+ysize-40-12*(amount-i),prefix)
        message = string_copy(message,pos+1,255);
        event_user(5); //read the next color code
        draw_text(xoffset+20+string_width(prefix), yoffset+287+ysize-40-12*(amount-i),string_copy(message,2,255))
    }       
}
draw_set_font(global.gg2Font);
draw_set_alpha(1)
')

object_event_clear(global.chatWindow,ev_other,ev_user0)
object_event_add(global.chatWindow,ev_other,ev_user0,'
    while(PluginPacketGetBuffer(global.chatPacketID) != -1) {
        chatReceiveBuffer = PluginPacketGetBuffer(global.chatPacketID);
        switch(read_ubyte(chatReceiveBuffer)) {
            case 0: //hello
                _player = PluginPacketGetPlayer(global.chatPacketID);
                if ds_list_find_index(global.chatBanlist,socket_remote_ip(_player.socket)) == -1 {  //ignore muted players
                    _player.hasChat = true;
                    _player.nameBkp = _player.name;
                    _message = "O"+_player.name+" has joined chat!";
                    _team = 0;
                    event_user(2); //tell everyone someone joined chat
                    event_user(4); //add to own chat
                }
            break;
            case 1: //global chat
                _player = PluginPacketGetPlayer(global.chatPacketID);
                if _player.hasChat {
                    _team = 0;
                    _len = read_ubyte(chatReceiveBuffer);
                    _message = read_string(chatReceiveBuffer,_len);
                    event_user(1); //process a message
                    event_user(2); //send
                    event_user(4); //add to chatwindow
                    event_user(7); //prevent spamming
                }
            break;
            case 2: //team chat
                _player = PluginPacketGetPlayer(global.chatPacketID);
                if _player.team != TEAM_SPECTATOR && _player.hasChat {
                    _team = 1+_player.team;
                    _len = read_ubyte(chatReceiveBuffer);
                    _message = read_string(chatReceiveBuffer,_len);
                    event_user(1); //process a message
                    event_user(2); //send
                    if global.myself.team == TEAM_SPECTATOR and global.isHost!=true || _team == global.myself.team+1 event_user(4); //add to chatwindow
                    event_user(7); //prevent spamming
                }
            break;
        }
        
        buffer_clear(chatReceiveBuffer);
        PluginPacketPop(global.chatPacketID);
    }
');

object_event_clear(global.chatWindow,ev_other,ev_user1)
object_event_add(global.chatWindow,ev_other,ev_user1,'
if _player.team==TEAM_RED{
    _color = "R";
}else if _player.team==TEAM_BLUE{
    _color = "B";
}else{
    _color = "G";
}
if _team == 0{
    if _player.id==global.myself{
        _message = _color+_player.name+": #Y"+sanitiseNewlines(_message)
    }else{
        _message = _color+_player.name+": #W"+sanitiseNewlines(_message)
    }
}else{
    _message = _color+_player.name+": "+sanitiseNewlines(_message)
}
')

object_event_clear(global.chatWindow,ev_other,ev_user4)
object_event_add(global.chatWindow,ev_other,ev_user4,'
//make the window display the new message
alarm[0]=idleTime;
idle = false;
    
while(string_length(_message) != 0){
    if string_length(_message) > 46{
        ds_list_add(global.chatLog,string_copy(_message,1,46));
        pos = string_pos("#",_message);
        
        if pos==0{
            color = string_copy(_message,1,1);
        }else{
            color = string_copy(_message,pos+1,1);
        }
        
        _message = color+string_copy(_message,47,255);
    }else{
        ds_list_add(global.chatLog,string_copy(_message,1,46));
        _message = "";
    }
}
')

object_event_clear(global.chatWindow,ev_other,ev_user5)
object_event_add(global.chatWindow,ev_other,ev_user5,'
    switch(string_copy(message,1,1)) {
        case "R":
            draw_set_color(make_color_rgb(237,61,61));
            break;
        case "B":
            draw_set_color(make_color_rgb(61,135,218));
            break
        case "O":
            draw_set_color(c_orange);
            break;
        case "Y":
            //draw_set_color(c_yellow)
            draw_set_color(make_color_rgb(224,181,35))
            break;
        case "G":
            draw_set_color(make_color_rgb(10,200,10));
            break;
        default: draw_set_color(c_white);
    }
')

object_event_add(global.chatWindow,ev_destroy,0,'
ds_list_destroy(global.chatLog);
global.dsmTyping=0
')

object_event_add(global.chatWindow,ev_other,ev_user15,'
//chatWriteLogSc()
')

global.dsmChatLoaded=1
