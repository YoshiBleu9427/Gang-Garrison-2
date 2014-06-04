//Thanks to Orpheon for all of the console code, and Vindicator for making the original console.
//Called in game_init, not sure if this should go there.

global.consoleIsOpen = 0;//Console is disabled by default, open it by clicking in the in-game menu.
global.consoleLog = ds_list_create()//All text in the console is saved here.
global.commandLog = ds_list_create()//All commands the user gave in are logged here.
global.DSM_commandMap = ds_map_create()//All console commands are here, with the name being the key to the to-be executed string.
global.DSM_documentationMap = ds_map_create()//See above, only this gets called when a user enters "help something".
global.consoleMaxLines = 32
global.playerNameC=""

//For locking teams/classes
//Team
global.locked_red=0
global.locked_blue=0
//Classes
global.locked_scout=0
global.locked_pyro=0
global.locked_soldier=0
global.locked_heavy=0
global.locked_demoman=0
global.locked_medic=0
global.locked_engie=0
global.locked_spy=0
global.locked_sniper=0
global.locked_quote=0

for(i=0; i<global.consoleMaxLines; i+=1){
    ds_list_add(global.consoleLog, "")
}

console_defineCommands()

console_print("Welcome to the DSM "+string(DSM_VERSION_STRING)+" Console!")
console_print('You can get help and a list of all commands by typing just "help".')
console_print('If you need help on a specific command, just type "help command".')
console_print("")
console_print("----------------------------------------------------------------------------------")
console_print("")
