var mapName;
mapName = argument0;
menu_addlink(mapName, '
    global.currentMap = "' + mapName + '";
    global.gameServer = instance_create(0,0,GameServer);
');

