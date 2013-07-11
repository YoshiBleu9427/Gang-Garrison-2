//sentry end step

//Lorgan's /Updated/ Damage Indicator Plugin (some stuff from Vindicator)
//Some changes by wareya

// Note on dingalings:
// The dingaling played when you deal damage is located at /Plugins/dmgind/dingaling.wav
// To use a different dingaling, rename whatever you wav file you want to dingaling.wav and put it there
// I've included a handful of alternate dingalings in case the included one doesn't work for you

ini_open("gg2.ini");
global.indicator_style = ini_read_real("Plugins","DmgInd_style",1);
global.indicator_playding = ini_read_real("Plugins","DmgInd_sound",1);
global.indicator_move = ini_read_real("Plugins","DmgInd_place",0);
global.indicator_stereo = ini_read_real("Plugins","DmgInd_stereo",0);
//add volume
ini_close();

//make a new menu for plugin options
if !variable_global_exists("neoPluginOptions") {
    global.neoPluginOptions = object_add();
    object_set_parent(global.neoPluginOptions,OptionsController);  
    object_set_depth(global.neoPluginOptions,-130000); 
    object_event_add(global.neoPluginOptions,ev_create,0,'   
        menu_create(40, 140, 300, 200, 30);
        
        if room != Options {
            menu_setdimmed();
        }
        
        menu_addback("Back", "
            instance_destroy();
            if(room == Options)
                instance_create(0,0,MainMenuController);
            else
                instance_create(0,0,InGameMenuController);
        ");
    ');
    
    object_event_add(OptionsController,ev_create,0,'
        /* dumb workaround to make Back occur after Plugin Options */
        items -= 1;
        menu_addlink("Plugin Options", "
            instance_create(0,0,global.neoPluginOptions);
            instance_destroy();
        ");
        menu_addback("Back", "
            instance_destroy();
            if(room == Options)
                room_goto_fix(Menu);
            else
                instance_create(0,0,InGameMenuController);
        ");
    ');
} 

object_event_add(global.neoPluginOptions,ev_create,0,'
    //very dumb workaround
    dmgind_section = "Plugins";
    dmgind_key1 = "DmgInd_style";
    dmgind_key2 = "DmgInd_sound";
    dmgind_key3 = "DmgInd_place";
    dmgind_key4 = "DmgInd_stereo";
    //even dumber workaround
    quote = chr(39);

    menu_addedit_select("Damage indicator style", "global.indicator_style", "
        gg2_write_ini(dmgind_section, dmgind_key1, argument0);
    ");
    menu_add_option(0, "Wareya"+quote+"s");
    menu_add_option(1, "Lorgan"+quote+"s");
    
    menu_addedit_boolean("Ding sound on hit", "global.indicator_playding", "
        gg2_write_ini(dmgind_section, dmgind_key2, argument0);
    ");
    
    menu_addedit_boolean("Move counter for HUDs", "global.indicator_move", "
        gg2_write_ini(dmgind_section, dmgind_key3, argument0);
    ");
    
    menu_addedit_boolean("Ding sound is stereo", "global.indicator_stereo", "
        gg2_write_ini(dmgind_section, dmgind_key4, argument0);
    ");
');


if file_exists("Plugins/dmgind/dingaling.wav") {
    global.indicator_ding = sound_add("Plugins/dmgind/dingaling.wav",0,1);
    sound_volume(global.indicator_ding, 1.0); // Edit this to change dingaling volume
} else exit;


//the smaller number above people who you're damaging
global.indicator = object_add();
//the larger number that accumulates your damage next to your healthhud
global.indicator2 = object_add();

global.indicator_offwhite = make_color_rgb(217,217,183);



//this needs to be done or desync spams random '-5' messages when you damage medics
object_event_clear(Medic,ev_alarm,11);
object_event_add(Medic,ev_alarm,11,"
    if(global.isHost)
    {
        hp += 5;
        alarm[11] = 30;
    }
");
