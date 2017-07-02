// argument0: The name of the map to switch to. Must exist (internal or external) otherwise the game will error out.

global.currentMap = argument0;
if (findInternalMapName(global.currentMap) != "")
{
    global.currentMapMD5 = "";
    room_goto_fix(CustomMapRoom);
}
else if(file_exists("Maps/" + global.currentMap + ".png"))
{
    global.currentMapMD5 = CustomMapGetMapMD5(global.currentMap);
    room_goto_fix(CustomMapRoom);
}
else
{
    with(GameServer) {
        instance_destroy();
    }
}

