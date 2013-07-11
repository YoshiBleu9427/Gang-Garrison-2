if global.chatFixRun==1 exit
//Tell the user it has been run, mainly for testing purposed
ds_list_add(global.chatLog,"ODSM Chat Fix has been run.")

//Get rid this
object_event_clear(global.chatWindow,ev_step,ev_step_end)
//Replace it with this
object_event_add(global.chatWindow,ev_step,ev_step_end,'
    x = view_xview[0]+7;
    y = view_yview[0]+340;
    if (!instance_exists(InGameMenuController) && !instance_exists(OptionsController) && !instance_exists(ControlsController) && !instance_exists(HUDOptionsController)) || instance_exists(global.cheatycheat) {
        if keyboard_check_pressed(global.chatToggle) && !open {
            if !open hidden = !hidden;
            idle = false;
            alarm[0]=120;
        } else if keyboard_check_pressed(global.chatGlobal) && !open {
            open = true;
            hidden = false;
            keyboard_string="";
            team = false;
            instance_create(0,0,global.cheatycheat);
        }  else if keyboard_check_pressed(global.chatTeam) && global.myself.team != TEAM_SPECTATOR && !open {
            open = true;
            hidden = false;
            keyboard_string="";
            team = true;
            instance_create(0,0,global.cheatycheat);
        } else if open && keyboard_check_pressed(vk_enter) {
            with(global.cheatycheat) instance_destroy();
            if keyboard_string != "" {
                _message = keyboard_string;
                if global.isHost {
                    _player = global.myself;
                    if team == true _team = global.myself.team+1;
                    else _team = 0
                    event_user(1); //process our own message
                    event_user(2); //send our own message to the clients
                    event_user(4); //add our own message to the chatbox
                } else {
                    _team = team;
                    event_user(3); //send a message as a client
                }
                
                keyboard_string="";
            }
            open = false;
            team = false;
            idle = false;
            alarm[0]=120;
        }
    }
    
    if open {        
        image_index = 1;
        if (keyboard_check_pressed(vk_up) or mouse_wheel_up()) && ds_list_size(global.chatLog) > 9 offset = min(ds_list_size(global.chatLog)-10,offset+1);
        else if keyboard_check_pressed(vk_down) or mouse_wheel_down() offset = max(0,offset-1);
    } else image_index = 0;
    
    if global.isHost {
        event_user(0); //forward messages as a host
        with(Player) {
            if hasChat || id == global.myself {
                if name != nameBkp {
                    with(global.chatWindow) {
                        _message = "O"+other.nameBkp+" has changed their name to "+other.name+".";
                        _team = 0;
                        event_user(2); //tell everyone someone changed names
                        event_user(4); //add to own chat
                    }
                    nameBkp = name;
                }
            }
        }
    } else event_user(6); //read messages as a client
');

global.chatFixRun=1
