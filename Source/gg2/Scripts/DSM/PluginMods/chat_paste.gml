if !variable_global_exists('chatWindow') global.chatWindow = object_add();

object_event_add(global.chatWindow,ev_step,ev_step_end,"
    if global.isUsingChat==1{ //chat_v2 only
        if keyboard_check_direct(vk_control) { 
            if keyboard_check_pressed(ord('V')) keyboard_string += clipboard_get_text();
        }
    }
");